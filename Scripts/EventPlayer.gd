extends AnimationPlayer

signal give_player_weapon

func give_player_weapon():
	emit_signal("give_player_weapon")

func _on_DaoObtainedTrigger_body_entered(body):
	play("WeaponObtained")
