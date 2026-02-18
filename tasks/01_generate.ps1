# tasks\01_generate.ps1

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $root

$instructionFile = Join-Path $root "instructions\01_generate.txt"

if (!(Test-Path $instructionFile)) {
    Write-Host "Instruction file not found: $instructionFile" -ForegroundColor Red
    exit
}

$logPath = Join-Path $root ("logs\gimmy_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".log")

Write-Host "Running Gimmy..." -ForegroundColor Cyan

(Get-Content $instructionFile -Raw) | gimmy -y 2>&1 | Tee-Object -FilePath $logPath

Write-Host "Log saved to $logPath" -ForegroundColor Green
