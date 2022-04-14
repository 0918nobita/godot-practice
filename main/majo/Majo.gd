extends AnimatedSprite

const speed : int = 400

enum Direction {
	Left
	Right
}

var direction = Direction.Right

onready var screen_size := get_viewport_rect().size

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	if Input.is_action_pressed("ui_left"):
		if direction == Direction.Right:
			animation = "left"
			direction = Direction.Left
		position.x = clamp(position.x - delta * speed, 0, screen_size.x)

	if Input.is_action_pressed("ui_right"):
		if direction == Direction.Left:
			animation = "right"
			direction = Direction.Right
		position.x = clamp(position.x + delta * speed, 0, screen_size.x)
