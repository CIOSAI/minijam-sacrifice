extends Enemy

var dir:Vector2
var speed:float = 200

func _ready():
	dir = (Global.player.global_position-global_position).normalized()

func _physics_process(delta):
	move_and_slide( dir*speed )

func _process(delta):
	if(
		!Rect2(Vector2(-20000, -20000), Vector2(40000, 40000)
		).has_point(global_position)
		):
		queue_free()

func _on_BatWeapon_hit():
	queue_free()
