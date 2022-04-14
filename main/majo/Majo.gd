extends AnimatedSprite

const speed : int = 400

class Direction:
	var _inner : int

	func _init(inner : int):
		_inner = inner

	func equals(other : Direction) -> bool:
		return _inner == other._inner

var Left := Direction.new(0)
var Right := Direction.new(1)

var direction := Left

onready var screen_size := get_viewport_rect().size

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	if Input.is_action_pressed("ui_left"):
		if direction.equals(Right):
			animation = "left"
			direction = Left
		position.x = clamp(position.x - delta * speed, 0, screen_size.x)

	if Input.is_action_pressed("ui_right"):
		if direction.equals(Left):
			animation = "right"
			direction = Right
		position.x = clamp(position.x + delta * speed, 0, screen_size.x)
