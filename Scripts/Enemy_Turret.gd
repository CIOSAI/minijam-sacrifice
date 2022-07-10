extends Enemy

onready var bullet = preload("res://Scenes/Enemy_Bullet.tscn")
onready var aim = $"Aim"
onready var tw = $"Tween"
onready var ray = $"RayCast2D"
onready var anim = $"AnimationPlayer"

var aim_dir:Vector2 = Vector2.LEFT

func get_dir():
	return Global.player.global_position-global_position

func _process(delta):
	$"Sprite".flip_h = get_dir().x<0
	aim.rotation = aim_dir.angle()
	ray.rotation = get_dir().angle()
	if(ray.get_collider() is TileMap):
		anim.stop()
	else:
		anim.play("default")

func _physics_process(delta):
	tw.interpolate_property(self, "aim_dir"
	, aim_dir, get_dir().normalized(), 0.3
	, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tw.start()

func fire():
	var n = bullet.instance()
	n.global_position = global_position
	get_parent().add_child(n)
