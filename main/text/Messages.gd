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


static func load_from_file(path : String) -> MessageArray:
	var msgs := MessageArray.new()

	var file := File.new()
	var err := file.open(path, File.READ)
	if err != OK:
		push_error("Failed to open " + path)

	var json_parse := JSON.parse(file.get_as_text())
	if json_parse.error != OK:
		push_error("Failed to parse " + path)

	var msg_arr : Array
	#warning-ignore:unsafe_property_access
	if json_parse.result is Array:
		#warning-ignore:unsafe_property_access
		msg_arr = json_parse.result
	else:
		push_error("Invalid script")
	file.close()

	for msg in msg_arr:
		msgs.push_back(Message.new(msg))

	return msgs
