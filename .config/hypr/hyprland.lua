local terminal = "wezterm"
local vault = 'cd ~/Vault && neovide main-hub.md "+ObsidianQuickSwitch"'
local obsidian = "obsidian --no-sandbox --ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations"
local fileManager = "thunar"
local menu = "pgrep -x rofi > /dev/null && pkill -x rofi; rofi -drun-exclude-categories Game -show-icons -show combi -modi combi -combi-modi \"websearch:~/.dotfiles/scripts/rofi-web-search.sh,drun\" -combi-display-format \"{text}\" -no-sidebar-mode"
local power = "pgrep -x rofi > /dev/null && pkill -x rofi; ~/.config/waybar/scripts/power-menu.sh"
local window = "pgrep -x rofi > /dev/null && pkill -x rofi; rofi -show window -show-icons -no-sidebar-mode"
local run = "pgrep -x rofi > /dev/null && pkill -x rofi; rofi -show run -show-icons -no-sidebar-mode"
local game = "pgrep -x rofi > /dev/null && pkill -x rofi; rofi -drun-categories Game -show-icons -show combi -modi combi -combi-modi \"websearch:~/.dotfiles/scripts/rofi-web-search.sh,drun\" -combi-display-format \"{text}\" -no-sidebar-mode"
local clip = "pgrep -x rofi > /dev/null && pkill -x rofi; cliphist list | rofi -dmenu | cliphist decode | wl-copy"
local clipDel = "pgrep -x rofi > /dev/null && pkill -x rofi; cliphist list | rofi -dmenu | cliphist delete"
local emoji = "pgrep -x rofi > /dev/null && pkill -x rofi; rofimoji -a copy --files emojis_activities emojis_animals_nature emojis_component emojis_flags emojis_food_drink emojis_objects emojis_people_body emojis_smileys_emotion emojis_symbols emojis_travel_places emoticons gitmoji kaomoji nerd_font number_forms ornamental_dingbats small_form_variants superscripts_and_subscripts supplemental_arrows-a supplemental_arrows-b supplemental_arrows-c supplemental_mathematical_operators supplemental_punctuation supplemental_symbols_and_pictographs symbols_and_pictographs_extended-a symbols_for_legacy_computing symbols_for_legacy_computing_supplement weathericons"
local emojiMost = "pgrep -x rofi > /dev/null && pkill -x rofi; rofimoji -a copy --files alchemical_symbols arrows basic_latin block_elements box_drawing braille_patterns chess_symbols control_pictures counting_rod_numerals currency_symbols dingbats emojis_activities emojis_animals_nature emojis_component emojis_flags emojis_food_drink emojis_objects emojis_people_body emojis_smileys_emotion emojis_symbols emojis_travel_places emoticons fileicons fontawesome6 gitmoji kaomoji latin-1_supplement latin_extended_additional mahjong_tiles math mathematical_alphanumeric_symbols mathematical_operators miscellaneous_mathematical_symbols-a miscellaneous_mathematical_symbols-b miscellaneous_symbols_and_arrows miscellaneous_symbols_and_pictographs miscellaneous_symbols miscellaneous_technical musical_symbols nerd_font number_forms ornamental_dingbats playing_cards small_form_variants spacing_modifier_letters superscripts_and_subscripts supplemental_arrows-a supplemental_arrows-b supplemental_arrows-c supplemental_mathematical_operators supplemental_punctuation supplemental_symbols_and_pictographs symbols_and_pictographs_extended-a symbols_for_legacy_computing symbols_for_legacy_computing_supplement weathericons"
local emojiAll = "pgrep -x rofi > /dev/null && pkill -x rofi; rofimoji -a copy --files all # NOTE: Emojis location: /usr/lib/python3.13/site-packages/picker/data/"

local screenshotArea = "grimblast --notify --freeze copysave area"
local screenshotActive = "grimblast --notify --freeze copysave active"
local screenshotScreen = "grimblast --notify --freeze copysave screen"
local picker = "pgrep -x hyprpicker > /dev/null && pkill -x hyprpicker || hyprpicker | wl-copy"
local pickText = "grimblast --freeze save area /tmp/ocr.png && tesseract /tmp/ocr.png - | wl-copy"

local paper = "~/.config/hypr/scripts/hyprpaper.sh"
local defaultPaper = "~/.config/hypr/scripts/hyprpaper.sh default"
local dataStream = "~/.dotfiles/scripts/data-stream.sh"
local bar = "pkill -x -SIGUSR1 waybar"
-- TODO: Fix smart gaps and opacity scripts
-- local gaps = "~/.config/hypr/scripts/toggle-smart-gaps.sh"
-- local opacity = "~/.config/hypr/scripts/opacity-control.sh"

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpaper")
    hl.exec_cmd("systemctl --user start hypridle")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start waybar")
    hl.exec_cmd("systemctl --user start kanata")
    hl.exec_cmd("systemctl --user start obsidian-daily-commit")

    hl.exec_cmd("~/.config/hypr/scripts/hyprpaper.sh start")
    hl.exec_cmd("~/.config/hypr/scripts/ddcci-bind.sh")

    hl.exec_cmd("wl-paste --watch cliphist store")

    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("otd-daemon")

    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme \"Milk-Outside-a-Bag-of-Milk\"")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")

    hl.exec_cmd(terminal, { workspace = "special:scratch silent" })
    hl.exec_cmd(vault, { workspace = "special:note silent" })
    hl.exec_cmd("chromium", { workspace = "2 silent" })
    hl.exec_cmd("protonvpn-app --start-minimized")
    hl.exec_cmd("~/.local/share/bin/Artemis/Artemis.UI.Linux --minimized")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.monitor({ output = "", mode = "highres", position = "auto", scale = "auto" })

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "0", monitor = "HDMI-A-1" })

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(ff0f0fee)", "rgba(880808ee)" },
                angle = 75
            },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        middle_click_paste = false,
        animate_manual_resizes = true,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "compose:prsc",
        kb_rules = "",

        numlock_by_default = true,
        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },

    group = {
        col = {
            border_active = {
                colors = { "rgba(7708a7cc)", "rgba(7611fbcc)" },
                angle = 75,
            },
            border_inactive = {
                colors = { "rgba(7708a7cc)", "rgba(7611fbcc)" },
                angle = 75,
            },
            border_locked_inactive = {
                colors = { "rgba(888888ee)", "rgba(333333ee)" },
                angle = 75,
            },
        },

        groupbar = {
            font_family = "JetBrainsMono NF ExtraBold",
            font_size = 16,
            scrolling = false,
        }
    }
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
hl.gesture({
    fingers = 3,
    direction = "down",
    action = "special",
    workspace_name = "scratch",
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = "special",
    workspace_name = "note",
})

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.device({
    name = "dualsense-wireless-controller-touchpad",
    enabled = false
})
hl.device({
    name = "sony-interactive-entertainment-dualsense-wireless-controller-touchpad",
    enabled = false
})

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh down"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset temperature +250"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset temperature -250"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("SUPER + T", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + CTRL + C", hl.dsp.exec_cmd(vault))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(obsidian))
hl.bind("SUPER + X", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + CTRL + R", hl.dsp.exec_cmd(power))
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd(window))
hl.bind("SUPER + CTRL + SHIFT + R", hl.dsp.exec_cmd(run))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd(game))
hl.bind("SUPER + V", hl.dsp.exec_cmd(clip))
hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd(clipDel))
hl.bind("SUPER + M", hl.dsp.exec_cmd(emoji))
hl.bind("SUPER + CTRL + M", hl.dsp.exec_cmd(emojiMost))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd(emojiAll))

hl.bind("SUPER + N", hl.dsp.exec_cmd(screenshotArea))
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd(screenshotActive))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd(screenshotScreen))
hl.bind("SUPER + P", hl.dsp.exec_cmd(picker))
hl.bind("SUPER + CTRL + P", hl.dsp.exec_cmd(pickText))

hl.bind("SUPER + W", hl.dsp.exec_cmd(paper))
hl.bind("SUPER + CTRL + W", hl.dsp.exec_cmd(defaultPaper))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd(dataStream))

hl.bind("SUPER + B", hl.dsp.exec_cmd(bar))

-- TODO: Fix smart gaps and opacity scripts
-- hl.bind("SUPER + G", hl.dsp.exec_cmd(gaps))
-- hl.bind("SUPER + minus", hl.dsp.exec_cmd(opacity .. "decrease"))
-- hl.bind("SUPER + equal", hl.dsp.exec_cmd(opacity .. "increase"))

hl.bind("SUPER + I", hl.dsp.focus({ workspace = "previous" }))
hl.bind("SUPER + CTRL + I", hl.dsp.workspace.swap_monitors({ monitor1 = "DP-1", monitor2 = "HDMI-A-1" }))
hl.bind("SUPER + D", hl.dsp.window.pseudo())
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + O", hl.dsp.layout("togglesplit"))

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratch"))
hl.bind("SUPER + C", hl.dsp.workspace.toggle_special("note"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch" }))
hl.bind("SUPER + SHIFT + C", hl.dsp.window.move({ workspace = "special:note" }))

hl.bind("SUPER + CTRL + G", hl.dsp.group.toggle())
hl.bind("SUPER + tab", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + tab", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + tab", hl.dsp.group.move_window())
hl.bind("SUPER + CTRL + SHIFT + tab", hl.dsp.group.move_window({ forward = false }))

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + ALT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + ALT + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))

hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))

hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true}), { repeating = true })
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true}), { repeating = true })
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -40, relative = true}), { repeating = true })
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

hl.bind("SUPER + CTRL + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

hl.bind("SUPER + ALT + CTRL + left", hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind("SUPER + ALT + CTRL + right", hl.dsp.window.move({ direction = "r", group_aware = true }))
hl.bind("SUPER + ALT + CTRL + up", hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind("SUPER + ALT + CTRL + down", hl.dsp.window.move({ direction = "d", group_aware = true }))

-- LAYOUT DEPENDENT
hl.bind("SUPER + Y", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + E", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + A", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + ALT + Y", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + ALT + E", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + ALT + SHIFT + Y", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + ALT + SHIFT + E", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + SHIFT + Y", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + E", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + CTRL + Y", hl.dsp.window.resize({ x = "-40", y = "0", relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + E", hl.dsp.window.resize({ x = "40", y = "0", relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + A", hl.dsp.window.resize({ x = "0", y = "-40", relative = true }), { repeating = true }) 
hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = "0", y = "40", relative = true}), { repeating = true })
hl.bind("SUPER + CTRL + SHIFT + Y", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + SHIFT + E", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + SHIFT + A", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + SHIFT + H", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + ALT + CTRL + Y", hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind("SUPER + ALT + CTRL + E", hl.dsp.window.move({ direction = "r", group_aware = true }))
hl.bind("SUPER + ALT + CTRL + A", hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind("SUPER + ALT + CTRL + H", hl.dsp.window.move({ direction = "d", group_aware = true }))

-- hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
-- hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
-- hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
-- hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
-- hl.bind("SUPER + ALT + H", hl.dsp.focus({ workspace = "e-1" }))
-- hl.bind("SUPER + ALT + L", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind("SUPER + ALT + SHIFT + H", hl.dsp.window.move({ workspace = "-1" }))
-- hl.bind("SUPER + ALT + SHIFT + L", hl.dsp.window.move({ workspace = "+1" }))
-- hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ workspace = "-1" }))
-- hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ workspace = "+1" }))
-- hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = "-40", y = "0", relative = true }), { repeating = true })
-- hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = "40", y = "0", relative = true }), { repeating = true })
-- hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = "0", y = "-40", relative = true }), { repeating = true })
-- hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = "0", y = "40", relative = true }), { repeating = true })
-- hl.bind("SUPER + CTRL + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
-- hl.bind("SUPER + CTRL + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
-- hl.bind("SUPER + CTRL + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
-- hl.bind("SUPER + CTRL + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
-- hl.bind("SUPER + ALT + CTRL + H", hl.dsp.window.move({ direction = "l", group_aware = true }))
-- hl.bind("SUPER + ALT + CTRL + L", hl.dsp.window.move({ direction = "r", group_aware = true }))
-- hl.bind("SUPER + ALT + CTRL + K", hl.dsp.window.move({ direction = "u", group_aware = true }))
-- hl.bind("SUPER + ALT + CTRL + J", hl.dsp.window.move({ direction = "d", group_aware = true }))
