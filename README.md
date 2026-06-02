# Jingpian HyperFrames Video

这是一个面向「短视频服务商 / IP 孵化团队 / 知识内容团队 / 手里有客户但缺剪辑交付产能的团队」的 HyperFrames 竖屏广告项目。当前版本定位为「鲸片白标剪辑产能广告片」，用 Node.js + HyperFrames 将 HTML/CSS 时间线预览并渲染为 9:16 MP4。

## 视频方案

- **片名**：《服务商的剪辑交付后台》
- **主题**：服务商手里有客户，视频交付找鲸片
- **品牌**：鲸片剪辑
- **广告定位**：鲸片为短视频服务商提供白标剪辑交付支持，不抢客户、不露品牌，只做幕后视频剪辑产能支持
- **比例**：9:16 竖屏，`1080 × 1920`
- **时长**：30 秒，30 FPS
- **风格**：深色科技感、蓝紫渐变、网格线、数据流、玻璃拟态卡片、服务矩阵、流程动效、商业质感
- **文案边界**：只突出「视频剪辑、素材制作、批量交付、白标产能支持、先试剪满意再合作」，不出现敏感承诺类表达
- **音乐建议**：科技感、低频、节奏感强的背景音乐；当前仓库不内置音乐素材，避免版权风险

## 当前合并口径

- **创意内容**：以 PR #2 的 30 秒服务商白标剪辑产能广告片为准。
- **项目结构**：保留 main 分支已验证的 Node.js + HyperFrames 根目录结构，继续使用 `index.html`、`package.json`、`scripts/setup.sh`、`.gitignore` 与 `README.md`。
- **运行命令**：保留 `npm run preview`、`npm run lint`、`npm run snapshot`、`npm run render`，其中 `npm run render` 输出新版 30 秒广告 MP4。

## 30 秒分镜结构

| 时间 | 画面重点 | 屏幕大字 |
| --- | --- | --- |
| 0-3 秒 | 数据流聚合，喊出目标人群 | 手里有客户，缺剪辑产能？ |
| 3-8 秒 | 多个项目订单卡片弹出 | 客户越多，交付越乱 |
| 8-12 秒 | 混乱交付 vs 流程化交付 | 别让剪辑卡住业务 |
| 12-17 秒 | 鲸片剪辑品牌与白标定位 | 不露品牌｜不抢客户｜只做交付 |
| 17-21 秒 | 服务矩阵 | 多类型视频，批量承接 |
| 21-25 秒 | 试剪到批量交付流程 | 先试剪，再合作 |
| 25-28 秒 | 产能后台数据面板 | 稳定产能，标准流程 |
| 28-30 秒 | 品牌收口 | 视频交付，找鲸片剪辑 |

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

> 如果当前云端环境的 npm registry 或系统软件源被安全策略限制，请在可访问 npm/软件源的环境运行同样命令，或配置允许访问 `hyperframes` npm 包和 FFmpeg 安装源后重试。

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

该命令会在 `snapshots/` 中输出 1.5s、5.5s、10s、14.5s、19s、23s、26.5s、29s 的关键帧 PNG，方便在不完整渲染 MP4 的情况下快速检查版式。
