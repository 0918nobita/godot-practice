extends RichTextLabel


const chars_per_sec := 20
var elapsed := 0.0
var length := text.length()
var completed := false


func _process(delta : float) -> void:
	if not completed:
		elapsed += delta

		var num_chars := int(elapsed * chars_per_sec)
		visible_characters = num_chars

		if num_chars >= length:
			completed = true
