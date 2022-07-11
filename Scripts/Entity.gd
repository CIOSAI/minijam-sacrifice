extends KinematicBody2D
class_name Entity

onready var hit_sound = $"Hit"
onready var hurt_anim = $"HurtAnimation"
onready var hp_bar = $"HealthBarPivot/HealthBar"

export var max_hp:float = 4.0
var hp:float = max_hp

func _ready():
	hp = max_hp
	hp_bar.set_health(1)

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
			hit_sound.pitch_scale = rand_range(0.9, 1.1)
			hit_sound.play()
			Global.camera.screen_shake(dmg)
		else:
			hp = min(max_hp, hp)
		hp_bar.set_health(hp/max_hp)
	
#	print(name + " has been hit, hp at " + str(hp) )
	
	if hp<=0:
		death()
