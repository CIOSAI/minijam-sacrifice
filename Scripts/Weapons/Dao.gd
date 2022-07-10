extends Weapon

func _on_Dao_crit(trig:bool):
	$"Pivot/CritParticle".emitting = trig
	if(trig): $"Pivot/ShineParticle".emitting = true
