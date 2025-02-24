local wezterm = require("wezterm")

local function adjust_transparency(window, delta)
    local overrides = window:get_config_overrides() or {}
    overrides.window_background_opacity = overrides.window_background_opacity or .5
    overrides.window_background_opacity = overrides.window_background_opacity + delta

    overrides.window_background_opacity = math.max(0, math.min(1, overrides.window_background_opacity))

    window:set_config_overrides(overrides)
end

local config = wezterm.config_builder()

config.enable_wayland = true
config.default_prog = { "zsh", "-i", "-c", "sesh connect 🏠 Main; exec zsh" }

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_background_opacity = .5
config.window_close_confirmation = "NeverPrompt"
config.font = wezterm.font("JetBrainsMono Nerd Font")

config.keys = {
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "p",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

    {
        key = "Tab",
        mods = "CTRL",
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        key = "Tab",
        mods = "CTRL|SHIFT",
        action = wezterm.action.DisableDefaultAssignment,
    },

    {
        key = "Enter",
        mods = "CTRL",
        action = wezterm.action.SendKey({ key = "F13" }),  -- NOTE: For some reason sends f+2
    },

    {
        key = "-",
        mods = "ALT",
        action = wezterm.action_callback(function(window, _)
            adjust_transparency(window, -.05)
        end),
    },
    {
        key = "=",
        mods = "ALT",
        action = wezterm.action_callback(function(window, _)
            adjust_transparency(window, .05)
        end),
    },

    {
        key = "L",
        mods = "CTRL|SHIFT",
        action = wezterm.action.EmitEvent("toggle-ligature"),
    },
}

wezterm.on("toggle-ligature", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.harfbuzz_features then
        overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
    else
        overrides.harfbuzz_features = nil
    end
    window:set_config_overrides(overrides)
end)

-- Zenmode Function
wezterm.on("user-var-changed", function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end
    window:set_config_overrides(overrides)
end)

return config
