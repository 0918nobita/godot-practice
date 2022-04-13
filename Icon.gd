extends Sprite

var rect

var should_flash = false
var elapsed = 0

func _ready():
	var size = get_rect().size * transform.get_scale()
	rect = Rect2(position - size / 2, size)

func _process(delta):
	if should_flash:
		elapsed += delta
		material.set_shader_param("flash_modifier", (1 + sin(2 * elapsed)) / 4)
	else:
		elapsed = 0
		material.set_shader_param("flash_modifier", 0)

func _input(event):
	if (event is InputEventMouseButton) or (event is InputEventScreenTouch):
		should_flash = rect.has_point(event.position)
