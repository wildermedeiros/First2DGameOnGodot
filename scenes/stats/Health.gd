extends Node

@export var max_health = 100

var health:
	get: return health
	set(value): health = value

var is_dead = false

func _ready():
	initialize()
	
func initialize():
	health = max_health
	is_dead = false

func take_damage(damage, instigator, scene_damaged):
	if is_dead: return
	var damage_to_apply = min(health, damage)
	health -= damage_to_apply 
	if health == 0:
		scene_death_controller(scene_damaged)	

func scene_death_controller(scene_damaged):
	is_dead = true
	if scene_damaged.has_method("handle_destruction"):
		scene_damaged.handle_destruction()


