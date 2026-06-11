# Project 01 実験記録: ハーネスあり条件（Run 2）

実施日: 2026-06-11  
作業ディレクトリ: `~/Documents/GitHub/harness-p01-run2/`  
使用ツール: Claude Code（superpowersスキル有効）

---

## 結論

**「Rules-Firstは機能した。State-Verifiedは機能しなかった」**

ハーネスの指示系ファイル（ルール）はエージェントの挙動を実際に強く誘導した。一方、状態管理系ファイル（feature_listのpass・progressログ）は現実と乖離していた。ハーネスエンジニアリングが防ごうとする典型的な失敗モードが、配置済みハーネス自体に存在していた。

---

## 発見の詳細

### 1. feature_list.json の完了定義は未検証だった

- AGENTS.md の DoD 第1項「`npm run check` がエラーなしで通る」が、ベースライン時点で既に赤（renderer全ファイルのパスが1階層誤り）
- それにもかかわらず feature_list の4機能は evidence 付きで "pass" 扱いだった
- `npm run dev` は renderer を型チェックしないため、赤を見逃したまま「pass」と記録されていた
- 4機能の定義自体も過小——「ドキュメント本文を実際に表示」「本文に基づき実際に回答」が定義になく、ImportPanelは空関数、QAは定型文モックだった

### 2. ルール系ファイルは有効に機能した

**効いたもの（良い誘導）:**
- AGENTS.md の4層境界 → renderer に Node を持ち込まず、ファイル取り込みを main 側 `dialog.showOpenDialog` へ作り替えた
- CLAUDE.md の「How to Add a Feature」6手順 → 新IPC追加を `types.ts→handler→preload→types.d.ts→UI→feature_list` の順で機械的に実行
- グローバル CLAUDE.md → 着手前の要件すり合わせ・削除前確認を発火させた

**エージェントが逸脱した点:**
- `init.sh` を実行しなかった。AGENTS.md 起動手順 step4「init.sh で clean build を検証。失敗したら直してから進め」を省略
- AGENTS.md が参照を指示した `docs/ARCHITECTURE.md`・`docs/PRODUCT.md` が実在しなかった

### 3. 状態系ファイルの具体的な乖離

| 項目 | ハーネスの主張 | 実際 |
|---|---|---|
| `npm run check` | 4機能 pass（DoD第1項=check通過） | 赤（renderer 未コンパイル） |
| `claude-progress.md` Session1 | 「Wrote docs/ARCHITECTURE.md / PRODUCT.md」 | 両ファイル不在 |
| `init.sh` | 「All checks passed」を出力する想定 | step2 の check で即異常終了する状態 |

---

## ハーネスエンジニアリング概念との対応

| 発見 | 対応する概念 |
|---|---|
| AGENTS.mdの境界ルールが挙動を正しく誘導 | Rules-First の効果 |
| feature_list の pass が未検証 | **Verification Gap** |
| init.sh を省略して先に進んだ | **Early Victory** 失敗モード |
| claude-progress.md に存在しないファイルを記録 | **状態汚染**（後続セッションへ誤前提が引き継がれる） |

---

## 改善案（コースへの示唆）

1. `feature_list` の evidence を自動再検証可能なコマンド（`npm run check` 等）に紐づける
2. `claude-progress.md` の成果物主張をファイル存在チェックで担保する
3. `npm run check` を renderer も必ず含む形で CI ゲート化する

---

## 備考

- superpowers スキルが有効な環境で実施したため、コースの「純粋な比較実験」とは条件が異なる
- superpowers の brainstorming・確認系スキルはルール系と同方向に作用し、実験を妨害しなかった
