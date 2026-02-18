# run_gimmy.ps1
Set-Location "C:\Users\WIN\Mother_System"

# venv activate
& ".\.venv-jimmy\Scripts\Activate.ps1"

# API Key をセット
$env:GOOGLE_API_KEY = "AIzaSyDJWHkHtbyQ7sZwuxsokpQMRhOyZ82ReuM"

# 🚀 モデル名を gemini/ から始めることで Provider エラーを根治する
interpreter -y --model "google/gemini-1.5-flash"