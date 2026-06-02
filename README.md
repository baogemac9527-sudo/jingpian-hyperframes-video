# Jingpian HyperFrames Video

这是一个面向「鲸片」短视频剪辑服务的 HyperFrames 视频生成 demo。项目使用 Node.js + HyperFrames，把 HTML/CSS 时间线渲染为 9:16 竖屏 MP4，适合抖音信息流广告物料预览与交付。

## 视频方案

- **主题**：剪视频，找鲸片
- **比例**：9:16 竖屏，`1080 × 1920`
- **时长**：8 秒，30 FPS
- **风格**：纯色背景、大字高识别、简单粗暴、强对比，适合抖音信息流
- **文案边界**：只突出「视频剪辑、素材制作、批量交付、先试剪满意再合作」，不写代运营、涨粉、获客承诺

## 项目结构

```text
.
├── index.html        # HyperFrames 9:16 竖屏广告视频时间线
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
dist/jingpian-hyperframes-demo.mp4
```

## 截取关键帧

```bash
npm run snapshot
```

该命令会在 `snapshots/` 中输出 0.5s、2.1s、4.2s、6.8s 的关键帧 PNG，方便在不完整渲染 MP4 的情况下快速检查版式。
