extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Player:
			if(i.hp<8.0): 
				Global.world.current_death_type = Global.world.HEALING
			i.hurt(8.0)
