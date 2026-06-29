#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$(dirname "$(find /opt -maxdepth 3 -type f -name 'aria-csd-miner' | head -n1)")"
BIN="$BIN_DIR/aria-csd-miner"
LIBDIR="$BIN_DIR/lib"

if [[ ! -x "$BIN" ]]; then
  echo "aria-csd-miner binary not found" >&2
  exit 1
fi

if [[ -z "${ARIA_ADDRESS:-}" ]]; then
  echo "ARIA_ADDRESS is required" >&2
  exit 1
fi

export LD_LIBRARY_PATH="$LIBDIR:${LD_LIBRARY_PATH:-}"
worker="${ARIA_WORKER:-$(hostname | tr -cd '[:alnum:]-' | cut -c1-24)}"
args=(--pool "${ARIA_POOL:-csd.ariabrain.com:13333}" --address "$ARIA_ADDRESS" --worker "$worker" --gpu)
if [[ -n "${ARIA_GPU:-}" ]]; then
  args+=(--device "$ARIA_GPU")
fi
if [[ -n "${ARIA_THREADS:-}" ]]; then
  args+=(--threads "$ARIA_THREADS")
fi
exec "$BIN" "${args[@]}"
