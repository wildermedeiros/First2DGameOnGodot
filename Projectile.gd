extends Area2D

@export var speed = 500
var direction

func _process(delta):
		position += -direction * delta * speed

func set_direction(value):
	direction = value

func _on_body_entered(body):
	body.queue_free()
