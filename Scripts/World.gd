extends Node2D

enum {HEALING, POISON, POWER}
onready var wisps = [
	preload("res://Scenes/Wisp_Healing.tscn"),
	preload("res://Scenes/Wisp_Poison.tscn"),
	preload("res://Scenes/Wisp_Power.tscn")]

onready var anim = $"AnimationPlayer"

var current_death_type = POISON

func _ready():
	for i in Global.all_wisp:
		spawn_wisp(i["type"], i["pos"])

func _input(event):
	if event.is_action_pressed("Retry"):
		current_death_type = POWER
		$"Player".hurt(128)

func player_death(p:Player):
	spawn_wisp(current_death_type, p.global_position)
	Global.all_wisp.append(
		{"type": current_death_type, "pos": p.global_position}
	)
	get_tree().paused = true
	anim.play(["healing", "poison", "power"][current_death_type])

func spawn_wisp(type:int, pos:Vector2):
	var n = wisps[type].instance()
	n.global_position = pos
	add_child(n)
