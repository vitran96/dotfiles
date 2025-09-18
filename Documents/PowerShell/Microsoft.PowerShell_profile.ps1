# Alias
# Set-Alias sudo gsudo
Set-Alias ls lsd
Set-Alias grep rg
Set-Alias find fd

function Load-ProfileD {
  [CmdletBinding()]
  param(
    [string]$ProfilePath = $PROFILE,
    [string]$DirName = 'module.d',
    [switch]$CreateIfMissing = $true,
    [switch]$Quiet
  )

  $baseDir = Split-Path -Parent $ProfilePath
  if (-not $baseDir) {
    Write-Error "Cannot resolve directory for '$ProfilePath'."
    return
  }

  $dir = Join-Path -Path $baseDir -ChildPath $DirName

  if (-not (Test-Path -Path $dir)) {
    if ($CreateIfMissing) {
      New-Item -Path $dir -ItemType Directory -Force | Out-Null
      if (-not $Quiet) { Write-Verbose "Created directory: $dir" }
    } else {
      if (-not $Quiet) { Write-Verbose "Directory not found: $dir" }
      return
    }
  }

  $files = Get-ChildItem -Path $dir -File -Force -ErrorAction SilentlyContinue |
           Where-Object { @('.ps1','.psm1') -contains $_.Extension.ToLower() } |
           Sort-Object -Property Name

  if (-not $files) {
    if (-not $Quiet) { Write-Verbose "No files to load in $dir" }
    return
  }

  $successes = [System.Collections.Generic.List[string]]::new()
  $failures  = [System.Collections.Generic.List[psobject]]::new()

  foreach ($f in $files) {
    $full = $f.FullName
    if (-not $Quiet) { Write-Verbose "Loading: $full" }

    try {
      $old = $ErrorActionPreference
      $ErrorActionPreference = 'Stop'

      switch ($f.Extension.ToLower()) {
        '.ps1' { . $full }
        '.psm1' { Import-Module -Name $full -Force -ErrorAction Stop }
        default { . $full }
      }

      $ErrorActionPreference = $old
      $successes.Add($full)
    }
    catch {
      if ($null -ne $old) { $ErrorActionPreference = $old }
      $failures.Add([pscustomobject]@{
        File = $full
        ErrorMessage = $_.Exception.Message
      })
      Write-Warning "Skipping $full — $($_.Exception.Message)"
      continue
    }
  }

  [pscustomobject]@{
    Directory = $dir
    Loaded    = $successes
    Skipped   = $failures
  }
}

Load-ProfileD

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Oh-my-posh
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression
}

# Mise
if (Get-Command mise -ErrorAction SilentlyContinue) {
  mise activate pwsh | Out-String | Invoke-Expression
}

# Zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# Direnv
if (Get-Command direnv -ErrorAction SilentlyContinue) {
  Invoke-Expression "$(direnv hook pwsh)"
}

# Direnv
if (Get-Command bat -ErrorAction SilentlyContinue) {
  Set-Alias cat bat
}

# Fzf---------------------------------------------------------------------------
# https://github.com/kelleyma49/PSFzf
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# example command - use $Location with a different command:
$commandOverride = [ScriptBlock]{ param($Location) Write-Host $Location }
# pass your override to PSFzf:
Set-PsFzfOption -AltCCommand $commandOverride

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# ------------------------------------------------------------------------------

# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -HistoryNoDuplicates
# Set-PSReadLineKeyHandler -Key Tab -Function Complete