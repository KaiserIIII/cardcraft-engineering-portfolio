class_name PortfolioProtocolValidation
extends RefCounted

## A small, service-free example of a battle action boundary.
## It validates structure and safety properties, not game-specific card rules.
static func accept_action(packet: Dictionary, expected_turn: int, hand_size: int) -> bool:
	if expected_turn < 0 or hand_size < 0:
		return false
	if typeof(packet.get("sender_side", null)) != TYPE_INT:
		return false
	if int(packet.get("sender_side", 0)) not in [1, 2]:
		return false
	if typeof(packet.get("turn", null)) != TYPE_INT:
		return false
	if int(packet.get("turn", -1)) != expected_turn:
		return false
	if typeof(packet.get("hand_index", null)) != TYPE_INT:
		return false
	var hand_index := int(packet.get("hand_index", -1))
	if hand_index < 0 or hand_index >= hand_size:
		return false
	if typeof(packet.get("cost", null)) != TYPE_INT:
		return false
	var cost := int(packet.get("cost", -1))
	if cost < 0 or cost > 99:
		return false
	if typeof(packet.get("action", null)) != TYPE_STRING:
		return false
	if str(packet.get("action", "")) not in ["play_card", "pass_turn"]:
		return false
	return true
