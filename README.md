# CardCraft Engineering Portfolio

> A bilingual engineering portfolio for a Godot-based digital card game project. This repository is intentionally **not** the game source or a distributable build.

## 项目简介 / Overview

《卡制工程》是一个以 Godot 为客户端、以 Steam 平台服务支持好友房间和快速匹配的数字卡牌项目。本作品集记录我在项目中负责的工程工作：联机状态管理、Workshop 内容生命周期、DLC 外观兼容、存档边界、国际化回归，以及 Windows 发布验证。

CardCraft Engineering is a Godot-based digital card game project using Steam platform services for friend lobbies and quick matchmaking. This portfolio documents my engineering work across online state management, Workshop content lifecycle, DLC cosmetic compatibility, persistence boundaries, localization regression, and Windows release verification.

## 我的职责 / My Role

- 设计和维护 Steam 初始化、Lobby 生命周期和 P2P 对局状态机。
- 将 Workshop 内容限制为可验证的声明式数据，并建立发布、搜索、订阅、取消订阅和本地隔离流程。
- 处理无 DLC 客户端的外观回退、远端头像/卡面传输和 ACK 重试。
- 使用 Godot headless、运行冒烟、专项回归和截图检查验证候选版本。
- 记录阻塞问题、复现步骤、修复边界和未覆盖风险，支持 SteamPipe 隔离发布。

- Designed and maintained Steam initialization, lobby lifecycle, and the P2P battle state machine.
- Constrained Workshop content to validated declarative data with publish, search, subscribe, unsubscribe, and local isolation flows.
- Implemented cosmetic fallback for players without DLC, remote avatar/card-cover transfer, and ACK-based retries.
- Used Godot headless parsing, runtime smoke checks, focused regressions, and screenshot checks to validate release candidates.
- Recorded blocking defects, reproduction steps, fix boundaries, and residual risks for isolated SteamPipe releases.

## 技术栈 / Technology

`Godot 4.7.1` · `GDScript` · `Steamworks` · `P2P networking` · `Workshop UGC` · `Windows` · `Git`

## 工程成果 / Engineering Outcomes

- 让 Steam 初始化和 Lobby 清理保持幂等，减少重复回调造成的卡死和“仍在房间”状态。
- 将网络校验集中在类型、边界、身份、回合和资源安全上，避免把本地牌组合法性误当成网络握手条件。
- 用 ACK 确认解决首包丢失导致的永久红色卡面的体验问题。
- 将 DLC 影响限制在安全的外观枚举和默认回退，不把 DLC 所有权带入战斗规则。
- 通过十语言主流程、1280×720 和 1920×1080 布局检查，控制长文本对战斗区域的影响。

- Made Steam initialization and lobby cleanup idempotent to reduce deadlocks and stale-room state caused by duplicate callbacks.
- Kept network validation focused on types, bounds, identity, turn, and resource safety instead of treating local deck legality as a handshake requirement.
- Used ACK confirmation to recover from first-packet loss and prevent permanent missing card covers.
- Limited DLC influence to safe cosmetic enums and default fallbacks, keeping ownership out of battle rules.
- Used ten-language flow checks and 1280×720 / 1920×1080 layout checks to contain long-text pressure on the battle area.

## 文档导航 / Documentation

- [架构说明 / Architecture](docs/architecture.md)
- [工程案例 / Case Studies](docs/case-studies.md)
- [测试与发布 / Testing and Release](docs/testing-and-release.md)
- [安全边界 / Security Boundary](docs/security-boundary.md)
- [脱敏示例 / Sanitized Examples](examples/)

## 公开范围说明 / Disclosure

本仓库是为求职和技术交流准备的脱敏作品集。示例代码是重新编写的最小模型，不是生产游戏代码；仓库不包含游戏源码、场景、构建产物、美术音频、商店素材、平台标识、账号信息、密钥、日志或本机路径。

This repository is a sanitized portfolio for applications and technical discussion. The examples are rewritten minimal models, not production game code. The repository contains no game source, scenes, builds, art/audio, store materials, platform identifiers, account information, keys, logs, or local paths.
