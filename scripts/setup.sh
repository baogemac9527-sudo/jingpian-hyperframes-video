#!/usr/bin/env bash
set -euo pipefail

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

node_major() {
  node -v 2>/dev/null | sed -E 's/^v([0-9]+).*/\1/' || true
}

run_as_root() {
  if [[ "$(id -u)" -eq 0 ]]; then
    "$@"
  elif need_cmd sudo; then
    sudo "$@"
  else
    echo "Root privileges are required to run: $*" >&2
    echo "Install FFmpeg and CJK fonts manually, or rerun with sudo/root." >&2
    exit 1
  fi
}

install_ffmpeg_linux() {
  if need_cmd ffmpeg; then
    return 0
  fi

  if need_cmd apt-get; then
    echo "Installing FFmpeg with apt-get..."
    run_as_root apt-get update
    run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ffmpeg ca-certificates fonts-noto-cjk fonts-noto-color-emoji
    return 0
  fi

  if need_cmd dnf; then
    echo "Installing FFmpeg with dnf..."
    run_as_root dnf install -y ffmpeg ca-certificates google-noto-sans-cjk-fonts google-noto-emoji-fonts
    return 0
  fi

  if need_cmd yum; then
    echo "Installing FFmpeg with yum..."
    run_as_root yum install -y ffmpeg ca-certificates google-noto-sans-cjk-fonts google-noto-emoji-fonts
    return 0
  fi

  echo "FFmpeg is missing and no supported package manager was found." >&2
  echo "Install FFmpeg 6+ manually, then rerun npm run doctor." >&2
  exit 1
}

major="$(node_major)"
if [[ -z "$major" || "$major" -lt 22 ]]; then
  echo "Node.js >= 22 is required. Current: $(node -v 2>/dev/null || echo not installed)" >&2
  echo "Install Node.js 22+ first, then rerun npm run setup." >&2
  exit 1
fi

install_ffmpeg_linux
npm install
npx hyperframes doctor
