# Engineering Case Studies / 工程案例

## 1. Idempotent online initialization / Steam 初始化幂等

**Symptom / 现象:** Re-entering the online screen could attach duplicate callbacks, leave a stale lobby reference, or make the next action report that the player was still in a room.

**Root cause / 根因:** UI lifetime and platform callback lifetime were coupled. Cleanup was performed only on the happy path.

**Fix / 修复:** Centralized initialization behind an idempotent guard, made signal binding explicit, and used one exit path to cancel matchmaking, leave the lobby, close P2P sessions, and clear cached members.

**Regression evidence / 回归证据:** Repeated entry, cancellation, friend-room exit, and quick-match restart were exercised in headless protocol checks and runtime smoke checks. The expected invariant is one callback per event and no inherited lobby state after returning to the menu.

## 2. Safe Workshop data / Workshop 安全数据边界

**Symptom / 现象:** Imported card/deck packages could be rejected inconsistently, while a permissive parser would make future content execution risks harder to control.

**Root cause / 根因:** Transport, package validation, and UI search state were mixed together. A package was treated as an opaque payload instead of a bounded data document.

**Fix / 修复:** Added a quarantine-to-install flow, explicit top-level schema, size and path limits, allowlisted content types, and query handles that ignore stale callbacks. Packages contain declarative values only.

**Regression evidence / 回归证据:** Tests cover valid card/deck data, malformed fields, traversal-like paths, oversized values, unknown keys, duplicate titles, subscribe/unsubscribe transitions, and old search results arriving after a new query.

## 3. Reliable first-use card covers / 首次出牌卡面可靠传输

**Symptom / 现象:** A remote Workshop card could remain a red placeholder when its first cover packet was lost.

**Root cause / 根因:** The sender marked a cover as delivered when it was queued, not when the receiver acknowledged it.

**Fix / 修复:** Keep the cover in a pending map until `cover_ack` arrives. A small heartbeat retry resends pending covers; the receiver caches data before applying it to a card node.

**Regression evidence / 回归证据:** The focused test drops the first delivery, verifies a retry remains pending, then sends an ACK and verifies the key is removed exactly once.

## 4. DLC cosmetics and localization-safe layout / DLC 外观与多语言布局

**Symptom / 现象:** A client without DLC could see a default avatar instead of the other player's cosmetic frame, and long translations could squeeze the battle area.

**Root cause / 根因:** Cosmetics were resolved only from local ownership, while flexible labels had no stable layout budget.

**Fix / 修复:** Send only allowlisted cosmetic enums and optional image bytes; resolve them against a local asset or a default fallback. UI panels use stable dimensions, wrapping, and constrained text regions.

**Regression evidence / 回归证据:** Cross-ownership checks verify the same battle state with different local DLC availability. Ten-language screenshots at two target resolutions check clipping, overlap, and stable panel widths.
