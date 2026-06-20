# Quality Document（品質スナップショット）

このリポジトリが「時間とともに強くなっているか弱くなっているか」を追跡する文書。
個別セッションの成果ではなく、ハーネス構成要素そのものの健全性を採点する。

参考: コースの `docs/QUALITY_SCORE.md`（https://walkinglabs.github.io/learn-harness-engineering/en/resources/openai-advanced/）

## 採点基準

- **A**: 検証済み・可読・安定。記載と実体が一致し、エージェントが迷わず使える
- **B**: 機能するが軽微なギャップあり（検証不足・記載の古さなど）
- **C**: 部分的に機能。手動介入や推測が必要な箇所がある
- **D**: 破損または構造不明。エージェントが安全に使えない

## 構成要素別スナップショット

| 構成要素 | Grade | 検証方法 | 既知のギャップ | 最終更新 |
|---|---|---|---|---|
| README.md | A | read + 導線キーワード確認 | なし（現在地・読む順番・標準検証を Session 012 で追記） | 2026-06-20 |
| AGENTS.md（このリポ専用ルール） | A | read + 標準検証コマンド実行 | なし（templates-practical 変更時の追加検証も記載済み） | 2026-06-20 |
| feature_list.json | A | python3 -m json.tool + evidence確認 | なし（templates-practical の追加記録漏れは Session 011、入口文書リファイン記録は Session 012 で修正済み） | 2026-06-20 |
| claude-progress.md | A | read（Verified State / Session Log確認） | なし（Session 012 まで記録済み） | 2026-06-20 |
| docs/README.md | A | read + 導線キーワード確認 | なし（学習順・実践記録・現在の結論を Session 012 で追記） | 2026-06-20 |
| docs/practical-use-cases.md | A | read + 用途別キーワード確認 | なし（記事執筆・情報整理・ドキュメント管理・コーディングの4用途を Session 013 で追加） | 2026-06-20 |
| docs/harness-course | A | 全13ファイルの存在・日本語化・出典URL確認 | なし（全12講＋ホームを日本語化済み。原文は 1d5c22c で参照可能） | 2026-06-11 |
| templates/ | A | 存在確認 + JSON妥当性検証 + bash -n | なし（init.sh 収録済み。session-handoff.md のみ未収録でREADMEに注意記載） | 2026-06-11 |
| templates-practical/ | A | JSON妥当性検証 + bash -n + README確認 | なし（コピー対象4ファイルと説明用READMEの区別を Session 012 で明確化） | 2026-06-20 |

## ベンチマークスナップショット

セッションごとの実績値。傾向の悪化を検知する。

| 日付 | セッション | 完了feature数 | 修正リトライ数 | 未解決ブロッカー |
|---|---|---|---|---|
| 2026-06-10 | 001 | 5 | 0 | 0 |
| 2026-06-11 | 002 | 6 | 0 | 0 |
| 2026-06-11 | 003 | 1（review-fixes） | 0 | 0 |
| 2026-06-11 | 004 | 1（c-items-completion） | 0 | 0 |
| 2026-06-17 | 011 | 1（templates-practical-record） | 0 | 0 |
| 2026-06-20 | 012 | 1（repository-content-refinement） | 0 | 0 |
| 2026-06-20 | 013 | 1（practical-use-cases） | 0 | 0 |

## 簡素化ログ

ハーネス構成要素を削除・簡素化した際の結果を記録する（複雑化の一方通行を防ぐ）。

| 日付 | 変更 | 結果 |
|---|---|---|
| 2026-06-11 | sync-agents.sh を削除（同期という仕組み自体を廃止） | グローバル設定は各エージェントの定位置で個別管理に移行。同期忘れリスクが消滅 |
| 2026-06-11 | skills/grill-me をリポから削除 | ~/.claude/skills/grill-me が唯一の本体に。二重管理が解消（git履歴 8982817 以前から復元可能） |
| 2026-06-11 | AGENTS.md からグローバル人格ルールを削除しリポ専用に縮小 | 約140行→約70行。各エージェントの定位置（~/.claude/CLAUDE.md 等）と役割が重複しなくなった |

## 更新タイミング

- 重要セッション後（feature完了・構成要素の追加削除時）
- 通常作業の一部として更新する。別途のクリーンアップデーを設けない
- 新しいエージェント・モデルを導入した時
