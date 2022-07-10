extends Area2D
class_name Wisp

const apply_rate = 10.0

var all_bodies = []

func _ready():
	$"Timer".wait_time = 1.0/apply_rate

func effect(ratio:float):
	print(name + " effect() not implemented")

func _on_Timer_timeout():
	all_bodies = get_overlapping_bodies()
	if(all_bodies.empty()): return
	effect(1.0/apply_rate)
