# Testing and Release / 测试与发布

## Validation layers / 验证层次

1. **Static parsing / 静态解析** — Run Godot 4.7.1 in headless editor mode against the project and examples; treat parse errors as blocking.
2. **Focused logic / 专项逻辑** — Exercise packet boundaries, turn order, Workshop schema, retry state, save migration, Demo restrictions, and DLC fallback with deterministic fixtures.
3. **Runtime smoke / 运行冒烟** — Start clean Full, Demo, and DLC-mode exports on Windows and verify menu, settings, deck editor, battle entry, and graceful exit.
4. **Online regression / 联机回归** — Cover friend lobbies, quick-match cancellation, lobby cleanup, host/guest start, cross-language clients, and cosmetic fallback. Record peer-visible state, not private credentials.
5. **Workshop safety / Workshop 安全** — Verify quarantine, validation, search freshness, subscription changes, duplicate-title rules, and rejection of executable or script-like content.
6. **Visual checks / 视觉检查** — Capture 1280×720 and 1920×1080 states for battle panels, action dock, hand dock, notices, long translations, avatars, and card covers.
7. **Release isolation / 发布隔离** — Export into a new candidate directory, create a file manifest and SHA-256 record privately, scan for tests/logs/cache/MCP files, and never overwrite an existing build.

## Evidence pattern / 证据格式

Every blocking defect is recorded with:

- reproduction steps / 复现步骤;
- observed and expected behavior / 实际与期望行为;
- root cause and scope of the fix / 根因与修复边界;
- focused regression command and result / 专项回归命令与结果;
- residual risk and real-device acceptance item / 未覆盖风险与真实设备验收项。

## Release discipline / 发布纪律

Only a blocking defect justifies a new build. A candidate must pass parsing, startup, client smoke, release isolation, and diff checks before any private upload workflow. Store copy, store imagery, public branches, and review submission are outside this engineering workflow.

只有阻塞性缺陷才允许生成新构建。候选版本必须先通过解析、启动、客户端冒烟、发布隔离和差异检查，才可进入私有上传流程。商店文案、商店图片、公开分支和审核提交不属于本工程流程。
