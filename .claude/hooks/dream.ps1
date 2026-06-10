# SessionEnd hook: "dreaming" — distills the session transcript into durable memory
# via a headless claude run (haiku). Skips trivial sessions. Never blocks shutdown (always exit 0).
# Logs to .claude/hooks/dream.log (gitignored).
$ErrorActionPreference = 'SilentlyContinue'

# Re-entry guard: the headless claude below fires its own SessionEnd when it exits;
# the inherited env var makes that nested invocation a no-op.
if ($env:CLAUDE_DREAMING -eq '1') { exit 0 }

$projDir = $env:CLAUDE_PROJECT_DIR
if (-not $projDir) { $projDir = (Get-Location).Path }
$log = Join-Path $projDir '.claude\hooks\dream.log'

function Write-Log([string]$msg) {
    Add-Content -Path $log -Value ("[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $msg) -Encoding utf8
}

try {
    $hook = [Console]::In.ReadToEnd() | ConvertFrom-Json
    $transcript = $hook.transcript_path
    $reason = $hook.reason

    if (-not $transcript -or -not (Test-Path $transcript)) {
        Write-Log "skip: no transcript (reason=$reason)"
        exit 0
    }

    # Minimum transcript size worth dreaming about — tune to taste.
    $minLines = 20
    $lineCount = (Get-Content $transcript | Measure-Object -Line).Lines
    if ($lineCount -lt $minLines) {
        Write-Log "skip: transcript too small ($lineCount lines, reason=$reason)"
        exit 0
    }

    if (-not (Get-Command claude)) {
        Write-Log 'skip: claude CLI not on PATH'
        exit 0
    }

    $prompt = @"
A coding session in this project just ended (reason: $reason). Its transcript is the JSONL file at:
$transcript

Follow the project's dream skill (.claude/skills/dream/SKILL.md) to distill durable lessons from that transcript into memory. The transcript may be large: read it in chunks (offset/limit), focusing on user messages, assistant conclusions, and errors — skip bulky tool results. Then write the memory updates exactly as the skill specifies. Work autonomously; do not ask questions. If nothing clears the durability bar, write only the journal line.
"@

    $env:CLAUDE_DREAMING = '1'
    $userMemory = Join-Path $env:USERPROFILE '.claude\memory'
    Write-Log "dreaming: reason=$reason, transcript=$lineCount lines"

    $output = & claude -p $prompt `
        --model haiku `
        --permission-mode acceptEdits `
        --add-dir $userMemory `
        --allowedTools 'Read' 'Glob' 'Grep' 'Edit' 'Write' 2>$null

    $summary = (($output | Out-String) -replace '\s+', ' ').Trim()
    if ($summary.Length -gt 300) { $summary = $summary.Substring(0, 300) + '...' }
    Write-Log "done: exit=$LASTEXITCODE; $summary"
} catch {
    Write-Log ("error: {0}" -f $_.Exception.Message)
}
exit 0
