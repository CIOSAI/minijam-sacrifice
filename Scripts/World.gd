extends Node2D

enum {HEALING, POISON, POWER}
onready var wisps = [
	preload("res://Scenes/Wisp_Healing.tscn"),
	preload("res://Scenes/Wisp_Poison.tscn"),
	preload("res://Scenes/Wisp_Power.tscn")]
onready var dao = preload("res://Scenes/Weapons/Dao.tscn")

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
#	add_child(n)
	call_deferred("add_child", n)

func move_camera_back(dur:float):
	Global.camera.move_to(Global.camera.global_position, Vector2.ONE, dur)

func move_camera(v:Vector2, sc:Vector2, dur:float):
	print(Global.camera)
	Global.camera.move_to(v, sc, dur)

func frame_freeze(sc:float, dur:float):
	Engine.time_scale = sc
	yield(get_tree().create_timer(sc*dur), "timeout")
	Engine.time_scale = 1

func _on_EventPlayer_give_player_weapon():
	$"Player".add_child(dao.instance())
