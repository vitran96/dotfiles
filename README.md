# DOT FILES repo

## Presiquite

Setup chezmoi param file at `$HOME/.config/chezmoi/chezmoi.toml`

Please refer [chezmoi.dev.toml](chezmoid.dev.toml) file.

## Chezmoi command

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

## Templating

https://www.chezmoi.io/user-guide/templating/

## General doc

https://www.chezmoi.io/user-guide/machines/general/?utm_source=chatgpt.com#determine-how-many-cpu-cores-and-threads-the-current-machine-has