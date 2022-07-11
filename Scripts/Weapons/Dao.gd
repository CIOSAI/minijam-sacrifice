extends Weapon

func _on_Dao_crit(trig:bool):
	$"Pivot/CritParticle".emitting = trig
	if(trig):
		$"Crit".play() 
		$"Pivot/ShineParticle".emitting = true
