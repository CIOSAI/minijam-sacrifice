extends Effect

#currently Applier applies 10 every second, 
#maybe different for every effect, maybe not
const apply_rate = 10.0

#these variables will be moved to mother class if most of effects need them
#or even scenes on their own if they get too complicated
var dmg:float

func _setup(_config:Dictionary):
	dmg = _config["dmg"]/(_config["duration"]*apply_rate)
	$"Duration".wait_time = _config["duration"]
	$"Applier".wait_time = 1.0/apply_rate

func _on_Duration_timeout():
	print(name + " has ended")
	queue_free()

func _on_Applier_timeout():
	applyee.hurt(dmg)
