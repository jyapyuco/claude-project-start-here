# Statusline: "<dir> | <branch><dirty marker> | <model>". Reads status JSON from stdin.
$ErrorActionPreference = 'SilentlyContinue'
try { $s = [Console]::In.ReadToEnd() | ConvertFrom-Json } catch { $s = $null }

$dir = $null
if ($s -and $s.workspace -and $s.workspace.current_dir) { $dir = $s.workspace.current_dir }
if (-not $dir) { $dir = (Get-Location).Path }
$line = Split-Path $dir -Leaf

if (Get-Command git) {
    $branch = & git -C $dir rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -eq 0 -and $branch) {
        $dirty = @(& git -C $dir status --porcelain 2>$null)
        $marker = ''
        if ($dirty.Count -gt 0) { $marker = '*' }
        $line += " | $branch$marker"
    }
}

if ($s -and $s.model -and $s.model.display_name) { $line += " | $($s.model.display_name)" }

Write-Output $line
