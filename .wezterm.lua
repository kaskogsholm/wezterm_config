-- Pull in the wezterm API
local wezterm = require 'wezterm'
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

-- This will hold the configuration.
local config = wezterm.config_builder()
wezterm.log_error('Version ' .. wezterm.version)
-- This is where you actually apply your config choices

-- For example, changing the color scheme:

-- config.default_prog = { 'C:/Windows/system32/wsl.exe', '-d','Ubuntu' }
-- config.window_background_opacity = 1
config.color_scheme = 'Argonaut'
config.wsl_domains = {
    {
        name = 'WSL:Ubuntu',
        distribution = 'Ubuntu',
        default_cwd = '~'
    },
}
config.default_domain = 'WSL:Ubuntu'

config.skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
    'nu',
    'cmd.exe',
    'pwsh.exe',
    'powershell.exe',
    'wsl.exe',
    'wezterm.exe',
  }
config.keys = {
{
    key = 'x',
    mods = 'SHIFT|ALT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
},
{
    key = '|',
    mods = 'SHIFT|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
},
{
    key = '_',
    mods = 'SHIFT|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
},
-- make pastes work in windows
{ key = 'v', mods = 'CTRL', action = wezterm.action.Nop },
}
local dimmer = { brightness = 0.3 }
config.background = {
    -- This is the deepest/back-most layer. It will be rendered first
    {
      source = {
        File = 'C:\\Users\\karst\\lorenz.png',
      },
      -- The texture tiles vertically but not horizontally.
      -- When we repeat it, mirror it so that it appears "more seamless".
      -- An alternative to this is to set `width = "100%"` and have
      -- it stretch across the display
      repeat_x = 'Mirror',
      hsb = dimmer,
      -- When the viewport scrolls, move this layer 10% of the number of
      -- pixels moved by the main viewport. This makes it appear to be
      -- further behind the text.
      attachment = { Parallax = 0 },
    }, 
}
config.font= wezterm.font("MesloLGS NF")
-- smart splits!
smart_splits.apply_to_config(config, {
    -- the default config is here, if you'd like to use the default keys,
    -- you can omit this configuration table parameter and just use
    -- smart_splits.apply_to_config(config)
  
    -- directional keys to use in order of: left, down, up, right
    direction_keys = { 'h', 'j', 'k', 'l' },
    -- if you want to use separate direction keys for move vs. resize, you
    -- can also do this:
    
    -- modifier keys to combine with direction_keys
    modifiers = {
      move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
      resize = 'ALT', -- modifier to use for pane resize, e.g. META+h to resize to the left
    },
  })
-- and finally, return the configuration to wezterm
return config