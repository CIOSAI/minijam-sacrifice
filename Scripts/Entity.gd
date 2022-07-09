extends KinematicBody2D
class_name Entity

onready var hurt_anim = $"HurtAnimation"

var max_hp:float = 4.0
var hp:float = 4.0

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
		if dmg>0:
			hurt_anim.play("hurt")
			Global.camera.screen_shake(dmg)
		else:
			hp = min(max_hp, hp)
	
	print(name + " has been hit, hp at " + str(hp) )
	
	if hp<=0:
		death()
