class_name ForwardProjectile extends BaseProjectile

func _physics_process(delta):
	if is_seeker and target != null:
		look_at(target.position)
		velocity = position.direction_to(target.position)
	position += velocity * delta * speed

func _on_body_entered(body):
	var health = body.get_node("Health")
	if health != null:
		health.take_damage(damage)
		print("Vida total: ", health.health)
	if !has_piercing:
		queue_free()
