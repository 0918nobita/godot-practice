extends RichTextLabel


const dialog := preload("res://main/text/dialog.tres")
const Msgs := preload("res://main/text/Messages.gd")


const chars_per_sec := 20

var current_msg_index := -1
var elapsed := 0.0
var completed := false


onready var msgs := dialog.load_as_message_array()


func next_msg() -> void:
	current_msg_index += 1
	if current_msg_index >= msgs.size():
		return
	visible_characters = 0
	bbcode_text = msgs.item(current_msg_index).text()
	elapsed = 0
	completed = false


func _ready() -> void:
	next_msg()


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		next_msg()

	if not completed:
		elapsed += delta

		var num_chars := int(elapsed * chars_per_sec)
		visible_characters = num_chars

		if num_chars >= msgs.item(current_msg_index).length():
			completed = true
