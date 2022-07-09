extends Sprite

onready var dust:Particles2D = $"Dust"
onready var tw:Tween = $"Tween"

export var walk_wobble_freq:float
export(float, 0, 1) var walk_wobble_amp:float
export(float, 0, 1) var walk_tilt:float

var t:float = 0.0
var vel:Vector2
var gravity:float
var bouncy:float = 0

func set_facing(b:bool):
	flip_h = b
	dust.scale = Vector2(1 if b else -1, 1)

func set_vel(v:Vector2):
	vel = v

func set_gravity(v:float):
	gravity = v

func get_vel_x()->float:
	return sqrt(abs(vel.x)/2000.0)*sign(vel.x)

func get_vel_y()->float:
	return clamp(
		pow(abs(vel.y-gravity)/600.0, 2.0)
	, 0.0, 1.0)

func _process(delta):
	rotation = get_vel_x()+sin(t*walk_wobble_freq)*walk_wobble_amp*PI*get_vel_x()
	tw.interpolate_property(self, "bouncy", bouncy
		, 1.0-get_vel_y()*0.35
	, delta*7, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tw.start()
	scale.x = bouncy
	
	dust.emitting = abs(get_vel_x())>0.6
	
	t+=delta
