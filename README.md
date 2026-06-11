# harness-engineering

このリポジトリは、Grok Build、Claude Code、Cursor など複数のAI coding agent で使用するハーネスを体系的に管理・改善するための専用リポジトリです。

## 目的
- Learn Harness Engineering コースの原則を自分自身に適用する（repo as the spec, state管理、verification、scope制御）。
- AGENTS.md、skills、templates を一元管理し、バージョン履歴を残す。
- ハーネス改善自体をプロジェクトとして追跡（feature_list + progress）。

## 現在のライブハーネスとの関係
- このリポジトリの `AGENTS.md` が canonical（正本）。
- 実運用では以下に同期して使用:
  - Grok Build: `~/.grok/AGENTS.md`（`sync-agents.sh` で同期）
  - Claude Code: `~/.claude/CLAUDE.md` またはプロジェクト内の CLAUDE.md（手動コピー。sync-agents.sh は未対応）
- 変更時はこのリポで編集 → 該当エージェントの設定場所に反映。

## 構造
- AGENTS.md: マルチエージェント対応ハーネス指示の正本（Grok Build / Claude Code 共通で使用）
- skills/: カスタムスキル（grill-me など計画検証用、複数のエージェントで共有）
- templates/: コース準拠のミニマルパック（AGENTS.md / feature_list.json / claude-progress.md ＋日本語README）
- docs/: ハーネス改善の学び・実験記録
- feature_list.json / claude-progress.md: このリポ自身の改善タスク管理（コース準拠）
- sync-agents.sh: AGENTS.md をライブハーネスへ同期するスクリプト（backup + copy + verify）

## 使い方
1. 新しい計画や機能追加時は `skills/grill-me` を活用して解像度を上げる。
2. 改善は feature_list でスコープを切り、todo_write で追跡。
3. 検証を必ず行い、progress に記録。

参考: https://walkinglabs.github.io/learn-harness-engineering/en/

## 同期方法
- リポルートで `./sync-agents.sh` を実行（バックアップ → コピー → diff 検証）。
- 手動フォールバック: `cp AGENTS.md ~/.grok/AGENTS.md` 後に `head -5` で確認。

初期セットアップ: 2026年時点の .grok/AGENTS.md をベースに、マルチエージェント対応に一般化して開始。