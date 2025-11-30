# zshrc_generator.sh

## 概要

`zshrc_generator.sh` は、利用可能なコマンドやツールを自動検出して、最適化された `.zshrc` を生成するシェルスクリプトです。
個人の環境ごとに異なる設定やエイリアスを、手動編集せずに素早く反映できます。

## 特徴

- 利用可能なエディタやツール（nvim, starship, direnv など）を自動判定
- 必要な設定・エイリアスのみを `.zshrc` に記述
- 生成した `.zshrc` はシンプルで見やすい
- スクリプト自体をバージョン管理することで、設定の再現性・移植性が向上

## インストールと使い方

1. 本リポジトリをクローン、または `zshrc_generator.sh` をダウンロードします。
2. スクリプトを実行します。

    ```sh
    bash ./zshrc_generator.sh
    ```

4. `$HOME/.zshrc` が生成されます。
   必要に応じて、Zsh を再起動または `source ~/.zshrc` してください。

## カスタマイズ

- 追加したい設定やエイリアスがある場合は、`zshrc_generator.sh` を編集してください。
- テンプレート部分を変更することで、独自の初期設定を追加できます。

## 注意

- 既存の `.zshrc` は **上書きされます**。必要であればバックアップを取ってください。
- このスクリプトは Linux および macOS での利用を想定しています。

## 例

```sh
bash ./zshrc_generator.sh -f
# => .zshrc generated at /home/yourname/.zshrc
