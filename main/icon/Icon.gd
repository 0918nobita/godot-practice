extends Sprite


var rect : Rect2

var should_flash := false
var elapsed : float = 0


func _ready() -> void:
	var size := get_rect().size * transform.get_scale()
	rect = Rect2(position - size / 2, size)


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
		should_flash = rect.has_point(ev.position)

	elif event as InputEventScreenTouch:
		var ev := event as InputEventScreenTouch
		should_flash = rect.has_point(ev.position)
