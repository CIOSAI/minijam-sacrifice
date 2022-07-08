extends Node2D

export(float, 0.0, 1.0) var slippiness:float = 0.8
export var accel:float = 300.0
export var jumpforce:float = 900.0
export var gravity:float = 50.0
export var body_path:NodePath

onready var coyote = $"CoyoteTimer"
onready var bhop = $"BHopTimer"

var body:KinematicBody2D
var vel:Vector2 = Vector2.ZERO

var air_time:float = 0.0
var jump_ticket:bool = false
var p_moving:bool = false

func _ready():
	body = get_node(body_path)

func commit_jump(amp=1):
	vel.y -= jumpforce*amp

func jump():
	if body.is_on_floor()||body.is_on_ceiling():
		vel.y = 0.0
	
	if Input.is_action_just_pressed("Jump") || jump_ticket:
		if (!coyote.is_stopped())&&(!vel.y<0):
			commit_jump()
			jump_ticket = false
		else:
			bhop.start()
			jump_ticket = true
	elif Input.is_action_just_released("Jump")&&vel.y<0:
		vel.y *= 0.5
	
	vel.y += gravity

func move():
	var dir:Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("Left"):
		dir+=Vector2.LEFT
	if Input.is_action_pressed("Right"):
		dir+=Vector2.RIGHT
	
	jump()
	
	if body.is_on_floor():
		coyote.start()
	
	vel.x += sign(dir.x)*accel
	vel.x *= slippiness

func _physics_process(delta):
	
	move()
	
	body.move_and_slide(vel, Vector2.UP)

func death():
	get_parent().lose("You")

func _on_BHopTimer_timeout():
	jump_ticket = false
