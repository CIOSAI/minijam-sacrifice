extends Control

func _on_Retry_pressed():
	get_tree().paused = false
	Global.death_count = 0
	Global.all_wisp = []
	MusicPlayer.unboss()
	get_tree().change_scene("res://Scenes/Main.tscn")
