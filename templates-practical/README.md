# テンプレートパック（実践版）

コース原典 `../templates/` に、Learn Harness Engineering の Project 01〜06 を実際に走らせて得た学びを織り込んだ実践版。新規プロジェクトにコピーして使うのはこちら。

原典との違いを最小限に保つため、**全プロジェクト共通で効く2つの学びだけをテンプレ本体に常設**し、コードプロジェクト固有の学びは `harness-setup` Skill の記入指針側に置いて出し分ける。

## テンプレ本体に常設した2つの学び

### 1. Verification Gap対策（Project 01/06）
「pass欄があると未検証で埋めてしまう」のがこのシリーズ最大の発見。対策は「欄を増やす」ことでなく「実際に走らせた証拠を要求する」こと。
- `feature_list.json` の `passing` は「検証コマンドを実際に実行し、その出力（exit code含む）を evidence に貼った」状態と定義
- evidence のサンプルを空配列でなく**記入見本**にした（人もAIも見本を真似るので、正しい見本が一番効く）
- `AGENTS.md` の Definition Of Done を「コマンド出力を貼る。"成功した"という文章だけは不可」に強化

### 2. 検証の精度（Project 03）
緩い検証は偽PASSを生む（広いgrepが意図と別の箇所にヒットして未達成をPASS扱いした）。
- 各 feature の `verification` に **PASS CONDITION（何が出れば合格か）を一意に**書く形式にした

## テンプレ本体に載せず、Skill側に回した学び

非コードプロジェクト（執筆・整理）では過剰になるため、`harness-setup` Skill の記入指針でコードプロジェクト時のみ効かせる。

- 失敗の形ログ（P04）: ログは活動量でなく「失敗が見える」形に
- 評価基準と要求の一致（P05）: verification が「作るものの要求」と一致しているか grill-me で確認
- サブエージェント委譲（P06）: 検証はサブエージェントに任せられるが commit/install は不可 → 委譲は「検証まで」で切る

（自己観測の失敗（P06: エージェントは自分の行動を誤認しうる）はテンプレに載せる性質のものではないので、学びとして記録のみ。）

## ファイル構成

コピー対象は原典と同じ4ファイル（AGENTS.md / feature_list.json / claude-progress.md / init.sh）。この README は使い方の説明で、通常はコピーしない。

指示ファイル名・進捗ファイル名の調整方針は原典 `../templates/README.md` と同じ。

## コピー手順

推奨は `harness-setup` Skill 経由（「ハーネスを導入して」と言えば、このフォルダを参照し、grill-me で要件をすり合わせて記入まで終わらせる）。

手動でコピーする場合:

1. 4ファイルをプロジェクトのルートにコピーする（Claude Code なら AGENTS.md は CLAUDE.md にリネーム）
2. `AGENTS.md` の Startup Workflow と `init.sh` の INSTALL/VERIFY/START を実コマンドに書き換える。`VERIFY_CMD` は pass/fail が明確に出る（失敗時に非ゼロ終了する）コマンドにする
3. `feature_list.json` のサンプル機能と evidence の記入見本を、自分の実タスクに置き換える
4. `claude-progress.md` の Current Verified State を埋めてから最初のセッションを開始する

注意: `AGENTS.md` が参照する `session-handoff.md` はこのパックに収録していない。使わないなら該当行を削除すること（放置すると起動経路が壊れる）。
