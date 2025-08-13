FROM node:14 AS builder
WORKDIR /app
RUN rm -rf /download/.git && cp -r /download/* . && npm ci && npm run build

FROM node:20-slim
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /app/dist/Big4Health .
EXPOSE 3000
CMD ["serve", "-s", ".", "-l", "3000"]
