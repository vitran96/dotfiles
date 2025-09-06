# DOT FILES repo

|     | File                                               | Symlink path                                                   | OS      | Note |
| --- | -------------------------------------------------- | -------------------------------------------------------------- | ------- | ---- |
| 1   | .bashrc                                            | ~/.bashrc                                                      | Linux   |      |
| 2   | .bash_aliases                                      | ~/.bash_aliases                                                | Linux   |      |
| 3   | .bash_completion                                   | ~/.bash_completion                                             | Linux   |      |
| 4   | .zshrc                                             | ~/.zshrc                                                       | Linux   |      |
| 5   | .zshenv                                            | ~/.zshenv                                                      | Linux   |      |
| 6   | gh/config.yml                                      | ~/.config/gh/config.yml                                        | Linux   |      |
| 7   | flameshot/flameshot.ini                            | ~/.config/flameshot/flameshot.ini                              | Linux   |      |
| 8   | alacrity/alacritty.yml                             | ~/.config/alacritty/alacritty.yml                              | Linux   |      |
| 9   | wezterm/                                           | ~/.config/wezterm                                              | Linux   |      |
| 10  | PowerToys/config.json                              | ~/AppData/Local/Microsoft/PowerToys/settings.json              | Windows |      |
| 11  | WindowsPowershell/Microsoft.PowerShell_profile.ps1 | ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 | Windows |      |
| 12  | WinTerminal/settings.json                          | ~/AppData/Local/Microsoft/Windows Terminal/settings.json       | Windows |      |
| 13  | .spacemacs                                         | ~/.spacemacs                                                   | Linux   |      |
| 14  | nvim/init.vim                                      | ~/.config/nvim/init.vim                                        | Linux   |      |
| 15  | .zimrc                                             | ~/.zimrc                                                       | Linux   |      |
| 16  | fcitx5/                                            | ~/.config/fcitx5/                                              | Linux   |      |

## Chezmoi

```shell
chezmoi add <file>
chezmoi add --follow <symlink>

chezmoi add --exact --recursive <folder>

# if add folder with external file
chezmoi add <folder>/.keep
chezmoi add --exact --recursive <folder>

# apply existing repo
chezmoi init --apply <repo>

# apply change
chezmoi apply

# try change
chezmoi apply --dry-run --verbose
```

## Ignore file on different directory
Mix the template feature & ignore to allow reuse config file on different machine

https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/#ignore-files-or-a-directory-on-different-machines#ignore-files-or-a-directory-on-different-machines

# General doc

https://www.chezmoi.io/user-guide/machines/general/?utm_source=chatgpt.com#determine-how-many-cpu-cores-and-threads-the-current-machine-has