#!/usr/bin/env bash
# Builds the site, serves dist/ and opens it in Chrome. Ctrl+C stops the server.
# Usage: ./preview.sh [port]
set -euo pipefail

PORT="${1:-8000}"
URL="http://localhost:$PORT"

cd "$(dirname "$0")"

if lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Try: ./preview.sh $((PORT + 1))" >&2
  exit 1
fi

ruby build.rb

python3 -m http.server "$PORT" --directory dist &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT

until curl -sf -o /dev/null "$URL"; do
  kill -0 "$SERVER_PID" 2>/dev/null || { echo "Server failed to start" >&2; exit 1; }
  sleep 0.1
done

open -a "Google Chrome" "$URL"
echo "Serving $URL (Ctrl+C to stop)"
wait "$SERVER_PID"
