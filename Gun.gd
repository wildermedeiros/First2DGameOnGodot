extends Node2D

@export var projectile_scene: PackedScene

#func _process(delta):
#	rotation = direction.angle()

func Shoot():
	var projectile = projectile_scene.instantiate()
	var player = get_parent()
	projectile.position = player.position
	projectile.set_direction(player.get_input_direction())
	var parent = get_tree().get_first_node_in_group("projectiles")
	parent.add_child(projectile)

