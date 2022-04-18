extends Node2D


onready var counter := $Counter as Label


var count := 0 setget set_count


func set_count(val : int) -> void:
	counter.text = str(val)
	count = val


func load_count() -> void:
	var file := File.new()
	var err := file.open("user://savedata", File.READ)
	if err == OK:
		set_count(file.get_32())
	else:
		set_count(0)
	file.close()


func _ready() -> void:
	load_count()


func _on_DecrementButton_button_up():
	set_count(count - 1)


func _on_IncrementButton_button_up():
	set_count(count + 1)


func save_count() -> void:
	var file := File.new()
	var err := file.open("user://savedata", File.WRITE)
	if err != OK:
		push_error("Failed to open file")
	file.store_32(count)
	file.close()


func _on_QuitButton_button_up():
	save_count()
	get_tree().quit()
