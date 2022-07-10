extends Control

func _on_Retry_pressed():
	get_tree().paused = false
	Global.all_wisp = []
	get_tree().change_scene("res://Scenes/World.tscn")
