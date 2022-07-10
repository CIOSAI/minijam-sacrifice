extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Player:
			if(i.hp<4.0*ratio): 
				get_parent().current_death_type = get_parent().HEALING
			i.hurt(4.0*ratio)
