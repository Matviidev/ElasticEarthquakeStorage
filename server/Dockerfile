FROM node:22-slim

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm ci

COPY . .

COPY init-es.sh ./init-es.sh
RUN chmod +x ./init-es.sh

EXPOSE 3000

CMD ["sh", "./init-es.sh", "&&", "node", "server.js" ]
