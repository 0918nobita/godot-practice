extends RichTextLabel


const chars_per_sec := 20

var msgs : Array
var current_msg_index := -1

var elapsed := 0.0
var completed := false


func strip_bbcode(base: String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	return regex.sub(base, "", true)


func next_msg() -> void:
	current_msg_index += 1
	if current_msg_index >= msgs.size():
		return
	visible_characters = 0
	bbcode_text = msgs[current_msg_index].content
	elapsed = 0
	completed = false


func _ready() -> void:
	var file = File.new()
	file.open("res://main/text/script.json", File.READ)
	var json_parse = JSON.parse(file.get_as_text())
	if json_parse.error != OK:
		push_error("Failed to parse res://main/text/script.json")
	msgs = json_parse.result
	file.close()
	for i in range(0, msgs.size()):
		msgs[i] = { "content": msgs[i], "length": strip_bbcode(msgs[i]).length() }
	next_msg()


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		next_msg()

	if not completed:
		elapsed += delta

		var num_chars := int(elapsed * chars_per_sec)
		visible_characters = num_chars

		if num_chars >= msgs[current_msg_index].length:
			completed = true
