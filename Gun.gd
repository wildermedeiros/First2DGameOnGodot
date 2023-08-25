extends Node2D

@export var projectile_scene: PackedScene
var direction_to_target = Vector2.LEFT

#func _process(delta):
#	rotation = direction.angle()

func Shoot():
	var projectile = projectile_scene.instantiate()
	var player = get_parent()
	projectile.position = player.position
	projectile.set_direction(get_direction_to_target())
	var parent = get_tree().get_first_node_in_group("projectiles")
	parent.add_child(projectile)

# Mudar o metodo para body, porque o mob é body
# Se a colisão não funcionar ou não identificar, observar matrix de colisão do mob, talvez colocá-lo em uma separada
# Verificar também a matriz de colisão do projétil 
func _on_range_area_entered(area):
	if area != Mob:
		return
	var areas = $Range.get_overlapping_areas()
	var closest_distance = area.position.distance_to(position)
	for target in areas:
		var distance = target.position.distance_to(position)
		if distance < closest_distance:
			closest_distance = distance
			set_direction_to_target(target.position.direction_to(position))
		else:
			continue
	set_direction_to_target(area.position.direction_to(position))

func set_direction_to_target(value):
	direction_to_target = value

func get_direction_to_target():
	return direction_to_target




