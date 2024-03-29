extends Enemy

export var init_pos:Vector2
export var target:Vector2
export var speed = 1.0

onready var display = $"Display"
onready var tween = $"Tween"

var follow:Vector2
var vel = Vector2.ZERO

func mtw(v:Vector2)->Vector2:
	return Global.tm.map_to_world(v)

func _ready():
	follow = init_pos
	
	init_pos *= Global.tm.cell_size.x
	init_pos += Global.tm.cell_size/2.0
	target *= Global.tm.cell_size.x
	target += Global.tm.cell_size/2.0
	target -= init_pos
	speed *= Global.tm.cell_size.x
	
	tween_move()

func tween_move():
	var duration = target.length()/speed
	tween.interpolate_property(self, "follow", init_pos, init_pos+target, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(self, "follow", init_pos+target, init_pos, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration)
	tween.start()

func _process(delta):
	vel = (follow-position)*0.15
	position += vel
	
	display.set_facing(vel.x<0)
	display.set_vel(vel*4)
	display.set_gravity(0)


