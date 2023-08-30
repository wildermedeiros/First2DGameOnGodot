class_name BaseProjectile extends Area2D

@export var speed = 500
@export var has_piercing = false
@export var is_seeker = false

var target:
	get: return target
	set(value): target = value

var velocity = Vector2.ZERO:
	get: return velocity
	set(value): velocity = value

