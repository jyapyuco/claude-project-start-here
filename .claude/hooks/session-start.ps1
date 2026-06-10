# SessionStart hook: injects continuity context — recent journal entries and git state.
# Reads hook JSON from stdin (unused; project dir comes from CLAUDE_PROJECT_DIR).
# Emits hookSpecificOutput.additionalContext JSON on stdout. Always exits 0.
$ErrorActionPreference = 'SilentlyContinue'
try {
    $null = [Console]::In.ReadToEnd()

    $projDir = $env:CLAUDE_PROJECT_DIR
    if (-not $projDir) { $projDir = (Get-Location).Path }

    $sections = @()

    $journal = Join-Path $projDir 'memory\journal.md'
    if (Test-Path $journal) {
        $recent = @(Get-Content $journal | Where-Object { $_ -match '^- \d{4}-\d{2}-\d{2}' } | Select-Object -Last 3)
        if ($recent.Count -gt 0) {
            $sections += "Recent sessions (journal tail):`n" + ($recent -join "`n")
        }
    }

    if (Get-Command git) {
        $branch = & git -C $projDir rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -eq 0 -and $branch) {
            $dirty = @(& git -C $projDir status --porcelain 2>$null)
            $state = 'clean working tree'
            if ($dirty.Count -gt 0) { $state = "$($dirty.Count) uncommitted change(s)" }
            $sections += "Git: branch '$branch', $state."
        }
    }

    if ($sections.Count -gt 0) {
        $out = @{
            hookSpecificOutput = @{
                hookEventName     = 'SessionStart'
                additionalContext = ($sections -join "`n`n")
            }
        }
        Write-Output ($out | ConvertTo-Json -Depth 4)
    }
} catch { }
exit 0
