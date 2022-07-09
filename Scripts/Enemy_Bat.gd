extends Enemy

func _physics_process(delta):
	move_and_slide( (Global.player.global_position-global_position).normalized()*50 )
