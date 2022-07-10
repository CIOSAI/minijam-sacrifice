extends Camera2D

onready var rng = OpenSimplexNoise.new()
onready var tw = $"Tween"

export var shake_rotate:float
export var shake_offset:Vector2
export(float, 0, 1) var decay:float

var shaking:float = 0
var t:float = 0

func _ready():
	Global.camera = self
	randomize()
	rng.seed = randi()
	rng.period = 4
	rng.octaves = 2

func _physics_process(delta):
	t += delta*60
	
	shaking *= decay
	
	rotation = shake_rotate * shaking * rng.get_noise_2d(t, 0)
	offset.x = shake_offset.x * shaking * rng.get_noise_2d(t, 100)
	offset.y = shake_offset.y * shaking * rng.get_noise_2d(t, 200)

func screen_shake(amt:float):
	shaking = amt

func move_to(v:Vector2, sc:Vector2=Vector2.ONE, dur:float=1):
	tw.interpolate_property(self, "offset",
	offset, v-global_position, dur, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.interpolate_property(self, "scale",
	scale, sc, dur, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.start()
