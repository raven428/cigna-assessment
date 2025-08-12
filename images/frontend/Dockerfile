FROM node:10 AS builder
WORKDIR /app
COPY download/package*.json .
RUN npm ci
COPY download/. .
RUN npm run build

FROM node:20-slim
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /app/build .
EXPOSE 3000
CMD ["npx", "serve", "-s", ".", "-l", "3000"]
