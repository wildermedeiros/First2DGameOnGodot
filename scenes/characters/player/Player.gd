class_name Player extends Area2D

@export var speed = 400
@export var blink_time = 3
@export var blink_speed = 0.25

@onready var health = get_node("Health")
@onready var default_color = $AnimatedSprite2D.modulate

var screen_size
var main
var input_direction

signal hit

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	main = get_parent()

func _process(delta):
	move(delta)
#	if Input.is_action_just_pressed("shoot"):
#		$Gun.Shoot(position, rotation)
	
func move(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	input_direction = velocity

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func start(new_position):
	position = new_position
	show()
	health.initialize()
	$CollisionShape2D.set_deferred("disabled", false)

func get_input_direction():
	return input_direction

func _on_body_entered(body):
	if body is Mob:
		$CollisionShape2D.set_deferred("disabled", true)
		health.take_damage(body.collision_damage, body, self)
		# display collision feedback (screen shake, sons e etc)
		main.get_node("HUD").update_life(health.health)
		blink_sprite()
		await get_tree().create_timer(1).timeout
		$CollisionShape2D.set_deferred("disabled", false)

func blink_sprite():
	for i in range(blink_time):
		$AnimatedSprite2D.modulate = Color.ORANGE_RED
		await get_tree().create_timer(blink_speed).timeout
		$AnimatedSprite2D.modulate = default_color
		await get_tree().create_timer(blink_speed).timeout
		
func handle_destruction():
	hide()
	hit.emit()
		
func _on_area_entered(area):
	if area is Pickup:
		$PickupCollectSound.play()
