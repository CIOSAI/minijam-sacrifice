extends KinematicBody2D

export(float, 0.0, 1.0) var slippiness:float = 0.8
export var accel:float = 300.0
export var jumpforce:float = 900.0

onready var anim = $"AnimationPlayer"
onready var sprite = $"Sprite"
onready var coyote = $"CoyoteTimer"
onready var bhop = $"BHopTimer"
onready var drop_sound = $"DropSound"
onready var stomp_sound = $"StompSound"
onready var horisquish = $"HoriSquish"

var gravity:float = 50.0

var vel:Vector2 = Vector2.ZERO

var holding
var pickable_body = []
var dir_h:float = 1.0
var air_time:float = 0.0
var q:bool = false
var jump_ticket:bool = false
var p_moving:bool = false

var hp:int = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func commit_jump(amp=1):
	vel.y -= jumpforce*amp


func jump():
	if is_on_floor()||is_on_ceiling():
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
	
	if vel.y<0: anim.play("jump")
	elif vel.y>0: anim.play("fall")
	
	vel.y += gravity
	
	sprite.scale.y = 1+abs(vel.y)/1200

func move():
	var dir:Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		dir+=Vector2.UP
	if Input.is_action_pressed("Left"):
		dir+=Vector2.LEFT
	if Input.is_action_pressed("Right"):
		dir+=Vector2.RIGHT
	if Input.is_action_pressed("Down"):
		dir+=Vector2.DOWN
	
	jump()
	
	if is_on_floor():
		coyote.start()
		if sign(dir.x)!=0: anim.play("walk")
		else: anim.play("idle")
	
	vel.x += sign(dir.x)*accel
	vel.x *= slippiness
	
	if sign(dir.x)!=0&&(!p_moving): #MOVE SQUISH
		horisquish.interpolate_property(sprite, "scale:x", 1.0, 0.9, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		horisquish.start()
		p_moving = sign(dir.x)!=0
	elif (sign(dir.x)==0)&&(p_moving):
		horisquish.interpolate_property(sprite, "scale:x", 0.9, 1.0, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		horisquish.start()
		p_moving = sign(dir.x)!=0

	dir_h = sign(dir.x) if sign(dir.x)!=0 else dir_h
	
	sprite.flip_h = dir_h==1

func _physics_process(delta):
	
	move()
	
	move_and_slide(vel, Vector2.UP)

func death():
	get_parent().lose("You")

func hurt(dmg:int):
	if dmg==0: return
	
	hp-=dmg
	
	if hp<=0:
		death()

func _on_PickArea_body_entered(body):
	pickable_body.append(body)

func _on_PickArea_body_exited(body):
	pickable_body.erase(body)

func _on_HitBox_body_entered(body):
	if body.has_method("bump"): body.bump(self)

func _on_StompArea_body_entered(body):
	if vel.y>gravity && body.has_method("hurt"): 
		stomp_sound.play()
		body.hurt(1)
		commit_jump(1.5)


func _on_BHopTimer_timeout():
	jump_ticket = false
