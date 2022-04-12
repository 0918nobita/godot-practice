extends Sprite

var x = position.x
var y = position.y
var s = transform.get_scale()
var half_w = texture.get_width() * s.x / 2
var half_h = texture.get_height() * s.y / 2
var rect = Rect2(
	x - half_w,
	y - half_h,
	x + half_w,
	y + half_h
)

func _ready():
	print("Hello, Godot!")

var elapsed = 0

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	elapsed += delta

	if rect.has_point(mouse_pos):
		material.set_shader_param("flash_modifier", (1 + cos(2 * elapsed)) / 2)
	else:
		material.set_shader_param("flash_modifier", 0)
