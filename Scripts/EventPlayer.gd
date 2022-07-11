extends AnimationPlayer

signal give_player_weapon

func give_player_weapon():
	emit_signal("give_player_weapon")

func _on_DaoObtainedTrigger_body_entered(body):
	play("WeaponObtained")

func _on_BossFightTrigger_body_entered(body):
	MusicPlayer.boss()
	
	play("BossFightStart")

func pause():
	get_tree().paused = true

func _on_Boss_Head_boss_killed():
	$"../Overlay/DeathScreen".queue_free()
	$"../Overlay/Thankyou".mouse_filter = Control.MOUSE_FILTER_STOP
	play("Ending")
	Global.camera.screen_shake(3)
