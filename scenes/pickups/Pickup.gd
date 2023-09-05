class_name Pickup extends Area2D

@export var display_text_scene: PackedScene
@export var value_to_add = 10:
	get: return value_to_add
	set(value): value_to_add = value

var main

func _ready():
	main = get_parent()

func spawn_display_text():
	var display_text = display_text_scene.instantiate()
	display_text.position = self.position
	display_text.text = "+" + str(value_to_add)
	main.add_child(display_text)
