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

onready var majo := $Majo as AnimatedSprite

func continue_walking() -> void:
	if not majo.playing:
		majo.playing = true

func stop_walking() -> void:
	if majo.playing:
		majo.playing = false

func _physics_process(delta : float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0

	if Input.is_action_pressed("ui_left"):
		if direction.equals(Right):
			majo.animation = "left"
			direction = Left
		continue_walking()
		velocity.x -= speed

	elif Input.is_action_pressed("ui_right"):
		if direction.equals(Left):
			majo.animation = "right"
			direction = Right
		continue_walking()
		velocity.x += speed
	
	else:
		stop_walking()

	velocity = move_and_slide(velocity, Vector2(0, -1))
