# harness-engineering リポジトリ作業ルール

このファイルは、このリポジトリで作業するときのルールである。

全プロジェクト共通のルール（応答スタイル・禁止事項・委譲方針など）は、ここでは管理しない。
各エージェントの定位置で個別に管理する（2026-06-11 の方針転換。経緯は claude-progress.md Session 006 を参照）。

## このリポの役割

1. **教科書**: docs/harness-course/（Learn Harness Engineering 全12講の日本語版）
2. **テンプレート置き場**: templates/（コース原典寄り）と templates-practical/（実践版）
3. **実験場**: このリポ自体を feature_list / claude-progress で運用し、ハーネスの練習台にする

## 計画ゲート

新しい計画・機能追加時は必ず `grill-me` Skill を起動して共有理解を形成する。
（grill-me はグローバル `~/.claude/skills/` に登録済み）

## スコープ規律

- 一度に1機能のみ作業する（in_progress は常に1件）
- 変更は選択した機能の範囲内に留める。ブロッカー解消に必要な最小限の修正以外、「ついでのリファクタリング」をしない
- 重要な状態・決定はチャット要約ではなく耐久性のあるリポ成果物（progress / feature_list / docs）に書く

## 完了の定義

ファイルを追加・編集しただけでは完了にしない。以下4条件を満たした時のみ完了:

1. 求められた振る舞いが実装されている
2. 検証を実際に実行した（実行したコマンドと結果が示せる）
3. evidence を feature_list.json または claude-progress.md に記録した
4. 標準起動パスから再起動可能な状態である

## 検証

- 検証はレベルを意識する: スモーク（起動・読込確認）→ 単体 → E2E。新規作業の開始前にスモーク検証を実行する
- 着手時に合意した検証ルールを実装中に黙って変更しない。変更が必要なら先に宣言する

### 標準検証コマンド

- `python3 -m json.tool feature_list.json`（feature_list の構文検証）
- `ls docs/harness-course/ templates/`（ドキュメント・テンプレートの存在確認）
- templates-practical/ を変更した場合:
  - `python3 -m json.tool templates-practical/feature_list.json`
  - `bash -n templates-practical/init.sh`

## Startup Workflow

作業開始前に必ず実行する。

1. 作業ディレクトリを確認（`pwd`）
2. `claude-progress.md` を読んで最新の検証済み状態と next step を確認
3. `feature_list.json` を読んで highest-priority unfinished feature を選択
4. 最近のコミットを確認（`git log --oneline -5`）
5. 標準検証コマンドを実行（ベースラインが壊れていたら先に直す）
6. 新しい計画・機能追加時は grill-me を起動

## セッション終了手順

1. feature_list.json の status と evidence を最新化する
2. claude-progress.md に Session Log（Goal / Completed / Verification / Next best step）を記録する
3. clean-state-checklist.md（正本）のチェックリストを実行し、結果を Session Log に記録する
4. コミット可否をユーザーに確認する（明示依頼なしにコミットしない）
