extends Weapon

onready var bleed_effect = preload("res://Scenes/Effects/Effect_Bleed.tscn")

func _ready():
	active = true
	add_effects(bleed_effect, {"dmg": 0.5, "duration": 2.0})
