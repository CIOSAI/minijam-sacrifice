extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Player:
			i.hurt(-1.5*ratio)
