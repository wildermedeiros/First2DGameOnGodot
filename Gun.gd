extends Node2D

@export var projectile_scene: PackedScene
var target_direction = Vector2.RIGHT
var bodies
# math infinity
var closest_distance = 100000 				
@onready var player = get_parent()

#func _process(delta):
#	rotation = direction.angle()

func Shoot():
	var projectile = projectile_scene.instantiate()
	projectile.position = player.position
	projectile.set_direction(get_target_direction())
	var parent = get_tree().get_first_node_in_group("projectiles")
	parent.add_child(projectile)


func set_target_direction(value):
	target_direction = value

func get_target_direction():
	return target_direction

# Se a colisão não funcionar ou não identificar, observar matrix de colisão do mob, talvez colocá-lo em uma separada
# Verificar também a matriz de colisão do projétil 
# Verificar o calculo da distancia para o radar pegar mobs proximos e não travar no primeiro selecionado

# func _on_range_body_entered(body):
#	if body != Mob:
#		return

func _on_range_radar_time_timeout():
	var bodies = $Radar.get_overlapping_bodies()
	if bodies.is_empty():
		return
	for target in bodies:
		var target_distance = target.position.distance_to(player.position)
		if target_distance < closest_distance:
			set_target_direction(target.position.direction_to(player.position))
			print(target.name)
			closest_distance = target_distance
		else:
			continue
	set_target_direction(bodies[0].position.direction_to(player.position))
