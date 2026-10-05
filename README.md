# CardCraft Engineering · 卡制工程

Godot / GDScript · Steamworks · P2P Networking · Workshop UGC · Windows

《卡制工程》是一款基于 Godot 的数字卡牌游戏，使用 Steam 平台服务实现好友房间和快速匹配。本仓库记录项目中的联机、内容管理、存档、国际化与发布工程，提供架构说明、问题分析和独立示例。

CardCraft Engineering is a Godot-based digital card game using Steam services for friend lobbies and matchmaking. This repository documents its networking, content management, persistence, localization, and release engineering through architecture notes, case studies, and standalone examples.

## 工程职责 / Engineering Work

| 领域 / Area | 实现与关注点 / Implementation |
| --- | --- |
| 联机 / Networking | Steam 初始化、Lobby 生命周期、P2P 对局状态与消息校验。 / Steam initialization, lobby lifecycle, P2P match state, and message validation. |
| 内容 / Content | Workshop 发布、搜索、订阅与取消订阅；声明式内容校验和本地隔离。 / Workshop publishing, search, subscriptions, declarative package validation, and local isolation. |
| 外观 / Cosmetics | DLC 默认回退、远端头像与卡面传输、ACK 确认和重试。 / DLC fallback, remote avatar and card-cover transfer, acknowledgements, and retries. |
| 存档 / Persistence | 区分持久数据和运行状态，控制载入与迁移边界。 / Separate persistent data from runtime state and define load and migration boundaries. |
| 发布 / Release | Godot headless 检查、运行冒烟、国际化与布局回归、Windows 发布验证。 / Godot headless checks, runtime smoke tests, localization and layout regression, and Windows release verification. |

## 设计案例 / Design Cases

- **房间生命周期 / Lobby lifecycle**：初始化和清理采用幂等设计，处理重复回调与残留房间状态。 / Idempotent initialization and cleanup handle repeated callbacks and stale lobby state.
- **网络校验 / Protocol validation**：校验类型、边界、身份、回合和资源访问，明确网络协议与本地牌组规则的职责。 / Validate types, bounds, identity, turns, and resource access with explicit separation from local deck rules.
- **可靠传输 / Reliable transfer**：通过 ACK 和重试处理首包丢失造成的卡面缺失。 / Acknowledgements and retries recover missing card covers after first-packet loss.
- **DLC 兼容 / DLC compatibility**：外观使用安全枚举和默认回退，保持战斗规则一致。 / Safe cosmetic enums and default fallback keep battle rules consistent.

## 阅读入口 / Documentation

- [架构 / Architecture](docs/architecture.md)
- [工程案例 / Case Studies](docs/case-studies.md)
- [测试与发布 / Testing and Release](docs/testing-and-release.md)
- [安全边界 / Security Boundary](docs/security-boundary.md)
- [协议与内容示例 / Protocol and Content Examples](examples/)

示例用于说明协议和设计决策，完整游戏源码单独维护。使用范围见 [NOTICE.md](NOTICE.md)。

The examples illustrate protocol and design decisions. The complete game source is maintained separately. See [NOTICE.md](NOTICE.md) for usage terms.
