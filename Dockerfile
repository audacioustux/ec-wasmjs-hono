FROM node:20 as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY build.js ./
COPY src ./src

RUN chmod -R 777 /app
RUN npm run build

FROM tanjim/wasmjs:latest

COPY --from=builder /app/bin ./
