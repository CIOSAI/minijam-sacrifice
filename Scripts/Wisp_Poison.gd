extends Wisp

func effect(ratio:float):
	for i in all_bodies:
		if i is Enemy:
			i.hurt(1.0*ratio)
