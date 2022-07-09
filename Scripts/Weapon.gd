extends Node2D
class_name Weapon

onready var anim = $"AnimationPlayer"
onready var rng = RandomNumberGenerator.new()

export (Resource) var attribute
export (bool) var is_player
var active:bool = true
var hurtAreaActive:bool = false
var effects:Array = []
var current_crit:bool = false

signal hit
signal crit(trig)

func _ready():
	assert(attribute is WeaponAttribute, "attribute is not a WeaponAttribute")
	rng.randomize()
	current_crit = crit()
	emit_signal("crit", current_crit)

func _process(delta):
	if(is_player):
		look_at(get_global_mouse_position())
		
		if active && Input.is_action_just_pressed("Attack"):
			anim.play("base_attack")

func add_effects(n:PackedScene, c:Dictionary):
	effects.append({"PackedScene": n, "Config": c})

func crit() -> bool:
	return rng.randf_range(0, 1)<attribute.crit_chance

func roll_crit():
	current_crit = crit()
	emit_signal("crit", current_crit)
	return current_crit

func _on_HurtArea_body_entered(body):
	if !hurtAreaActive: return
	if body is Entity:
		emit_signal("hit")
		body.hurt(
			attribute.base_dmg*(attribute.crit_scale if current_crit else 1),
			effects)
