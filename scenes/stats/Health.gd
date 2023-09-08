extends Node

@export var stats_table: Resource = null
var health = -1
var is_dead = false

func _ready():
	initialize()
	
func initialize():
	if stats_table:
		health = stats_table.data["player"].health
	is_dead = false
	
func increment_health(value):
	if stats_table:
		health = min(value, stats_table.data["player"].health)

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


