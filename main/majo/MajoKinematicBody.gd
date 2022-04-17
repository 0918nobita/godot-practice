extends KinematicBody2D


const Direction = preload("res://main/majo/Direction.gd")
var Left := Direction.left()
var Right := Direction.right()


const speed := 100
const jump_speed := -400
const gravity := 1200

var direction := Right
var jumping := false
var velocity := Vector2.ZERO

onready var majo := $MajoView as AnimatedSprite


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


func _physics_process(delta : float) -> void:
	velocity.x = 0
	velocity.y += gravity * delta

	if jumping and is_on_floor():
		jumping = false

	var spacePressed := Input.is_action_just_pressed("space")
	var leftPressed := Input.is_action_pressed("ui_left")
	var rightPressed := Input.is_action_pressed("ui_right")

	if not jumping and spacePressed:
		velocity.y = jump_speed
		jumping = true

	if leftPressed:
		velocity.x -= speed
		face_to_left()
		continue_walking()
	elif rightPressed:
		velocity.x += speed
		face_to_right()
		continue_walking()
	else:
		stop_walking()

	velocity = move_and_slide(velocity, Vector2(0, -1))
