extends Area2D

@export var score_to_add = 10:
	get: return score_to_add
	set(value): score_to_add = value

@export var display_text_scene: PackedScene

var main

func _ready():
	main = get_parent()

func handle_destruction():
	queue_free()

func _on_area_entered(area):
	if area is Player:
		main.increment_score(score_to_add)
		spawn_display_text()
		queue_free()

func spawn_display_text():
	var display_text = display_text_scene.instantiate()
	display_text.position = self.position
	display_text.text = str(score_to_add)
	main.add_child(display_text)
