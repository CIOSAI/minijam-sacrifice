extends AnimationPlayer

func _on_BossAnimation_animation_finished(anim_name):
	match anim_name:
		"Start", "Flame":
			play(["LeftSlap", "RightSlap"][randi()%2])
		"LeftSlap", "RightSlap":
			play("Flame")
	
