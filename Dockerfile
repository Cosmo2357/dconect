# ベースイメージとしてUbuntuを使用
FROM ubuntu:20.04

# 環境変数の設定
ENV NODE_VERSION=16.x

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        gnupg2 \
        lsb-release && \
    curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
WORKDIR /app

# アプリケーションのコードをコピー
COPY . .

# 依存関係をインストール
RUN npm install || echo "npm install failed"  # エラーメッセージを表示

# アプリケーションを起動
CMD ["node", "index.js"]
