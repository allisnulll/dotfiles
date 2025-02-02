# Functions
function mkc() {
    mkdir -p $1
    cd $1
}

function sw() {
    if [ $# -ne 2 ]; then
        echo "Usage: swap_files <file1> <file2>"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: '$1' does not exist or is not a regular file."
        return 1
    fi
    if [ ! -f "$2" ]; then
        echo "Error: '$2' does not exist or is not a regular file."
        return 1
    fi

    local temp_file
    temp_file=$(mktemp /tmp/sw/swap.XXXXXX)

    /bin/cp -f "$1" "$temp_file"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to copy '$1' to temporary file."
        return 1
    fi

    mv -f "$2" "$1"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to move '$2' to '$1'."
        return 1
    fi

    mv -f "$temp_file" "$2"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to move temporary file to '$2'."
        return 1
    fi

    echo "Successfully swapped '$1' and '$2'."
}

function ..() {
    cd $(printf "%0.0s../" $(seq 1 $1));
}

# Sesh Alt-S
function sesh-sessions() {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
}
zle -N sesh-sessions
bindkey -M emacs "\es" sesh-sessions
bindkey -M vicmd "\es" sesh-sessions
bindkey -M viins "\es" sesh-sessions

# Git
function ghistory() {
    git log --reverse --format="%H %s" $1 $2 | while read commit_hash commit_message; do
        echo "------------------------------------------------------------------------------------------"
        echo "    DIFF FOR COMMIT: $commit_hash $commit_message"
        echo "------------------------------------------------------------------------------------------"
        gsh $commit_hash
    done
}

# Unzip
function unz() {
    unzip "$1" -d "${1%.zip}"
}

# Aha
chromium-view() {
    local temp_file
    temp_file=$(mktemp /tmp/aha/aha_XXXXXX.html)
    "$@" | aha --black > $temp_file
    chromium --new-window $temp_file
    echo $temp_file
}

# Flutter
function flw() {
    tmux send-keys "c && flr --pid-file=/tmp/tf1.pid" Enter \;\
         split-window -v \;\
         send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;\
         resize-pane -y 30% -t 1
    if [ -e "./emulators_data" ]; then
        tmux split-window -h \;\
             send-keys 'pkill -f "firebase"' Enter \;\
             send-keys "c && fle" Enter \;\
             resize-pane -x 40% -t 1 \;\
             select-pane -t 0
    fi
}

function ftc() {
    if flutter test --coverage; then
        if genhtml coverage/lcov.info -o coverage; then
            nohup chromium --new-window coverage/index.html > /dev/null 2>&1 &
        else
            echo "genhtml failed."
        fi
    else
        echo "Flutter tests failed."
    fi
}

function wsa() {
    c
    adb connect 192.168.1.215:58526 
    tmux send-keys "flrw" Enter \;\
         split-window -h \;\
         send-keys "scrcpy --crop 780:1400:1620:40" Enter \;\
         resize-pane -x 40% -t 1 \;\
         select-pane -t 0
}
