extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Player:
			var weapon:Weapon = i.get_node("Dao")
			if(is_instance_valid(weapon)):
				while(!weapon.roll_crit()): 0
