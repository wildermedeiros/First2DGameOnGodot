extends Area2D

# note
# Make a root projectile and extend this class with different behaviours
# Como trabalhar com herança no gdScript
# Dar merge na branch de checkpoint
# Criar outra branch para explorar as heranças
@export var speed = 500
var direction

func _process(delta):
		position += -direction * delta * speed

func set_direction(value):
	direction = value

func _on_body_entered(body):
	body.queue_free()
	queue_free()
