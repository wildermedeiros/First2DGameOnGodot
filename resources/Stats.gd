extends Resource

#enum Stats {HEALTH, DAMAGE, SPEED}
#@export var stats: Stats

@export var health: int

func _init(p_health = 0):
	health = p_health
