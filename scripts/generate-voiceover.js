import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import process from "node:process";

const apiKey = process.env.OPENAI_API_KEY;
const inputPath = process.env.VOICEOVER_TEXT_PATH || "scripts/voiceover.txt";
const outputPath = process.env.VOICEOVER_OUTPUT_PATH || "assets/voiceover.mp3";
const model = process.env.OPENAI_TTS_MODEL || "gpt-4o-mini-tts";
const voice = process.env.OPENAI_TTS_VOICE || "marin";
const instructions =
  process.env.OPENAI_TTS_INSTRUCTIONS ||
  "请用成熟、清晰、专业、有商业质感的中文普通话男声朗读。节奏适合30秒竖屏信息流广告，语气稳重、有信任感，不要夸张。";

if (!apiKey) {
  console.error("Missing OPENAI_API_KEY. 请先配置环境变量：export OPENAI_API_KEY=\"你的 OpenAI API Key\"");
  process.exit(1);
}

const input = (await readFile(inputPath, "utf8")).trim();

if (!input) {
  console.error(`Voiceover text is empty: ${inputPath}`);
  process.exit(1);
}

if (input.length > 4096) {
  console.error(`Voiceover text is ${input.length} characters, which exceeds the Speech API 4096 character limit.`);
  process.exit(1);
}

console.log(`Generating OpenAI TTS voiceover from ${inputPath}...`);
console.log(`Model: ${model}`);
console.log(`Voice: ${voice}`);

let response;
try {
  response = await fetch("https://api.openai.com/v1/audio/speech", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model,
      voice,
      input,
      instructions,
      response_format: "mp3",
    }),
  });
} catch (error) {
  console.error("OpenAI Speech API request failed before receiving a response.");
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
}

if (!response.ok) {
  const message = await response.text();
  console.error(`OpenAI Speech API request failed: ${response.status} ${response.statusText}`);
  console.error(message);
  process.exit(1);
}

const buffer = Buffer.from(await response.arrayBuffer());
await mkdir(path.dirname(outputPath), { recursive: true });
await writeFile(outputPath, buffer);

console.log(`Voiceover written to ${outputPath}`);
