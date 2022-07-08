extends Entity

onready var movement = $"PlayerMovement"
onready var display = $"PlayerDisplay"

func _process(delta):
	display.set_facing(sign(movement.vel.x)<0)
