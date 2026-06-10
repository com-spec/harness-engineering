# Learn Harness Engineering へようこそ

Learn Harness Engineering は、AIコーディングエージェントの「エンジニアリング」に特化したコースである。業界で最も先進的なハーネスエンジニアリング（Harness Engineering: モデルの外側にある実行環境・ルール・検証の仕組みを設計する技術）の理論と実践を体系的にまとめている。

主要な参照元:

- [OpenAI: Harness engineering: leveraging Codex in an agent-first world](https://openai.com/index/harness-engineering/)
- [Anthropic: Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Anthropic: Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Awesome Harness Engineering](https://github.com/walkinglabs/awesome-harness-engineering)

このコースで学ぶのは、環境設計・状態管理・検証・制御の体系を通じて、Codex や Claude Code のようなエージェント型コーディングツールを本当に信頼できるものにする方法である。明示的なルールと境界でAIコーディングアシスタントを制約することで、機能開発・バグ修正・開発タスクの自動化を安定して回せるようになる。

## はじめかた

コースは「理論講義」「実践プロジェクト」「コピーして使えるリソースライブラリ」の3部構成。自分に合う学習パスを選んで始める。

### [Lectures（講義）](https://walkinglabs.github.io/learn-harness-engineering/en/lectures/lecture-01-why-capable-agents-still-fail/)

強いモデルがなぜ失敗するのかを理解し、効果的なハーネスの背後にある理論を学ぶ。

### [Projects（プロジェクト）](https://walkinglabs.github.io/learn-harness-engineering/en/projects/)

信頼できるエージェント環境をゼロから構築するハンズオン実践。

### [Resource Library（リソースライブラリ）](https://walkinglabs.github.io/learn-harness-engineering/en/resources/)

自分のリポジトリにそのままコピーして使えるテンプレート集（AGENTS.md, feature_list.json）。

## ハーネスの中核メカニズム

ハーネスは「モデルを賢くする」ものではない。モデルに対して閉ループの「作業システム」を確立するものである。指示を与え、実行させ、検証し、その結果を次の行動にフィードバックするループを回す。

## このコースで身につくこと

- **エージェントの行動を制約する**: 明示的なルールと境界を引く
- **コンテキストを維持する**: 長時間・複数セッションにまたがるタスクで文脈を失わない
- **早すぎる「完了宣言」を防ぐ**: エージェントが勝手に勝利宣言するのを止める
- **作業を検証する**: フルパイプラインのテストと自己振り返りで成果を確かめる
- **実行時を観測可能にする**: 動作を見える化し、デバッグ可能にする

## 次のステップ

中核概念を理解したら、以下で深掘りする。

- [Lecture 01: Why Capable Agents Still Fail](https://walkinglabs.github.io/learn-harness-engineering/en/lectures/lecture-01-why-capable-agents-still-fail/): ハーネスエンジニアリングの理論から始める
- [Project 01: Baseline vs Minimal Harness](https://walkinglabs.github.io/learn-harness-engineering/en/projects/project-01-baseline-vs-minimal-harness/): 最初の実タスクを体験する
- [Templates](https://walkinglabs.github.io/learn-harness-engineering/en/resources/templates/): 最小ハーネスパック（AGENTS.md, feature_list.json, claude-progress.md）を自分のプロジェクトに導入する

---

出典: https://walkinglabs.github.io/learn-harness-engineering/en/
