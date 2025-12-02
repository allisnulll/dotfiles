# Functions
function c() {
    if [[ -n $TMUX_POPUP ]]; then
        clear && fastfetch --config ~/.config/fastfetch/small.jsonc
    elif [[ -n $TMUX && $(tmux display-message -p "#S") == "🏠 Home" ]]; then
        cd && clear && fastfetch
    else
        clear
    fi
}

function mkc() {
    mkdir -p $1
    cd $1
}

function ..() {
    cd $(printf "%0.0s../" $(seq 1 $1));
}

# TODO: Fix sw()
# function sw() {
#     if [ $# -ne 2 ]; then
#         echo "Usage: swap_files <file1> <file2>"
#         return 1
#     fi
#
#     if [ ! -f $1 ]; then
#         echo "Error: $1 does not exist or is not a regular file."
#         return 1
#     fi
#     if [ ! -f $2 ]; then
#         echo "Error: $2 does not exist or is not a regular file."
#         return 1
#     fi
#
#     mkdir -p /tmp/sw
#
#     local temp_file
#     temp_file=$(mktemp /tmp/sw/$(basename $1).XXXXXX)
#
#     \cp -f $1 $temp_file
#     if [ $? -ne 0 ]; then
#         echo "Error: Failed to copy $1 to temporary file."
#         return 1
#     fi
#
#     mv -f "$2" "$1"
#     if [ $? -ne 0 ]; then
#         echo "Error: Failed to move $2 to $1."
#         return 1
#     fi
#     mv -f "$temp_file" "$2"
#     if [ $? -ne 0 ]; then
#         echo "Error: Failed to move temporary file to $2"
#         return 1
#     fi
#
#     echo "Successfully swapped $1 and $2"
# }

# Sesh Alt-S
function sesh-sessions() {
    exec </dev/tty
    exec <&1
    local session

    session=$(sesh list -d | awk "{
        esc = sprintf(\"%c\",27)
        while (getline line > 0) {
            str = gensub(/#\\[fg=#000000\\]/,esc \"[0m\",\"g\",line)
            str = gensub(/#\\[fg=(#[0-9a-fa-f]{6})\\]/,esc \"[38;2;\\\\1m\",\"g\",str)
            if (match(str,/#[0-9a-fa-f]{6}/)) {
                hex = substr(str,RSTART,RLENGTH)
                r = strtonum(\"0x\" substr(hex,2,2))
                g = strtonum(\"0x\" substr(hex,4,2))
                b = strtonum(\"0x\" substr(hex,6,2))
                rgb = r \";\" g \";\" b
                str = substr(str,1,RSTART-1) rgb substr(str,RSTART+RLENGTH)
            }
            print str \"@@\" line
        }
    }" | fzf --ansi --height 40% --reverse --border-label "  Sesh " --border --prompt "  " --scroll-off=2 \
                    --delimiter "@@" --with-nth {1} --bind "enter:become(echo {2})")

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
        echo "--------------------------------------------------------------------------------"
        echo "    DIFF FOR COMMIT: $commit_hash $commit_message"
        echo "--------------------------------------------------------------------------------"
        gsh $commit_hash
    done
}

# Aha
chromium-view() {
    mkdir -p /tmp/aha
    local temp_file
    temp_file=$(mktemp /tmp/aha/aha_XXXXXX.html)
    cat | aha --black > $temp_file
    chromium --new-window $temp_file
    echo $temp_file
}

# Yazi
function y() {
	local tmp=$(mktemp -t yazi-cwd.XXXXXX) cwd
	yazi $@ --cwd-file=$tmp
	IFS= read -r -d "" cwd < $tmp
	[ -n $cwd ] && [ $cwd != $PWD ] && builtin cd -- $cwd
	rm -f -- $tmp
}

# Unzip
function unz() {
    unzip $1 -d ${1%.zip}
}

# Flutter
function flw() {
    tmux send-keys "c && adbr && flr --pid-file=/tmp/tf1.pid" Enter \;\
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

function avd() {
    adb connect 192.168.1.215:5555 
    tmux send-keys "c && adbr && flr --pid-file=/tmp/tf1.pid" Enter \;\
         split-window -h \;\
         send-keys "scrcpy --max-size 1080" Enter \;\
         resize-pane -x 40% -t 1 \;\
         select-pane -t 0
}

function wsa() {
    adb connect 192.168.1.215:58526 
    tmux send-keys "c && adbr && flrw --pid-file=/tmp/tf1.pid" Enter \;\
         split-window -h \;\
         send-keys "scrcpy --crop 720:1346:1840:34 --max-size 1080" Enter \;\
         resize-pane -x 40% -t 1 \;\
         select-pane -t 0
}
