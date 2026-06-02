#!/usr/bin/env bash
set -euo pipefail

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

node_major() {
  node -v 2>/dev/null | sed -E 's/^v([0-9]+).*/\1/' || true
}

install_ffmpeg_linux() {
  if need_cmd ffmpeg; then
    return 0
  fi

  if need_cmd apt-get; then
    echo "Installing FFmpeg with apt-get..."
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ffmpeg ca-certificates fonts-noto-cjk fonts-noto-color-emoji
    return 0
  fi

  if need_cmd dnf; then
    echo "Installing FFmpeg with dnf..."
    dnf install -y ffmpeg ca-certificates google-noto-sans-cjk-fonts google-noto-emoji-fonts
    return 0
  fi

  if need_cmd yum; then
    echo "Installing FFmpeg with yum..."
    yum install -y ffmpeg ca-certificates google-noto-sans-cjk-fonts google-noto-emoji-fonts
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

if [[ ! -d node_modules ]]; then
  npm install
else
  npm install
fi

npx hyperframes doctor
