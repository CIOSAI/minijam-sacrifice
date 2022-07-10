extends Enemy

var target:Vector2
var vel:Vector2

func _ready():
	target = global_position

func _physics_process(delta):
	vel = (target-global_position)*4.0
	move_and_slide(vel)
