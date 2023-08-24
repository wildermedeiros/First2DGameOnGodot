extends Node2D

@export var projectile_scene: PackedScene

func spawn_projectile():
	var projetile = projectile_scene.instantiate()
	add_child(projetile)

