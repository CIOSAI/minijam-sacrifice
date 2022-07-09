extends Enemy

var dir:Vector2
var speed:float = 200

func _ready():
	dir = (Global.player.global_position-global_position).normalized()

func _physics_process(delta):
	move_and_slide( dir*speed )

func _on_BatWeapon_hit():
	queue_free()
