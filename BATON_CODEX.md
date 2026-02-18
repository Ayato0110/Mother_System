# AAi Mother_System — Codex Baton

あなたは「Codex」として、Windows上のローカルPowerShellプロジェクトを安全に前進させる役割です。
このバトンは、現在の環境情報と修正タスクを1つにまとめた設計依頼です。

---

## 0. 最重要ゴール

Mother_System を「完全自動実行パイプライン」に安定化させる。

目標状態：

- smoke_test → PASS
- task実行 → 成功
- logs に出力保存
- 対話待ち（EOF / feedback prompt）なし
- エラー時は安全に停止

---

## 1. 現在の環境

OS:
- Windows 11

プロジェクトルート:
- C:\Users\WIN\Mother_System

構成:

Mother_System
├─ instructions
├─ logs
├─ tasks
├─ run.ps1
├─ smoke_test.ps1
├─ run_gimmy.ps1
├─ test_main.py
└─ .venv-jimmy

Python仮想環境:
- .venv-jimmy 有効化済み

Gimmy:
- Open Interpreter 0.4.3 Developer Preview
- コマンド `gimmy` は実行可能

テスト:
- smoke_test.ps1 で pytest PASS 確認済み

---

## 2. 既知の問題

tasks\01_generate.ps1 内で現在：

gimmy -y -c $instruction

を使用しているが、

- `-c` が ambiguous option エラーになる
- 対話プロンプト（Was Open Interpreter helpful?）が発生する
- パイプ利用時に EOF エラーが出る

つまり：
現在の呼び出し方法が不適切。

---

## 3. 修正タスク

### Task A: tasks\01_generate.ps1 を完全修正

要件：

- instructions\01_generate.txt を読み込む
- gimmy に安全に渡して実行
- logs\gimmy_YYYYMMDD_HHMMSS.log に保存
- `-c` は使用しない
- ambiguous option エラーを発生させない
- 対話要求を可能な限り抑止する方法を選択
- PowerShellのみ使用

成果物：

- 修正版 tasks\01_generate.ps1 の全文（コピペ可能形式）

---

### Task B: run.ps1 を安全ゲート化

要件：

- logs フォルダが存在しなければ作成
- [1/3] smoke_test 実行
- PASS の場合のみ [2/3] 実行
- [2/3] 失敗なら stop
- 成功なら [3/3] done 表示
- エラー時は exit 1

成果物：

- 修正版 run.ps1 の全文（コピペ可能形式）

---

### Task C: instructions 運用ルール整理

要件：

- instructions\ に .txt を置く
- tasks\ がそれを読む
- logs\ に保存する
- 将来拡張可能な構造

成果物：

- instructions\README.md（短く明確）

---

## 4. 制約

- 不要なファイル変更禁止
- PowerShell (.ps1) 前提
- 管理者権限不要
- 追加ツールインストール最小
- Windows パス前提（バックスラッシュ）

---

## 5. 出力フォーマット（重要）

必ず以下の形式で出力してください：

### tasks\01_generate.ps1
```powershell
（全文）
