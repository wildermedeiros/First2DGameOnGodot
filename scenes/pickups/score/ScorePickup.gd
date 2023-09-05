class_name ScorePickup extends Pickup

func _ready():
	super()

func _on_area_entered(area):
	if area is Player:
		main.increment_score(value_to_add)
		spawn_display_text()
		queue_free()
