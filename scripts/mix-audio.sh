#!/usr/bin/env bash
set -euo pipefail

VIDEO_INPUT="${VIDEO_INPUT:-dist/jingpian-service-provider-ad.mp4}"
VOICEOVER_INPUT="${VOICEOVER_INPUT:-assets/voiceover.mp3}"
FINAL_OUTPUT="${FINAL_OUTPUT:-dist/jingpian-service-provider-ad-final.mp4}"

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg not found. Please install FFmpeg before running npm run mix-audio." >&2
  exit 1
fi

if [[ ! -f "$VIDEO_INPUT" ]]; then
  echo "Missing rendered video: $VIDEO_INPUT" >&2
  echo "Please run npm run render first." >&2
  exit 1
fi

if [[ ! -f "$VOICEOVER_INPUT" ]]; then
  echo "Missing voiceover audio: $VOICEOVER_INPUT" >&2
  echo "Please run npm run generate-voiceover first." >&2
  exit 1
fi

mkdir -p "$(dirname "$FINAL_OUTPUT")"

echo "Mixing $VIDEO_INPUT + $VOICEOVER_INPUT -> $FINAL_OUTPUT"
ffmpeg -y \
  -i "$VIDEO_INPUT" \
  -i "$VOICEOVER_INPUT" \
  -filter_complex "[1:a]apad[aout]" \
  -map 0:v:0 \
  -map "[aout]" \
  -c:v copy \
  -c:a aac \
  -b:a 192k \
  -shortest \
  -movflags +faststart \
  "$FINAL_OUTPUT"

echo "Final video written to $FINAL_OUTPUT"
