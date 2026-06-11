# プロジェクト実践記録

各Projectの実施記録と気づきをまとめています。  
コース: [Learn Harness Engineering](https://walkinglabs.github.io/learn-harness-engineering/en/)

## 記録一覧

| Project | テーマ | 状態 | 記録 |
|---|---|---|---|
| [Project 01](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-01-baseline-vs-minimal-harness/) | Prompt-Only vs. Rules-First | 完了 | [findings](project-01-findings.md) |
| [Project 02](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-02-agent-readable-workspace/) | Agent-Readable Workspace | 完了 | [findings](project-02-findings.md) |
| Project 03 | Multi-Session Continuity（ループ持続性実験） | 進行中 | [findings](project-03-loops-continuity.md) |
| Project 04 | Runtime Feedback & Scope Control | 未着手 | — |
| Project 05 | Self-Verification & Role Separation | 未着手 | — |
| Project 06 | Complete Harness (Capstone) | 未着手 | — |

## 横断的な気づき

各Projectで共通して見えてきたパターンをここに追記していく。

- P01・P02共通: **Rules系ファイルは有効。State系ファイル（feature_list/progress）は自動検証なしには信頼できない**（Verification Gap）
- P02固有: **session-handoff.mdによるセッション引き継ぎは成功**——ドキュメントだけで新エージェントが状態・設計判断・次のステップを把握できた
