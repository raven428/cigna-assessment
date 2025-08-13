#!/usr/bin/env bash
mongod --bind_ip 127.0.0.1 &
find /download/dump -type f -name '*.bson' -print0 | \
while IFS= read -r -d '' f; do
  mongorestore \
    --uri="mongodb://127.0.0.1:27017" \
    --db=big4health \
    --collection="$(basename "$f" .bson)" \
    "$f"
done
