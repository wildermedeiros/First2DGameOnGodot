extends Node2D

@export var projectile_scene: PackedScene
@onready var player = get_parent()
var target_direction = Vector2.ZERO

#func _process(delta):
#	rotation = direction.angle()

func Shoot():
	if !$Radar.has_overlapping_bodies():
		return
	var projectile = projectile_scene.instantiate()
	projectile.position = player.position
	projectile.set_direction(get_target_direction())
	var parent = get_tree().get_first_node_in_group("projectiles")
	parent.add_child(projectile)

func set_target_direction(value):
	target_direction = value

func get_target_direction():
	return target_direction

# note this can be on the radar object and pass the direction through the set function
func _on_range_radar_time_timeout():
	var bodies = $Radar.get_overlapping_bodies()
	if bodies.is_empty():
		return
	var closest_distance = INF
	for target in bodies:
		var target_distance = target.position.distance_to(player.position)
		if target_distance < closest_distance:
			set_target_direction(player.position.direction_to(target.position))
			closest_distance = target_distance
	
# note stopping shoting on death
func _on_shoot_rate_timeout():
	Shoot()
