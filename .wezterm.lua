local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end
config.color_scheme = 'Default (light) (terminal.sexy)'
config.colors = {
    background="#faf2eb";
    cursor_bg="#000000";
    cursor_fg="#ffffff";
}
config.font_size = 15
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.keys = {
  {
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal{domain='CurrentPaneDomain'},
  },
  {
    key = 'Enter',
    mods = 'SHIFT|CMD',
    action = wezterm.action.SplitVertical{domain='CurrentPaneDomain'},
  },
  {
    key = 'h',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'j',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
}
return config
