# Test harness for guard.ps1 — run after editing guard rules: powershell -File guard.tests.ps1
# Each case: a shell command the guard should allow (0) or block (2). Cases are data, never executed.
$guard = Join-Path $PSScriptRoot 'guard.ps1'

$tests = @(
    @{ cmd = 'git status'; expect = 0 },
    @{ cmd = 'rm -rf /'; expect = 2 },
    @{ cmd = 'rm -rf ~'; expect = 2 },
    @{ cmd = 'rm -rf ./build'; expect = 0 },
    @{ cmd = 'git reset --hard HEAD~1'; expect = 2 },
    @{ cmd = 'git push --force origin main'; expect = 2 },
    @{ cmd = 'git push --force-with-lease origin feature-x'; expect = 0 },
    @{ cmd = 'git push -f origin my-feature'; expect = 0 },
    @{ cmd = 'Remove-Item -Recurse -Force C:\'; expect = 2 },
    @{ cmd = 'Remove-Item -Recurse -Force C:\temp\foo'; expect = 0 },
    @{ cmd = 'cat .env'; expect = 2 },
    @{ cmd = 'cat config/.env.production'; expect = 2 },
    @{ cmd = 'cat environment.md'; expect = 0 },
    @{ cmd = 'git clean -fdx'; expect = 2 },
    @{ cmd = 'npm test'; expect = 0 },
    @{ cmd = 'format D:'; expect = 2 }
)

$fail = 0
foreach ($t in $tests) {
    $json = (@{ tool_name = 'Bash'; tool_input = @{ command = $t.cmd } } | ConvertTo-Json -Compress)
    $json | powershell -NoProfile -ExecutionPolicy Bypass -File $guard 2>$null | Out-Null
    $code = $LASTEXITCODE
    if ($code -eq $t.expect) { $r = 'PASS' } else { $r = 'FAIL'; $fail++ }
    Write-Output ("{0}  expect={1} got={2}  {3}" -f $r, $t.expect, $code, $t.cmd)
}
Write-Output "---- $fail failure(s)"
exit $fail
