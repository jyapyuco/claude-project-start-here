# PreToolUse guard for shell commands: blocks catastrophic operations.
# Exit 2 = block (stderr explains why, fed back to Claude). Exit 0 = allow.
# Tune the rules below for your project — keep it conservative: block disasters, not normal work.
$ErrorActionPreference = 'SilentlyContinue'

try { $hook = [Console]::In.ReadToEnd() | ConvertFrom-Json } catch { exit 0 }
if (-not $hook -or -not $hook.tool_input -or -not $hook.tool_input.command) { exit 0 }
$cmd = [string]$hook.tool_input.command

$rules = @(
    @{ Pattern = '(?i)\brm\s+(-\S+\s+)*-\S*r\S*\s+["'']?(/|~)["'']?\s*(\s|$)'
       Reason  = 'recursive delete targeting filesystem root or home directory' },
    @{ Pattern = '(?i)remove-item\b.*-recurse.*\s(["'']?[a-z]:[\\/]?["'']?|\$env:USERPROFILE\b|~)(\s|$)'
       Reason  = 'recursive Remove-Item targeting a drive root or user profile' },
    @{ Pattern = '(?i)\bdel\s+/s\b.*\s[a-z]:\\?(\s|$)'
       Reason  = 'recursive del targeting a drive root' },
    @{ Pattern = '(?i)\bgit\s+reset\s+--hard\b'
       Reason  = 'git reset --hard discards local work; prefer git stash, or the user can run it deliberately' },
    @{ Pattern = '(?i)\bgit\s+clean\b.*-\w*x'
       Reason  = 'git clean -x deletes ignored files (local configs, caches); too destructive to automate' },
    @{ Pattern = '(?i)\b(format(\.com)?\s+[a-z]:|mkfs\b|diskpart\b)'
       Reason  = 'disk formatting/partitioning command' },
    @{ Pattern = '(?i)\b(cat|type|get-content|gc)\s+(\S*[\\/])?\.env(\.\w+)?\b'
       Reason  = 'reading .env files is blocked to keep secrets out of the conversation' }
)

foreach ($rule in $rules) {
    if ($cmd -match $rule.Pattern) {
        [Console]::Error.WriteLine("Blocked by guard.ps1: $($rule.Reason). If this is genuinely needed, ask the user to run it or to adjust .claude/hooks/guard.ps1.")
        exit 2
    }
}

# Force-push to main/master (force-with-lease to a feature branch is fine).
if ($cmd -match '(?i)\bgit\s+push\b' -and
    $cmd -match '(?i)(--force\b|\s-f\b)' -and
    $cmd -notmatch '(?i)--force-with-lease' -and
    $cmd -match '(?i)\b(main|master)\b') {
    [Console]::Error.WriteLine('Blocked by guard.ps1: force-push to main/master. Use --force-with-lease on a feature branch, or have the user run this deliberately.')
    exit 2
}

exit 0
