# Security Boundary / 安全边界

## Threat model / 威胁模型

Workshop data is untrusted input. It may be malformed, oversized, deliberately ambiguous, or crafted to escape an installation directory. A peer packet is also untrusted input and may be duplicated, delayed, reordered, or sent out of turn.

Workshop 数据是不可信输入，可能格式错误、过大、语义歧义，或试图逃出安装目录。联机对端数据同样不可信，可能重复、延迟、乱序或在错误回合发送。

## Rules / 规则

- Parse data; never evaluate downloaded code.
- Allowlist fields and scalar types; reject unknown top-level fields.
- Bound strings, arrays, byte payloads, and numeric ranges.
- Reject path traversal, executable extensions, script-like fields, and dynamic resource instructions.
- Authenticate sender and lobby context before applying a battle action.
- Keep visual cosmetics separate from gameplay rules and DLC ownership.
- Treat an ACK as delivery confirmation; queued data is not delivered data.

- 只解析数据，不执行下载代码。
- 白名单限制字段和标量类型，拒绝未知顶层字段。
- 限制字符串、数组、字节载荷和数字范围。
- 拒绝路径穿越、可执行扩展名、脚本字段和动态资源指令。
- 应用战斗动作前校验发送者和房间上下文。
- 将外观与战斗规则、DLC 所有权分离。
- ACK 才代表送达确认，排队不等于送达。

The examples in `examples/` demonstrate these boundaries without performing I/O or contacting any service.

`examples/` 中的示例展示这些边界，但不执行 I/O，也不连接任何服务。
