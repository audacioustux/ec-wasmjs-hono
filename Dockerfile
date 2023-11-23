FROM node:20 as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY build.js ./
COPY src ./src

RUN npm run build

RUN chmod -R 777 /app/bin

FROM tanjim/wasmjs:latest

COPY --from=builder /app/bin /app

ENTRYPOINT [ "wasmjs-runtime", "/app" ]
