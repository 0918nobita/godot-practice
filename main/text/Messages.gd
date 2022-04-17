class Message:
	var _text : String
	var _length : int

	func _strip_bbcode(base: String) -> String:
		var regex = RegEx.new()
		regex.compile("\\[.*?\\]")
		return regex.sub(base, "", true)

	func _init(base : String):
		_text = base
		_length = _strip_bbcode(base).length()

	func text() -> String:
		return _text

	func length() -> int:
		return _length


# FIXME: Use typed array (GDScript 2.0)
# https://godotengine.org/article/gdscript-progress-report-feature-complete-40
class MessageArray:
	var _inner : Array

	func _init():
		_inner = []

	func push_back(msg : Message) -> void:
		_inner.push_back(msg)

	func item(index : int) -> Message:
		return _inner[index]

	func size() -> int:
		return _inner.size()
