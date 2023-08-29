class_name BaseProjectile extends Area2D

@export var speed = 500
@export var has_piercing = false

var velocity = Vector2.ZERO:
	get: return velocity
	set(value): velocity = value

