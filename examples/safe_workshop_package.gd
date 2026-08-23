class_name PortfolioSafeWorkshopPackage
extends RefCounted

const MAX_DOCUMENT_BYTES := 64 * 1024
const MAX_RULES := 64
const MAX_TEXT_LENGTH := 160
const ALLOWED_FIELDS := ["version", "kind", "title", "document_bytes", "rules"]
const ALLOWED_RULE_FIELDS := ["id", "kind", "value"]
const ALLOWED_KINDS := ["card", "deck", "ruleset"]

## Validate a declarative package without reading files or evaluating code.
static func validate(package: Dictionary) -> Dictionary:
	var errors := PackedStringArray()
	if package.is_empty():
		errors.append("empty_package")
		return {"ok": false, "errors": errors, "data": {}}
	for field in package.keys():
		if str(field) not in ALLOWED_FIELDS:
			errors.append("unknown_field:%s" % str(field))
	if typeof(package.get("version", null)) != TYPE_INT or int(package.get("version", 0)) != 1:
		errors.append("invalid_version")
	if typeof(package.get("kind", null)) != TYPE_STRING or str(package.get("kind", "")) not in ALLOWED_KINDS:
		errors.append("invalid_kind")
	var title := str(package.get("title", ""))
	if title.is_empty() or title.length() > MAX_TEXT_LENGTH:
		errors.append("invalid_title")
	var document_bytes := int(package.get("document_bytes", 0))
	if typeof(package.get("document_bytes", null)) != TYPE_INT or document_bytes < 1 or document_bytes > MAX_DOCUMENT_BYTES:
		errors.append("invalid_size")
	var rules_v = package.get("rules", [])
	if typeof(rules_v) != TYPE_ARRAY or rules_v.size() > MAX_RULES:
		errors.append("invalid_rules")
	else:
		for rule_v in rules_v:
			if typeof(rule_v) != TYPE_DICTIONARY:
				errors.append("rule_not_object")
				continue
			var rule: Dictionary = rule_v
			for field in rule.keys():
				if str(field) not in ALLOWED_RULE_FIELDS:
					errors.append("unknown_rule_field:%s" % str(field))
			if typeof(rule.get("id", null)) != TYPE_STRING or str(rule.get("id", "")).is_empty():
				errors.append("invalid_rule_id")
			if typeof(rule.get("kind", null)) != TYPE_STRING or str(rule.get("kind", "")) not in ["set", "add", "remove"]:
				errors.append("invalid_rule_kind")
			if typeof(rule.get("value", null)) not in [TYPE_INT, TYPE_FLOAT, TYPE_STRING, TYPE_BOOL]:
				errors.append("invalid_rule_value")
	if _contains_unsafe_text(package):
		errors.append("unsafe_declarative_value")
	return {"ok": errors.is_empty(), "errors": errors, "data": package.duplicate(true) if errors.is_empty() else {}}

static func _contains_unsafe_text(value: Variant) -> bool:
	if typeof(value) == TYPE_STRING:
		var text := str(value).to_lower()
		return text.contains("../") or text.contains("\\") or text.ends_with(".exe") or text.ends_with(".dll") or text.ends_with(".gd") or text.contains("exec(") or text.contains("script")
	if typeof(value) == TYPE_ARRAY:
		for item in value:
			if _contains_unsafe_text(item):
				return true
	if typeof(value) == TYPE_DICTIONARY:
		for key in value.keys():
			if _contains_unsafe_text(str(key)) or _contains_unsafe_text(value[key]):
				return true
	return false
