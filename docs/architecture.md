# Architecture / 架构说明

## Boundary model / 边界模型

```text
Godot UI and game state
        |
        +--> platform adapter ----> Steam lobbies / presence / P2P transport
        |                                  |
        |                                  +--> online battle packets
        |
        +--> Workshop service ----> query / publish / subscribe / quarantine store
        |
        +--> persistence boundary -> schema versioning / recovery / mode isolation
        |
        +--> cosmetic resolver ----> DLC enum -> local asset or default fallback
```

The client owns presentation and local game state. A narrow platform adapter owns Steam callbacks and translates them into application events. Lobby discovery and friend-room entry share the same lifecycle primitives, while matchmaking adds only queue metadata and cancellation state.

客户端负责表现层和本地游戏状态。平台适配层集中处理 Steam 回调，并转换为应用事件。好友房间和快速匹配共用同一套生命周期原语，快速匹配只额外增加队列元数据和取消状态。

## Online state / 联机状态

The battle transport carries typed, bounded messages. Identity, sender, lobby membership, turn, hand index, resource cost, and payload size are checked at the boundary. Local deck legality belongs to deck building and Workshop import, not to every P2P action.

联机传输使用有类型、有边界的消息。边界层校验身份、发送者、房间成员、回合、手牌索引、资源费用和包大小。本地牌组合法性属于制卡和 Workshop 导入流程，不重复成为每个 P2P 动作的握手条件。

Remote visual data is intentionally separate from rules. Avatar PNG data and cosmetic enums can arrive before the UI node exists; the receiver caches them and applies them when the node is ready. DLC ownership is never inferred from a remote packet.

远端外观数据与规则分离。头像 PNG 和外观枚举可以在 UI 节点创建前到达，接收端先缓存，节点就绪后再应用。不会从远端数据推断 DLC 所有权。

## Workshop boundary / Workshop 边界

Workshop content is downloaded into a quarantine area, validated as data, and promoted only after schema, size, path, and content-type checks pass. The runtime never evaluates downloaded scripts or executes external programs. Search callbacks are associated with a query handle so late results cannot overwrite a newer search.

Workshop 内容先下载到隔离区，经过 schema、大小、路径和内容类型校验后才进入安装区。运行时不会执行下载脚本或外部程序。搜索回调绑定查询句柄，旧查询的迟到结果不能覆盖新查询。

## Persistence and release / 存档与发布

Save data is versioned and recovered through a bounded migration path. Demo data is isolated from the full product mode. Windows release candidates are exported to a clean directory, smoke-tested, scanned for forbidden files, and recorded with a manifest outside the public portfolio.

存档带有 schema 版本，并通过有边界的迁移路径恢复。Demo 存档与正式版模式隔离。Windows 候选构建导出到干净目录，完成启动冒烟和禁带文件扫描，清单保存在公开作品集之外。
