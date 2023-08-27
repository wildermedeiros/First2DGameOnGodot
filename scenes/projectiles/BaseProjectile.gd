class_name BaseProjectile extends Area2D

@export var speed = 500
@export var has_piercing = false
var direction: Vector2

func set_direction(value):
	direction = value
