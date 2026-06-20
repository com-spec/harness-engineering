# harness-engineering

ハーネスエンジニアリング（AI coding agent を確実に働かせるための環境設計）の教科書・テンプレート・実験場を兼ねるリポジトリ。

## 役割

1. **教科書**: `docs/harness-course/` に Learn Harness Engineering コース全12講の日本語版を収録
2. **テンプレート置き場**: `templates/` にコース原典寄りのミニマルパック、`templates-practical/` に Project 01〜06 の学びを織り込んだ実践版を収録。新規プロジェクトでは原則 `templates-practical/` を使う
3. **実験場**: このリポ自体を feature_list / claude-progress で運用し、ハーネスの練習台にする

## 現在地

- コース本文: `docs/harness-course/` にホーム＋全12講を収録済み
- 実践記録: `docs/projects/` に Project 01〜06 の findings を収録済み
- 実践ガイド: `docs/practical-use-cases.md` に記事執筆・情報整理・ドキュメント管理・コーディングの導入例を収録
- 推奨テンプレート: 新規プロジェクトでは `templates-practical/` を使う
- 状態管理: `feature_list.json` は全feature passing、最新状態は `claude-progress.md` の Current Verified State を正とする

## 管理方針（2026-06-11 改訂）

全プロジェクト共通のルール（応答スタイル・禁止事項など）は、このリポでは管理しない。
各エージェントの定位置で個別に最適化して管理する:

- Claude Code: `~/.claude/CLAUDE.md`、スキルは `~/.claude/skills/`
- Grok Build: `~/.grok/AGENTS.md`

旧方式（このリポを正本として sync-agents.sh で同期）は廃止した。経緯は claude-progress.md の Session 006 と git 履歴を参照。

## 構造

- AGENTS.md: このリポで作業するときのルール（Startup Workflow・スコープ規律・完了の定義・検証）
- docs/: コース日本語版、Project実践記録、差分分析などの学習記録
- templates/: コース原典寄りの新規プロジェクト用テンプレートパック（使い方は templates/README.md）
- templates-practical/: Project 01〜06 の実践知を反映した推奨テンプレートパック（使い方は templates-practical/README.md）
- feature_list.json / claude-progress.md: このリポ自身の改善タスク管理と進捗記録
- quality-document.md: 構成要素別の品質スナップショット
- clean-state-checklist.md: セッション終了時チェックリスト（正本）

## 読む順番

1. 実務に使う: `docs/practical-use-cases.md`
2. テンプレートをコピーする: `templates-practical/README.md`
3. ハーネスの考え方を学ぶ: `docs/harness-course/00-home.md`
4. 実験結果から学ぶ: `docs/projects/README.md`
5. このリポを続きから編集する: `AGENTS.md` → `claude-progress.md` → `feature_list.json`

## 作業ルール

1. 新しい計画や機能追加時は `grill-me` Skill（グローバル登録済み）で解像度を上げる
2. 改善は feature_list でスコープを切り、検証して evidence を記録する
3. セッション終了時は clean-state-checklist を実行し、claude-progress.md に記録する

## 標準検証

- `python3 -m json.tool feature_list.json`
- `ls docs/harness-course/ templates/`
- `templates-practical/` を触った場合: `python3 -m json.tool templates-practical/feature_list.json` と `bash -n templates-practical/init.sh`

参考: https://walkinglabs.github.io/learn-harness-engineering/en/
