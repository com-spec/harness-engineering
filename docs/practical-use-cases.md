# 実践ユースケース

この文書は、`templates-practical/` を実際の仕事に使うための入口である。
コース理解よりも、今日どの形で使うかを決めることを優先する。

## 使い方

1. 自分の用途に近いセクションを1つ選ぶ
2. `templates-practical/` の4ファイルを作業フォルダへコピーする
3. その用途の `feature_list.json` 初期例に置き換える
4. `claude-progress.md` に現在地と検証方法を書く
5. 1セッション1機能で進める

共通ルール:

- `passing` にするのは、検証を実際に走らせた後だけ
- evidence には「成功した」ではなく、実行したコマンド・確認手順・観察結果を書く
- 迷ったら、成果物を増やすより検証を小さくする

## 1. 記事執筆

### 何を自動化するか

- 記事テーマの分解
- 構成案の作成
- 下書き、推敲、事実確認、公開前チェック
- 参照元と未確認情報の分離

### 最初にコピーするテンプレート

- `templates-practical/AGENTS.md`
- `templates-practical/feature_list.json`
- `templates-practical/claude-progress.md`
- `templates-practical/init.sh`

`init.sh` は、記事執筆では必須ではない。使う場合は「ファイル存在確認」と「リンク確認」程度に置き換える。

### feature_list.json 初期例

```json
{
  "id": "article-001",
  "priority": 1,
  "area": "writing",
  "title": "記事の主張と読者を決める",
  "user_visible_behavior": "記事の読者、主張、読後アクションが1ページに整理されている。",
  "status": "not_started",
  "verification": [
    "記事メモを読む。",
    "読者、主張、読後アクションを書く。",
    "PASS CONDITION: 読者が1種類に絞られ、主張が1文で書かれ、読後アクションが具体的に1つ書かれている。"
  ],
  "evidence": [],
  "notes": ""
}
```

### claude-progress.md に残すこと

- 記事の目的
- 想定読者
- 未確認の事実
- 参照した資料
- 次に書くセクション

### 検証方法

- 見出しだけを読んで論理が通るか確認
- 未確認の固有名詞・数値・引用を一覧化
- 公開前にリンクを開いて確認

### やってはいけないこと

- 参照元を確認せずに断定する
- 複数読者に同時に刺そうとして主張を薄める
- 下書きと事実確認を同じfeatureで完了扱いにする

## 2. 情報整理

### 何を自動化するか

- メモ、PDF、Web記事、チャットログの分類
- 重複や未整理メモの統合
- 次に使える形への要約
- 判断材料と保留事項の分離

### 最初にコピーするテンプレート

- `templates-practical/AGENTS.md`
- `templates-practical/feature_list.json`
- `templates-practical/claude-progress.md`
- `templates-practical/init.sh`

`init.sh` は、対象フォルダの存在確認とファイル一覧出力に置き換えるとよい。

### feature_list.json 初期例

```json
{
  "id": "organize-001",
  "priority": 1,
  "area": "knowledge",
  "title": "未整理メモを3分類する",
  "user_visible_behavior": "未整理メモが、使う・保留・捨てるの3分類に分かれている。",
  "status": "not_started",
  "verification": [
    "対象フォルダのファイル一覧を確認する。",
    "各ファイルを、使う・保留・捨てるに分類する。",
    "PASS CONDITION: 全ファイルが必ず1分類だけに入っており、保留には保留理由が1文で書かれている。"
  ],
  "evidence": [],
  "notes": ""
}
```

### claude-progress.md に残すこと

- 対象フォルダ
- 分類ルール
- 迷った判断
- 次に処理する束

### 検証方法

- 対象ファイル数と分類済み件数が一致するか確認
- 保留理由が空でないか確認
- 元ファイルを削除する前に移動先を確認

### やってはいけないこと

- 元データをいきなり削除する
- 分類ルールを途中で変えて記録しない
- 「重要そう」で保留を増やしすぎる

## 3. ドキュメント管理

### 何を自動化するか

- 手順書、議事録、仕様メモの整備
- 古い記述と現状の差分確認
- 正本ファイルの明確化
- 次回作業者が読む順番の整備

### 最初にコピーするテンプレート

- `templates-practical/AGENTS.md`
- `templates-practical/feature_list.json`
- `templates-practical/claude-progress.md`
- `templates-practical/init.sh`

`init.sh` は、正本ドキュメントの存在確認と Markdown 見出し確認に置き換える。

### feature_list.json 初期例

```json
{
  "id": "docs-001",
  "priority": 1,
  "area": "docs",
  "title": "正本ドキュメントを決める",
  "user_visible_behavior": "どのファイルが正本で、どのファイルが補助資料か分かる。",
  "status": "not_started",
  "verification": [
    "ドキュメント一覧を読む。",
    "正本、補助資料、古い資料に分類する。",
    "PASS CONDITION: README に正本ファイルと読む順番が記載され、古い資料には古い理由または扱い方が書かれている。"
  ],
  "evidence": [],
  "notes": ""
}
```

### claude-progress.md に残すこと

- 正本ファイル
- 古い資料の扱い
- 変更した判断
- 次に更新するページ

### 検証方法

- README から必要な情報に辿れるか確認
- 正本と補助資料で矛盾した記述がないか確認
- 更新日やステータスが古いまま残っていないか確認

### やってはいけないこと

- 正本を決めずに複数ファイルを同時更新する
- 古い資料を無言で残す
- チャットだけに決定を残す

## 4. コーディング

### 何を自動化するか

- 1機能単位の実装
- 既存設計の読み取り
- テスト、lint、型チェック、スモーク確認
- 進捗と evidence の記録

### 最初にコピーするテンプレート

- `templates-practical/AGENTS.md`
- `templates-practical/feature_list.json`
- `templates-practical/claude-progress.md`
- `templates-practical/init.sh`

`init.sh` は、実プロジェクトの install / verify / start コマンドに必ず書き換える。

### feature_list.json 初期例

```json
{
  "id": "code-001",
  "priority": 1,
  "area": "product",
  "title": "最初のユーザー操作を通す",
  "user_visible_behavior": "ユーザーが主要画面を開き、最初の操作を完了できる。",
  "status": "not_started",
  "verification": [
    "依存関係をインストールする。",
    "既存のテストまたは型チェックを実行する。",
    "主要画面を起動して最初の操作を試す。",
    "PASS CONDITION: 検証コマンドが exit 0 で終わり、主要画面で最初の操作がエラーなく完了する。"
  ],
  "evidence": [],
  "notes": ""
}
```

### claude-progress.md に残すこと

- 標準起動コマンド
- 標準検証コマンド
- 現在の最高優先 feature
- 既知の失敗
- 次に触るファイル

### 検証方法

- `npm test`、`npm run check`、`pytest` など、プロジェクトに合うコマンドを1つ以上設定する
- UIがある場合は、起動確認またはスクリーンショット確認を行う
- 検証できなかった場合は、未検証として記録する

### やってはいけないこと

- テストが壊れた状態で新機能を重ねる
- 検証コマンドを実行せずに `passing` にする
- ついでのリファクタリングを混ぜる

## 用途別の選び方

| 用途 | 最初のfeature | 検証の中心 |
|---|---|---|
| 記事執筆 | 主張と読者を決める | 見出し、根拠、未確認事項 |
| 情報整理 | 未整理メモを3分類する | 件数一致、保留理由 |
| ドキュメント管理 | 正本ドキュメントを決める | README導線、矛盾解消 |
| コーディング | 最初のユーザー操作を通す | テスト、型チェック、起動確認 |

## 最小導入手順

```bash
cp templates-practical/AGENTS.md <project>/
cp templates-practical/feature_list.json <project>/
cp templates-practical/claude-progress.md <project>/
cp templates-practical/init.sh <project>/
```

コピー後に必ず行うこと:

1. `feature_list.json` のサンプルを実タスクに置き換える
2. `claude-progress.md` の Current Verified State を埋める
3. `init.sh` のコマンドを実プロジェクト用に書き換える
4. 最初の検証を実行し、結果を evidence に残す
