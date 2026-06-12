# プロジェクト実践記録

各Projectの実施記録と気づきをまとめています。  
コース: [Learn Harness Engineering](https://walkinglabs.github.io/learn-harness-engineering/en/)

## 記録一覧

| Project | テーマ | 状態 | 記録 |
|---|---|---|---|
| [Project 01](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-01-baseline-vs-minimal-harness/) | Prompt-Only vs. Rules-First | 完了 | [findings](project-01-findings.md) |
| [Project 02](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-02-agent-readable-workspace/) | Agent-Readable Workspace | 完了 | [findings](project-02-findings.md) |
| Project 03 | Multi-Session Continuity（ループ持続性実験） | 完了 | [findings](project-03-loops-continuity.md) |
| 実プロジェクト例 (Knowledge Base Electron) | Project 02/03 完了（RAGモック基盤） | 完了 | [handoff](handoff-example-knowledge-base-p02-p03.md) |
| [Project 04](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-04-incremental-indexing/) | Incremental Indexing（Runtime Feedback & Scope Control） | 完了 | [findings](project-04-findings.md) |
| Project 05 | Grounded QA Verification | 未着手 | — |
| Project 06 | Runtime Observability & Debugging | 未着手 | — |

## 横断的な気づき

各Projectで共通して見えてきたパターンをここに追記していく。

- P01・P02共通: **Rules系ファイルは有効。State系ファイル（feature_list/progress）は自動検証なしには信頼できない**（Verification Gap）
- P02固有: **session-handoff.mdによるセッション引き継ぎは成功**——ドキュメントだけで新エージェントが状態・設計判断・次のステップを把握できた
- P03: **自動検証はループ継続の前提だが、検証条件が緩いと偽PASSが出る**——grepが意図と別の箇所にヒットして未達成をPASSと誤判定した。検証の「精度」も設計対象
- P04: **ログは「活動の数」でなく「失敗の形」を記録する**——チャンク数のログは正常に見え、空内容という失敗は見えなかった。solutionですら活動量寄りのログに留まる
- P01/P02/P04共通: **コースstarterは赤ベースライン（型エラー14件）で出荷されている**——着手前のスモーク検証が毎回効いている
