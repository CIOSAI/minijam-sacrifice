extends KinematicBody2D
class_name Entity

var hp:int = 4

func death():
	print("death() not implemented")

func inflict(ef):
	var n = ef["PackedScene"].instance()
	assert(n is Effect, "inflicted none Effect")
	n._setup(ef["Config"])
	n.applyee = self
	add_child(n)
	print(n.name + " is inflicted onto " + name)

func hurt(dmg:float, effects:Array=[]):
	for i in effects:
		inflict(i)
	
	if dmg!=0:
		hp-=dmg
	
	if hp<=0:
		death()
