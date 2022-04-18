extends Label


var count := 0


func _ready() -> void:
	update_counter()


func update_counter() -> void:
	text = str(count)


func _on_DecrementButton_button_up():
	count -= 1
	update_counter()


func _on_IncrementButton_button_up():
	count += 1
	update_counter()
