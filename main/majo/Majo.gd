extends KinematicBody2D

class Direction:
	var _inner : int

	func _init(inner : int):
		_inner = inner

	func equals(other : Direction) -> bool:
		return _inner == other._inner

var Left := Direction.new(0)
var Right := Direction.new(1)

const speed := 300
const gravity := 400

var direction := Right
var velocity := Vector2()

onready var majo := $"./Majo" as AnimatedSprite

func _ready() -> void:
	pass

func _process(_delta : float) -> void:
	pass

func _physics_process(delta : float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0

	if Input.is_action_pressed("ui_left"):
		if direction.equals(Right):
			majo.animation = "left"
			direction = Left
		velocity.x -= speed

	if Input.is_action_pressed("ui_right"):
		if direction.equals(Left):
			majo.animation = "right"
			direction = Right
		velocity.x += speed

	velocity = move_and_slide(velocity, Vector2(0, -1))
