# 設計: テンプレート実践版 + harness-setup Skill更新

作成日: 2026-06-13
背景: Learn Harness Engineering コース Project 01〜06 の実践で得た6つの学びを、再利用可能なテンプレートとセットアップSkillに織り込む。

## 目的

`templates/`（コース原典の忠実な収録）はそのまま保存し、Project 01〜06 の学びを織り込んだ実践版 `templates-practical/` を新設する。あわせて `harness-setup` Skill が実践版を参照・記入するよう更新する。

## 設計判断

### なぜ原典を残すか（別フォルダ新設 = option A）
- リポの「教科書」役割（コース原典の保存）を壊さない
- 原典と実践版の差分そのものが「6つの学びが何を変えたか」の生きた教材になる
- コピー時は実践版だけ使えばよい

### なぜ全部を本体に盛らないか（二層分割 = option B）
6つ全部をテンプレ本体に常設すると、本体が重くなり P06 の発見「欄を増やすと未検証passを誘発／認知負荷増」を自分で踏む。さらにユーザーの用途は執筆・整理など非コードも多く、コード向けの学び（失敗ログ・アーキ境界）を全テンプレに常設すると非コードのとき過剰になる。

→ **本体には全プロジェクト共通の2つだけ常設し、残りはSkillの記入指針でプロジェクト性質に応じ出し分ける。**

## 6つの学びの配置

| # | 学び（出典P） | 配置先 |
|---|---|---|
| 1 | Verification Gap: pass欄が未検証passを誘発（P01/P06） | テンプレ本体（常設） |
| 2 | 検証の精度: 合格条件を一意に書く（P03） | テンプレ本体（常設） |
| 3 | 失敗の形ログ: 活動量でなく失敗が見えるログ（P04） | Skill記入指針（コード時） |
| 4 | 評価基準と要求の一致（P05） | Skill記入指針（grill-meで確認） |
| 5 | サブエージェント委譲: commit/install不可、委譲は検証まで（P06） | Skill記入指針 |
| 6 | 自己観測の失敗: 自分の行動を誤認しうる（P06） | 学びとしてspec/READMEに記録（テンプレには載せない） |

## 成果物

### 1. templates-practical/（5ファイル）

**AGENTS.md**（原典ベース + 2点強化）
- Definition Of Done: 「検証が実際に走り、そのコマンド出力（exit code含む）が evidence に貼られている。"成功した"という文章だけでは不可」に強化
- Working Rules: 「verification は合格条件（何が出れば合格か）を一意に書く。曖昧な広いマッチで未達成をPASSにしない」を追加

**feature_list.json**（原典ベース + 見本で縛る）
- rules に `note`（運用ルール日本語、Skillの記入例と同思想）
- status_legend の `passing` を「検証コマンドを実行し、その出力を evidence に記録済み」に強化
- サンプル feature の evidence に**記入見本**を1件入れる（空配列でなく「実コマンド＋出力＋exit codeを貼る、文章だけは不可」の見本）。P06の逆手 = 欄でなく正しい見本を置く
- verification ステップに合格条件を明示

**claude-progress.md**（最小変更）
- Current Verified State に「Last verification command & result」行を追加

**init.sh**（最小変更）
- VERIFY_CMD のコメントに「合格/不合格が明確に出るコマンドにする」一言

**README.md**（実践版の位置づけ）
- 冒頭に「コース原典 templates/ に Project 01〜06 の学びを織り込んだ実践版」と明記
- 6つの学びの配置表（本体2つ / Skill 3つ / 記録のみ1つ）
- コピー手順（harness-setup Skill 経由を推奨）

### 2. harness-setup Skill 更新

- 参照パス `…/templates/` → `…/templates-practical/`（SKILL.md 9行目）
- 手順3の記入指針に学び3〜5を追加（コードプロジェクト時に効かせる、grill-meの構成出し分けに乗せる）
- description の発動キーワードは維持

## やらないこと（YAGNI）

- check-architecture.sh / RELIABILITY.md のような新規ファイルは作らない（汎用テンプレには重く、非コードで不要。P06でablation対象にした通り効果も限定的）
- 原典 templates/ とコース原典の記述は一切変えない

## 検証

- `python3 -m json.tool templates-practical/feature_list.json` で JSON 構文確認
- `bash -n templates-practical/init.sh` で構文確認
- 全5ファイル + SKILL.md の存在・変更を確認
- 原典 templates/ が無変更であることを git status で確認
