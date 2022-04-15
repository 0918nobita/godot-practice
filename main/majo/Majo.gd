extends RigidBody2D


class Direction:
	var _inner : int

	func _init(inner : int):
		_inner = inner

	func equals(other : Direction) -> bool:
		return _inner == other._inner

var Left := Direction.new(0)
var Right := Direction.new(1)


const speed := 100

var direction := Right
var jumping := false

onready var majo := $"MajoCollisionShape/Majo" as AnimatedSprite


func continue_walking() -> void:
	if not majo.playing:
		majo.playing = true


func stop_walking() -> void:
	if majo.playing:
		majo.playing = false


func _physics_process(_delta):
	var vel = get_linear_velocity()
	if Input.is_action_pressed("ui_left"):
		if direction.equals(Right):
			majo.animation = "left"
			direction = Left
		set_linear_velocity(Vector2(-speed, vel.y))
		continue_walking()
	elif Input.is_action_pressed("ui_right"):
		if direction.equals(Left):
			majo.animation = "right"
			direction = Right
		set_linear_velocity(Vector2(speed, vel.y))
		continue_walking()
	else:
		stop_walking()

	if Input.is_action_just_pressed("space") and not jumping:
		linear_velocity = Vector2.ZERO
		apply_central_impulse(Vector2(0, -400))
		jumping = true


func _on_RigidBody2D_body_entered(_body):
	jumping = false
