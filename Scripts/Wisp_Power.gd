extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Player:
			var weapon:Weapon = i.get_node("Dao")
			while(!weapon.roll_crit()): 0
