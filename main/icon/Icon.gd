extends Sprite


var should_flash := false
var elapsed : float = 0


func update_flash_modifier(val : float) -> void:
	(material as ShaderMaterial).set_shader_param("flash_modifier", val)


func _process(delta : float) -> void:
	if should_flash:
		elapsed += delta
		update_flash_modifier((1 + sin(2 * elapsed)) / 4)
	else:
		elapsed = 0
		update_flash_modifier(0)


func _input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		var ev := event as InputEventMouseButton
		should_flash = get_rect().has_point(to_local(ev.position))

	elif event as InputEventScreenTouch:
		var ev := event as InputEventScreenTouch
		should_flash = get_rect().has_point(to_local(ev.position))
