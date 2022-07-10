extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Player:
			if(i.hp<8.0): 
				get_parent().current_death_type = get_parent().HEALING
			i.hurt(8.0)
