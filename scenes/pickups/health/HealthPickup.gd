class_name HealthPickup extends Pickup

func _ready():
	super()

func _on_area_entered(area):
	if area is Player:
		area.get_node("Health").increment_health(value_to_add)
		spawn_display_text()
		queue_free()
