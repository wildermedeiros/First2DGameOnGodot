class_name Mob extends RigidBody2D

@export var collision_damage = 50:
	get: return collision_damage
	set(value): collision_damage = value

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func handle_destruction():
	queue_free()
