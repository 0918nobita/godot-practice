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

var should_flash = false
var elapsed = 0

func _ready():
	print("Hello, Godot!")

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
