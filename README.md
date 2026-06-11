# harness-engineering

ハーネスエンジニアリング（AI coding agent を確実に働かせるための環境設計）の教科書・テンプレート・実験場を兼ねるリポジトリ。

## 役割

1. **教科書**: `docs/harness-course/` に Learn Harness Engineering コース全12講の日本語版を収録
2. **テンプレート置き場**: `templates/` に新規プロジェクト用のミニマルパック（AGENTS.md / feature_list.json / claude-progress.md / init.sh）を収録。大きめのプロジェクトを始めるときにコピーして使う
3. **実験場**: このリポ自体を feature_list / claude-progress で運用し、ハーネスの練習台にする

## 管理方針（2026-06-11 改訂）

全プロジェクト共通のルール（応答スタイル・禁止事項など）は、このリポでは管理しない。
各エージェントの定位置で個別に最適化して管理する:

- Claude Code: `~/.claude/CLAUDE.md`、スキルは `~/.claude/skills/`
- Grok Build: `~/.grok/AGENTS.md`

旧方式（このリポを正本として sync-agents.sh で同期）は廃止した。経緯は claude-progress.md の Session 006 と git 履歴を参照。

## 構造

- AGENTS.md: このリポで作業するときのルール（Startup Workflow・スコープ規律・完了の定義・検証）
- docs/: コース日本語版と差分分析などの学習記録
- templates/: 新規プロジェクト用テンプレートパック（使い方は templates/README.md）
- feature_list.json / claude-progress.md: このリポ自身の改善タスク管理と進捗記録
- quality-document.md: 構成要素別の品質スナップショット
- clean-state-checklist.md: セッション終了時チェックリスト（正本）

## 使い方

1. 新しい計画や機能追加時は `grill-me` Skill（グローバル登録済み）で解像度を上げる
2. 改善は feature_list でスコープを切り、検証して evidence を記録する
3. セッション終了時は clean-state-checklist を実行し、claude-progress.md に記録する

参考: https://walkinglabs.github.io/learn-harness-engineering/en/
