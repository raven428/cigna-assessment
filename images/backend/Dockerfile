FROM node:20 AS builder
WORKDIR /app
RUN rm -rf /download/.git && cp -r /download/* . && npm ci --omit=dev

FROM node:20-slim
WORKDIR /app
COPY --from=builder /app .
EXPOSE 3000
CMD ["node", "app.js"]
