-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

-- config.window_background_opacity = 0.8
-- config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.native_macos_fullscreen_mode = true

config.font_size = 16.0
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'

-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "terafox"
config.color_scheme = "Kanagawa (Gogh)"
config.colors = {
	-- background = "#0c0b0f", -- dark purple
	-- background = "#0f0f14", -- dark purple
    tab_bar = {
        background = "rgba(0,0,0,0.8)"
    },
}

config.window_decorations = "NONE | RESIZE"

config.keys = {
	-- Define a custom key binding for closing the current pane
	{ key="w", mods="CTRL|SHIFT", action=wezterm.action{ CloseCurrentPane={ confirm=true } } },
    -- { key = "Tab", action = wezterm.action.SendKey{key = "Escape"} },
    -- { key = "Escape", action = wezterm.action.SendKey{key = "Tab"} },
    { key = ";", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") },
    -- Switch to the default workspace
    {
        key = 'y',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'default',
        },
    },
    -- Switch to a monitoring workspace, which will have ⁠ top ⁠ launched into it
    {
        key = 'u',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'monitoring',
            spawn = {
                args = { 'top' },
            },
        },
    },
    -- Create a new workspace with a random name and switch to it
    { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
    -- Show the launcher in fuzzy selection mode and have it list all workspaces
    -- and allow activating one.
    {
        key = '9',
        mods = 'ALT',
        action = act.ShowLauncherArgs {
            flags = 'FUZZY|WORKSPACES',
        },
    },
    {
        key = 'W',
        mods = 'CTRL|SHIFT|ALT',
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be ⁠ nil ⁠ if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        key = 'E',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            initial_value = 'My Tab Name',
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be ⁠ nil ⁠ if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
}

config.ssh_domains = {
  {
    -- This name identifies the domain
    name = 'pc',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = '192.168.178.71',
    -- The username to use on the remote host
    username = 'topi',
  },
}

local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

-- and finally, return the configuration to wezterm
return config
