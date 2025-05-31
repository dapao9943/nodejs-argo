FROM node:20

# 安装 cloudflared
RUN apt-get update && apt-get install -y wget \
    && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x /usr/local/bin/cloudflared

WORKDIR /app

COPY . .

RUN npm install

ENV PORT=8080

EXPOSE 8080

# 启动 cloudflared 和 node
CMD cloudflared tunnel --url http://localhost:8080 & node index.js
