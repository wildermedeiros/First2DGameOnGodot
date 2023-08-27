class_name ForwardProjectile extends BaseProjectile

func _process(delta):
		position += direction * delta * speed

func _on_body_entered(body):
	body.queue_free()
	if !has_piercing:
		queue_free()
