# Lecture 07: なぜエージェントはやりすぎて、やり遂げないのか

> コード例: [code/](https://github.com/walkinglabs/learn-harness-engineering/blob/main/docs/en/lectures/lecture-07-why-agents-overreach-and-under-finish/code/) 実践プロジェクト: [Project 04. Runtime feedback and scope control](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-04-incremental-indexing/)

「このプロジェクトにユーザー認証を追加して」と頼むと、エージェントはDBスキーマを変え、ルートを書き、フロントエンドを修正し、ついでにエラーハンドリングまでリファクタリングする。2時間後、12ファイル変更・800行追加で、エンドツーエンドで動く機能はゼロ。

エージェントには「ついでにもう少し」やる衝動が生まれつき備わっている。一度に多くをやれば、どれも仕上がらないことがほぼ保証される。Anthropicは「プロンプトが広すぎるとエージェントは『1つを終わらせる』のではなく『複数を同時に始める』傾向がある」と明言し、OpenAIも明示的なスコープ制御のないタスクは完成率が急落すると報告している。これはモデルの問題ではなくハーネスの問題、つまり境界を引かなかった側の問題である。

## 注意力は有限資源である

これは比喩ではなく数学。コンテキスト容量Cでk個のタスクを同時に活性化すると、各タスクは平均C/kの推論資源しか得られない。C/kが単一タスク完了の最低閾値を下回れば、どれも完成しない。

Anthropicの実験データ: 「小さな次の一歩」戦略（WIP=1相当）のエージェントは、広いプロンプトのエージェントよりタスク完成率が37%高い。さらに、生成コード行数と実際の機能完成率は弱い負の相関を示す。書けば書くほど完成しない。

## 核心概念

- **オーバーリーチ（Overreach）**: 1セッションで最適数を超えるタスクを活性化すること。「5機能着手・E2Eパス0件」のように定量化できる
- **アンダーフィニッシュ（Under-finish）**: 着手タスクのうちE2E検証を通過した比率が閾値を下回ること。コードは書いたがテストが通らない状態
- **WIP制限（Work-in-Progress Limit）**: カンバン由来。同時進行タスク数を制限する。エージェントにはWIP=1が最も安全なデフォルト
- **完了証拠（Completion Evidence）**: タスクを「進行中」から「完了」に移すために満たすべき検証可能な条件。これがないと「コードが良さそうに見える」が「振る舞いがテストを通った」の代用にされる
- **スコープ面（Scope Surface）**: 作業単位をノード、依存をエッジとするDAG構造。状態は not_started / active / blocked / passing の4つに限定
- **完成圧力（Completion Pressure）**: WIP制限と完了証拠の要求を通じて、ハーネスが「今のタスクを終えてから次へ」を強制する力

## オーバーリーチとアンダーフィニッシュは表裏一体

両者は独立ではなく相互増幅する。オーバーリーチが注意を希釈し、希釈がアンダーフィニッシュを生み、残された中途半端なコードがシステムの複雑性を上げて次のオーバーリーチを誘発する悪循環。リトルの法則（L = λW）が示す通り、仕掛かり数Lが増えれば各タスクのリードタイムWは必然的に伸びる。人間にはまだ「もう十分やった」という直感があるが、エージェントにはない。「ついでにこれも直そう」と書くトークンコストはほぼゼロだが、追加修正のたびに注意は希釈される。

## 実践方法

1. **WIP=1を強制する**: CLAUDE.md / AGENTS.md に明記する。「一度に1機能のみ」「現在の機能がE2E検証を通過してから次へ」「機能A実装中に機能Bを『ついでにリファクタリング』しない」
2. **すべてのタスクに明示的な完了証拠を定義する**: 完了とは「コードを書いた」ではなく「振る舞い検証が通った」。feature list の各項目に検証コマンドを付ける（例: `curl -X POST /api/register ... | jq .status == 201`）
3. **スコープ面を外部化する**: 機械可読ファイル（JSONかMarkdown）に全タスク状態を記録する。新セッションはそれを読むだけで「どれがactiveか・何ができたら完了か・どの検証が通ったか」を即座に把握できる
4. **検証済み完了率を監視する**: VCR（Verified Completion Rate）= 検証済みタスク数 / 着手タスク数 を追跡し、VCR < 1.0 のあいだは新規タスクの活性化をブロックする

## 実例

8機能のREST APIプロジェクトで2戦略を比較:

- **無制約モード**: セッション1で5機能を同時着手。12ファイル約800行を生成、E2Eテスト合格率20%（動くのはユーザー登録のみ）。セッション3終了時点で8機能中3つしか完成せず
- **WIP=1モード**: セッション1はユーザー登録のみ。4ファイル約200行、E2Eテスト100%合格。セッション4終了時点で8機能中7つ完成（残り1つは外部依存でblocked）

総コード量は少ない（800行 vs 1200行）が有効なコードは多い。完成率は87.5% vs 37.5%。

## 要点

- **WIP=1はエージェントハーネスのデフォルト安全設定**。1つ終えてから次へ。並列化を試みない
- **完了証拠は実行可能でなければならない**。「コードが良さそう」は不可、「curlが201を返す」は可
- **スコープ面はファイルとして外部化する**。会話で触れるだけでなく、機械可読形式でリポジトリに記録する
- **オーバーリーチとアンダーフィニッシュは共生関係**。片方を解決すればもう片方も解決する
- **「少なくやって仕上げる」は常に「多くやって半端に残す」に勝る**。質は常に量に勝つ

## 参考文献

- [Effective harnesses for long-running agents - Anthropic](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Harness Engineering - OpenAI](https://openai.com/index/harness-engineering/)
- [Kanban: Successful Evolutionary Change - David Anderson](https://www.goodreads.com/book/show/1070822.Kanban)
- [Rapid Development - Steve McConnell](https://www.goodreads.com/book/show/125171.Rapid_Development)

---

出典: https://walkinglabs.github.io/learn-harness-engineering/en/lectures/lecture-07-why-agents-overreach-and-under-finish/
