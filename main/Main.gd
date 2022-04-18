extends Node2D


onready var counter := $Counter as Label


var count := 0 setget set_count


func set_count(val : int) -> void:
	counter.text = str(val)
	count = val


func _ready() -> void:
	set_count(0)


func _on_DecrementButton_button_up():
	set_count(count - 1)


func _on_IncrementButton_button_up():
	set_count(count + 1)


func _on_QuitButton_button_up():
	get_tree().quit()
