# Project 02 実験記録: Agent-Readable Workspace

実施日: 2026-06-11  
作業ディレクトリ: `~/Documents/GitHub/harness-p02-run2/`  
使用ツール: Claude Code（superpowersスキル有効）

---

## 結論

**「ドキュメントによる状態把握は成功した。しかし状態記録と実態の乖離はP01と同じパターンで再現した」**

AGENTS.md の起動シーケンスに従ってドキュメントを読むことで、新しいエージェントがプロジェクト構造・前セッションの作業内容・次のステップを正確に把握できた（Agent-Readable Workspaceの目的は達成）。一方、`npm run check` は14件のTypeScriptエラーで失敗し、feature_list.json と session-handoff.md の「全機能pass・ブロッカーなし」という記録が事実と異なっていた。

---

## 発見の詳細

### 1. Agent-Readable Workspace として機能した点

新しいエージェントが起動シーケンス（AGENTS.md → docs/ARCHITECTURE.md → docs/PRODUCT.md → npm run check → feature_list.json）を実行した結果：

- プロジェクト構造（Electron 4層・IPC設計・サービス構成）を正確に把握
- session-handoff.md から前セッションの設計判断（独立IPCチャンネル化等）を読み取り
- feature_list.json にない次の機能（indexing/Q&A）をdocsから自律的に発見
- **ドキュメントだけで再開に必要な文脈を再構成できた**

→ Project 02 のハーネス目的（セッション間状態管理）は達成された

### 2. npm run check の失敗（14件）

| エラー種別 | 件数 | 内容 |
|---|---|---|
| モジュール解決失敗 | 4 | renderer配下が `../../shared/types` を相対パス参照（tsconfig エイリアスと不整合） |
| 未使用 React import | 6 | `jsx: react-jsx` 構成なのに旧来の `import React` が残存、`noUnusedLocals` で弾かれる |
| 暗黙の any | 3 | `App.tsx` の `(c, i)`、`StatusBar.tsx` のインデックスアクセス等 |
| File.path 不存在 | 1 | `ImportPanel.tsx` がブラウザ標準 `File` に存在しない `.path` を参照 |

### 3. 状態ファイルの乖離（P01と同じパターン）

| 項目 | ハーネスの主張 | 実際 |
|---|---|---|
| feature_list.json | 7機能すべて pass | npm run check 赤（14件） |
| session-handoff.md | 「ブロッカーなし」 | ビルド失敗状態 |

---

## P01との比較

| | Project 01 | Project 02 |
|---|---|---|
| Rules系ファイルの有効性 | ○ 機能した | ○ 機能した（ドキュメントで状態把握） |
| State系ファイルの信頼性 | ✗ 未検証pass | ✗ 未検証pass（同じパターン） |
| npm run check | 赤（パス誤り等） | 赤（同種のエラー14件） |
| セッション引き継ぎ | session-handoffなし | session-handoffあり → 引き継ぎ自体は成功 |

**P01との差分**: session-handoff.md によってエージェントは前セッションの設計判断を正確に読み取れた。「状態記録の信頼性」問題は同じだが、「文脈の引き継ぎ」はP02ハーネスで明確に改善された。

---

## ハーネスエンジニアリング概念との対応

| 発見 | 対応する概念 |
|---|---|
| ドキュメントだけで状態把握・再開できた | Agent-Readable Workspace の効果 |
| feature_list の pass が未検証 | **Verification Gap**（P01と同じ） |
| session-handoff.md の「ブロッカーなし」が虚偽 | **状態汚染** |
| エージェントが自律的に次機能を発見 | PRODUCT.md・ARCHITECTURE.md の有効性 |

---

## コースを通じた横断的パターン（暫定）

P01・P02 いずれも「ルール系ファイルは有効、状態系ファイルは未検証passが混入」というパターンが一致。
コース全体を通してこのパターンが続くか、P03以降で変化があるか注目。
