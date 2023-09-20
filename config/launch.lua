local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   options.default_prog = { 'powershell' }
   options.launch_menu = {
      -- { label = 'PowerShell Core', args = { 'pwsh' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt', args = { 'cmd' } },
      -- { label = 'Nushell', args = { 'nu' } },
      {
         label = 'Git Bash',
         args = { 'C:\\Users\\kevin\\scoop\\apps\\git\\current\\bin\\bash.exe' },
      },
      {
         label = 'dev-os',
         args = { 'ssh', 'tianer@192.168.1.49', '-p', '22' },
      },
      {
         label = '192.168.1.41',
         args = { 'ssh', 'root@192.168.1.41', '-p', '22' },
      },
      {
         label = '192.168.1.118',
         args = { 'ssh', 'root@192.168.1.118', '-p', '22' },
      },
      {
         label = '192.168.1.128',
         args = { 'ssh', 'root@192.168.1.128', '-p', '22' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu' } },
      { label = 'Zsh', args = { 'zsh' } },
   }
end

return options
