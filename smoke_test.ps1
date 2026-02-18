Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass | Out-Null
& .\.venv-jimmy\Scripts\Activate.ps1

Write-Host "=== Smoke Test Start ==="

pytest

if ($LASTEXITCODE -ne 0) {
    Write-Host "TEST FAILED" -ForegroundColor Red
    exit 1
}

Write-Host "TEST PASSED" -ForegroundColor Green
