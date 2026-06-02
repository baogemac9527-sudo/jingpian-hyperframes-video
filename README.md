# Jingpian HyperFrames Video

这是一个面向「鲸片剪辑」服务商白标剪辑产能支持的 HyperFrames 视频生成项目。项目使用 Node.js + HyperFrames，把 HTML/CSS 时间线渲染为 30 秒 9:16 竖屏 MP4，适合抖音信息流服务商广告物料预览与交付。

## 视频方案

- **主题**：服务商手里有客户，视频交付找鲸片。
- **比例**：9:16 竖屏，`1080 × 1920`
- **时长**：30 秒，30 FPS
- **输出文件**：`dist/jingpian-service-provider-ad.mp4`
- **目标受众**：短视频服务商、IP 孵化团队、知识内容团队，以及手里有客户但缺剪辑交付产能的团队。
- **核心表达**：鲸片剪辑为短视频服务商提供白标剪辑交付支持，不露品牌，不抢客户，只做幕后视频剪辑产能支持。
- **风格**：科技感、高级感、商业感；深色背景、蓝紫渐变、数据流、玻璃拟态卡片、大字高识别。
- **声音**：通过浏览器 `speechSynthesis` 选择中文人声朗读每个分镜文案；预览或渲染环境需要提供可用的 `zh-CN` 系统语音。
- **文案边界**：只突出「视频剪辑、素材制作、批量交付、白标产能支持、先试剪满意再合作」，不写超出视频剪辑交付范围的服务表达。

## 30 秒分镜

| 时间 | 画面 / 文案 |
| --- | --- |
| 0-3 秒 | 做短视频服务的老板，手里有客户，但剪辑交付跟不上？ |
| 3-7 秒 | 客户越多，需求越杂，修改越多，交付越容易乱。 |
| 7-11 秒 | 服务商真正缺的，不只是剪辑师，而是一套稳定的视频交付产能。 |
| 11-16 秒 | 鲸片剪辑，为短视频服务商提供白标剪辑产能支持。 |
| 16-21 秒 | 不露品牌，不抢客户，只做幕后交付。 |
| 21-25 秒 | 口播视频、信息流素材、直播切片、知识内容、商业短视频，都可以批量承接。 |
| 25-28 秒 | 先试剪一条，确认标准，满意后长期合作。 |
| 28-30 秒 | 视频交付，找鲸片剪辑。 |

## 配音说明

当前 Codex 环境没有可用的真人配音 / TTS skill，也无法通过受限网络安装或调用外部 TTS 包。因此项目在 `index.html` 内置了 Web Speech API 旁白脚本：优先选择 `zh-CN` 中文人声，按 0s、3s、7s、11s、16s、21s、25s、28s 的分镜时间自动朗读对应文案。

如果渲染机器没有中文系统语音，请先安装中文语音包，或把专业真人录音文件放入项目后，将 `index.html` 中的 Web Speech 旁白替换为 HyperFrames 支持的 `<audio src="..." />` 音轨。

## 项目结构

```text
.
├── index.html        # HyperFrames 30 秒 9:16 竖屏广告视频时间线
├── package.json      # Node.js scripts 与 HyperFrames 依赖
├── scripts/
│   └── setup.sh      # 自动检查 Node、安装 FFmpeg/字体、安装 npm 依赖
└── README.md         # 使用说明
```

## 环境要求

- Node.js `>= 22`
- npm
- FFmpeg `>= 6`（`npm run setup` 会在支持的 Linux 包管理器中自动安装）
- 中文字体（`npm run setup` 会尝试安装 Noto CJK 字体，避免中文渲染缺字）

## 初始化 / 补齐依赖

```bash
npm run setup
```

该命令会：

1. 检查 Node.js 主版本是否满足 `>= 22`；
2. 如果缺少 FFmpeg，会在 Linux 环境中尝试通过 `apt-get`、`dnf` 或 `yum` 安装 FFmpeg、证书和中文字体；
3. 执行 `npm install` 安装 HyperFrames；
4. 执行 `npx hyperframes doctor` 检查渲染环境。

> 如果当前云端环境的 npm registry 被安全策略限制，请在可访问 npm 的环境运行同样命令，或配置允许访问 `hyperframes` npm 包的 registry 后重试。

## 预览视频

```bash
npm run preview
```

默认在 `http://localhost:3002` 启动 HyperFrames Studio，可拖动时间线预览每一帧。

## 检查时间线

```bash
npm run lint
```

该命令使用 HyperFrames linter 检查 `index.html` 的结构、尺寸、时长和时间线属性。

## 导出 MP4

```bash
npm run render
```

渲染完成后，MP4 会输出到：

```text
dist/jingpian-service-provider-ad.mp4
```

## 截取关键帧

```bash
npm run snapshot
```

该命令会在 `snapshots/` 中输出 1.5s、5s、9s、13.5s、18.5s、23s、26.5s、29s 的关键帧 PNG，方便在不完整渲染 MP4 的情况下快速检查版式。
