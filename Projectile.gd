extends Area2D

@export var speed = 500
var direction = Vector2.RIGHT

func _process(delta):
		position += direction * delta * speed

func set_direction(value):
	direction = value
