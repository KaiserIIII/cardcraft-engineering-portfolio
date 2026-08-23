class_name PortfolioReliableCoverTransfer
extends RefCounted

const MAX_COVER_BYTES := 2 * 1024 * 1024
var _pending: Dictionary = {}

## Queueing is not delivery. The key remains pending until an explicit ACK.
func queue_cover(key: String, payload: PackedByteArray) -> void:
	var normalized := key.strip_edges()
	if normalized.is_empty() or payload.is_empty() or payload.size() > MAX_COVER_BYTES:
		return
	_pending[normalized] = payload

func on_ack(key: String) -> void:
	_pending.erase(key.strip_edges())

func pending_keys() -> PackedStringArray:
	var keys := PackedStringArray()
	for key in _pending.keys():
		keys.append(str(key))
	keys.sort()
	return keys

func has_pending(key: String) -> bool:
	return _pending.has(key.strip_edges())
