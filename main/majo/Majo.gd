extends RigidBody2D


class Direction:
	var _inner : int

	func _init(inner : int):
		_inner = inner

	func equals(other : Direction) -> bool:
		return _inner == other._inner

var Left := Direction.new(0)
var Right := Direction.new(1)


var direction := Right
var jumping := false

onready var majo := $"MajoCollisionShape/Majo" as AnimatedSprite


func continue_walking() -> void:
	if not majo.playing:
		majo.playing = true


func stop_walking() -> void:
	if majo.playing:
		majo.playing = false


func face_to_left() -> void:
	if direction.equals(Right):
		majo.animation = "left"
		direction = Left


func face_to_right() -> void:
	if direction.equals(Left):
		majo.animation = "right"
		direction = Right


func _integrate_forces(_state) -> void:
	if jumping:
		return
	var left_pressed := Input.is_action_pressed("ui_left")
	var right_pressed := Input.is_action_pressed("ui_right")
	if Input.is_action_just_pressed("space"):
		var impulse := Vector2(0, -200)
		apply_central_impulse(impulse)
		stop_walking()
		return
	if left_pressed:
		face_to_left()
		set_applied_force(Vector2(-500, 0))
		continue_walking()
	elif right_pressed:
		face_to_right()
		set_applied_force(Vector2(500, 0))
		continue_walking()
	else:
		set_applied_force(Vector2.ZERO)
		stop_walking()


func _on_RigidBody2D_body_entered(_body):
	jumping = false
