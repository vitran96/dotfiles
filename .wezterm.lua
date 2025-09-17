-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
-- config.font_size = 10
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Gogh (Gogh)'

-- Transparency settings
-- config.window_background_opacity = 1.0

-- Tab helper for Windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Check if pwsh exists
  -- TODO: should split into a function
  if os.execute("where pwsh.exe > NUL 2>&1") == 0 then
      table.insert(config.launch_menu, {
        label = 'PowerShell 7+',
        args = { 'pwsh.exe', '-NoLogo' },
      })
  end

  table.insert(config.launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(config.launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
else
  local session_type = os.getenv("XDG_SESSION_TYPE")
  config.enable_wayland = session_type == "wayland"
end

-- Font
config.font = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font',
  'JetBrainsMono NF',
  'monospace',
}

config.default_cursor_style = 'SteadyBar'

-- Key bindings
-- Possible Modifier labels are:
--     SUPER, CMD, WIN - these are all equivalent: on macOS the Command key, on Windows the Windows key, on Linux this can also be the Super or Hyper key. Left and right are equivalent.
--     CTRL - The control key. Left and right are equivalent.
--     SHIFT - The shift key. Left and right are equivalent.
--     ALT, OPT, META - these are all equivalent: on macOS the Option key, on other systems the Alt or Meta key. Left and right are equivalent.
--     LEADER - a special modal modifier state managed by wezterm. See Leader Key for more information.
--     VoidSymbol - This keycode is emitted in special cases where the original function of the key has been removed. Such as in Linux and using setxkbmap. setxkbmap -option caps:none. The CapsLock will no longer function as before in all applications, instead emitting VoidSymbol
-- config.keys = {
--   -- Turn off the default CMD-m Hide action, allowing CMD-m to
--   -- be potentially recognized and handled by the tab
--   {
--     key = 'm',
--     mods = 'CMD',
--     action = wezterm.action.DisableDefaultAssignment,
--   },
-- }

-- timeout_milliseconds defaults to 1000 and can be omitted
-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
-- config.keys = {
--   {
--     key = '|',
--     mods = 'LEADER|SHIFT',
--     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
--   },
--   -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
--   {
--     key = 'a',
--     mods = 'LEADER|CTRL',
--     action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
--   },
-- }

-- Key binding advance: https://wezterm.org/config/key-tables.html

-- https://wezterm.org/config/lua/config/window_decorations.html
config.window_decorations = "TITLE | RESIZE"

-- Finally, return the configuration to wezterm:
return config