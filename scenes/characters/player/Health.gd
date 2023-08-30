extends Node

@export var max_health = 100
var health
var is_dead = false

func _ready():
	health = max_health

func _process(delta):
	pass

func take_damage(damage):
	if is_dead: return
	health = min(health, damage)
	if health == 0:
		die()

func die():
	is_dead = true
	get_parent().queue_free()
