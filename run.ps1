# run.ps1  (Mother_System 直下)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass | Out-Null

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

# venv on
& "$root\.venv-jimmy\Scripts\Activate.ps1"

Write-Host "=== AAi RUN START ===" -ForegroundColor Cyan

# Smoke test
Write-Host "[1/3] Smoke test..." -ForegroundColor Yellow
pytest | Tee-Object -FilePath "$root\logs\pytest_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
if ($LASTEXITCODE -ne 0) {
  Write-Host "TEST FAILED. stop." -ForegroundColor Red
  exit 1
}
Write-Host "TEST PASSED" -ForegroundColor Green

# Task 실행
Write-Host "[2/3] Gimmy task..." -ForegroundColor Yellow
& "$root\tasks\01_generate.ps1"

Write-Host "[3/3] Done." -ForegroundColor Green
