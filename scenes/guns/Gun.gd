extends Node2D

@export var projectile_scene: PackedScene
@onready var player = get_parent()
@onready var is_Player = player.get_script() == Player

var target:
	get: return target
	set(value): target = value
	
var target_direction:
	get: return target_direction
	set(value): target_direction = value

func Shoot():
	if !$Radar.has_overlapping_bodies(): 
		return
	var projectile = projectile_scene.instantiate()
	if !is_Player:
		assert(false, "Parente da arma não é o player")	
		return
	projectile.position = player.position
	if target == null: 	
		return
	projectile.rotation = target_direction.angle()
	projectile.velocity = target_direction
	projectile.target = target
	var parent = get_tree().get_first_node_in_group("projectiles")
	if parent == null: 
		assert(false, "Parente do projetil não encontrado, checar grupo e nomes em string")	
		return
	parent.add_child(projectile)


# note this can be on the radar object and pass the direction through the set function
func _on_range_radar_time_timeout():
	var bodies = $Radar.get_overlapping_bodies()
	if bodies.is_empty():
		return
	var closest_distance = INF
	for body in bodies:
		var target_distance = body.position.distance_to(player.position)
		if target_distance < closest_distance:
			target_direction = player.position.direction_to(body.position)
			closest_distance = target_distance
			target = body
	
# note stopping shoting on death
func _on_shoot_rate_timeout():
	Shoot()
