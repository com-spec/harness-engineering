# Project 03 実験記録: ハーネス内ループ持続性（Multi-Session Continuity 拡張）

実施日: 2026-06-12  
作業ディレクトリ: このリポ（harness-engineering）  
使用ツール: 主にClaude Code（Grok Buildでも同等に使用可能。grill-me で計画合意済み）

---

## 結論

**「ハーネス内でループを小さく実践し、状態永続化・検証との統合を検証」**

P01/P02 で明らかになった Verification Gap（State系ファイルが自動検証なしに信頼できない）を、ループ（ReAct / Evaluator-Optimizer / Ralph Wiggum など）をハーネス内で回すことで埋める最小実験。既存の12講は純粋翻訳のまま、軽い拡張ノートは実験後1ファイルで後付け。templates/やコース本編には触れない。

---

## 発見の詳細（計画段階・初回記録）

- コース思想との整合: 02講「閉ループの作業システム」、05講「状態永続化ファイル（PROGRESS.md）」、11講「観測可能性とEvaluator」などがループの基盤。
- P01/P02横断気づきをループに適用: Rulesは有効だが、ループ継続時にState/検証が弱いと「状態汚染」が起きやすい。
- 最小スコープ: P03（Multi-Session Continuity）を「ループ持続性実験」として1-2セッション規模で実践。feature_listでWIP=1厳守。
- 次のステップ: 実際のループ（例: シンプルなEvaluator-Optimizer）をこのリポの改善タスクに適用し、進捗ファイルと検証で回す。

---

## ハーネスエンジニアリング概念との対応

| 発見 | 対応する概念 |
|---|---|
| ループをハーネス内で小さく回す | ハーネスがループを支える（コース00-home, 02） |
| Verification Gapをループ実験で埋める | State + Feedbackサブシステムの強化（P01/P02横断） |
| 拡張ノートは実験後派生 | 実験から逆算（grill-me合意） |

---

## 備考

- このfeatureは「小さく実験場」優先。教科書寄りA要素（軽い補足）は実験完了後にdocs/内で1ファイル。
- 標準検証: feature_list json.tool + projects/README確認。
- 完了定義: プロジェクトファイル作成 + 横断気づき更新 + evidence追記 + 次のセッションで再起動可能。

## 実験計画（このfeature内最小実践）

### 目的
P03（Multi-Session Continuity）を「ハーネス内でループを持続させる」実験として扱う。外部研究（ユーザーが共有したReAct論文、Anthropic Building Effective Agents、OpenAI Harness Engineering報告、awesome-harness-engineeringなど）から関連概念を選択的に取り入れ、このリポの実際の改善タスクに適用して検証する。

### 選択的に取り入れる研究ポイント（大規模まとめ不要・実験で検証）
- ReAct（Thought → Action → Observationループ）：状態ファイル（feature_list/progress）と検証を観察フェーズに組み込み、継続性を保つ。
- AnthropicのEvaluator-Optimizer：generator（実装）とevaluator（検証）を分離し、ループ内で自動フィードバック。
- OpenAIのRalph Wiggum Loop / 自己改善：agentが自身や他agentの出力をレビューするループをハーネスルール（AGENTS.md + feature_list）で強制。
- 共通の懸念（Verification Gap）：P01/P02で出た「Stateが検証なしに汚染されやすい」を、ループの各イテレーションで自動検証（python json.tool + プロジェクトファイル存在チェック）で防ぐ。

### 最小タスク（Claude Codeメイン、1-2セッション規模）
1. Claude Codeを使用して、シンプルな「Evaluator-Optimizer風ループ」を1回回す（Grok Buildでも同等のプロンプトで可）。
   - タスク: このプロジェクトファイルに「次のステップ」セクションを追加（Claude Codeにループ指示を与えて実行）。
   - Thought: 現在のスタブの不足点を分析（状態永続化が弱い）。
   - Action: 最小限の追加記述を書く。
   - Observation: 追加後、feature_listとREADMEを再確認。
2. ループ終了後に自動検証を実行（json.tool + ファイル存在 + 横断気づき更新）。
3. 結果をこのファイルに追記（成功/失敗、Gapの解消度、Claude Code使用時の観察）。

### 成果物（このfeatureで）
- project-03-loops-continuity.md に1ループの記録を追加。
- 横断的気づきに「ループ持続性」関連を1-2行追記。
- 完了後、軽い拡張ノート（docs/内1ファイル）は次featureで実験結果から逆算して作成。

### 制約（grill-me合意厳守）
- 既存12講は一切変更しない。
- templates/は触らない。
- 大規模なリンクまとめドキュメントは作らない（実験で必要な概念だけ選択的適用）。
- WIP=1：このfeature以外の作業はしない。

（実際のループ実行と記録は次セッションで実施予定）