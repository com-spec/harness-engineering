# テンプレートパック（ミニマル）

「Learn Harness Engineering」コースの Resource Library に掲載されているミニマルパック4ファイルを収録している。テンプレート本体はコース掲載内容（英語）のまま。

出典: https://walkinglabs.github.io/learn-harness-engineering/en/resources/templates/

## 各テンプレートの用途

### AGENTS.md

エージェントがセッション開始時に最初に読むルートの指示ファイル。起動手順（進捗と機能リストを読む）、作業ルール（一度に1機能・証拠なしで完了にしない）、完了の定義、セッション終了手順を定義する。
指示ファイル名は AGENTS.md が標準（Grok Build など多くのエージェントでそのまま使える）。Claude Code の場合は Claude.md や CLAUDE.md にリネームして同じ内容を置く。

### feature_list.json

機械可読な機能トラッカー。各機能に id / priority / area / title / user_visible_behavior / status / verification / evidence / notes を持たせる。
status は not_started / in_progress / blocked / passing の4種で、in_progress は常に1件のみ。passing にするには検証の実行と evidence の記録が必須。

### claude-progress.md

進捗ログ。毎セッションの終わりに書き、新しいセッションは最初にこれを読む。
「Current Verified State」（起動・検証パス、最優先未完了機能、ブロッカー）がプロジェクト現状の単一情報源で、セッションごとの記録（目標・完了・検証・証拠・コミット・リスク・次の一手）を追記していく。
ファイル名は claude-progress.md がこのパックの既定。他のエージェント（Grok Build など）では agent-progress.md や PROGRESS.md などに変えて、指示ファイル内の参照も一緒に更新すればOK。シンプルに名称がわかればよい。

### init.sh

起動スクリプト。依存インストール → ベースライン検証 → 起動コマンドの表示を1回で行う。
収録版のコマンドは npm のプレースホルダ（npm install / npm test / npm run dev）なので、自分のプロジェクトのコマンドに書き換えてから使う。`chmod +x init.sh` で実行権限を付けること。

## 新規プロジェクトへのコピー手順

1. 4ファイルをプロジェクトのルートディレクトリにコピーする（例: `cp templates/AGENTS.md templates/feature_list.json templates/claude-progress.md templates/init.sh <プロジェクトルート>/`）。指示ファイル名・進捗ファイル名は各テンプレート説明にある目安に従ってエージェントに合わせて調整（Claude Code なら Claude.md や CLAUDE.md + claude-progress.md のまま、Grok Build などなら AGENTS.md + agent-progress.md など）。
2. 指示ファイル（AGENTS.md またはリネーム後）の Startup Workflow のコマンド・パスと、init.sh の INSTALL/VERIFY/START コマンドを実際のプロジェクトに合わせて書き換え、feature_list.json のサンプル機能を自分の機能一覧に置き換える
3. 進捗ファイル（claude-progress.md またはリネーム後）の「Current Verified State」を埋めてから最初のエージェントセッションを開始する

注意: templates/AGENTS.md の本文が参照する `session-handoff.md` はこのパックに収録していない。コピー後は該当行を自分のファイルに読み替えるか、使わない場合は削除すること（放置すると起動経路が壊れる）。
