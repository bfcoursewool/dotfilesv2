-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Argonaut'

local act = wezterm.action

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.0

config.keys = {
  -- Make CMD-Left equivalent to Alt-b which many line editors interpret as backward-word
  { key = 'LeftArrow', mods = 'CMD', action = act.SendString '\x1bb' },
  -- Make CMD-Right equivalent to Alt-f; forward-word
  { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x1bf' },
  -- Makes <CMD> + Delete delete the whole line
  { key = 'Delete', mods = 'CMD', action = act.SendKey {key = 'u', mods = 'CTRL'} },
  -- Makes <CMD> + Backspace delete a word
  { key = 'Backspace', mods = 'CMD', action = act.SendKey {key = 'w', mods = 'CTRL'} },
} 

config.debug_key_events = true

config.enable_tab_bar = false
config.window_background_opacity = 0

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

-- and finally, return the configuration to wezterm
return config

