extends Entity
class_name Player

onready var movement = $"PlayerMovement"
onready var display = $"PlayerDisplay"

func _ready():
	Global.player = self

func _process(delta):
	display.set_vel(movement.vel)
	display.set_facing(sign(movement.vel.x)<0)
	display.set_gravity(movement.gravity)

func death():
	var n = load("res://Scenes/Wisp_Poison.tscn").instance()
	n.global_position = global_position
	get_parent().add_child(n)
	get_parent().respawn()
	queue_free()
