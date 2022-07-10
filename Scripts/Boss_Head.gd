extends Enemy

signal boss_killed

func death():
	emit_signal("boss_killed")
