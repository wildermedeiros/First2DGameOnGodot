extends Area2D

@export var speed = 500
var direction = Vector2.ZERO

func _process(delta):
	if direction == Vector2.ZERO:
		position += Vector2.RIGHT * delta * speed
	else:
		position += direction * delta * speed


func set_direction(value):
	direction = value
