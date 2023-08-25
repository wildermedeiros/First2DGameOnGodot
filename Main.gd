class_name Main extends Node

@export var mob_scene: PackedScene
@export var pickup_scene: PackedScene
var score
@export var debugging_mode = false
signal on_score_update


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BackgroundMusic.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	if !debugging_mode:
		get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("pickups", "queue_free")
	$BackgroundMusic.play()

func _on_mob_timer_timeout():
	if debugging_mode:
		return
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	var direction = mob_spawn_location.rotation + PI / 2

	mob.position = mob_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func _on_score_timer_timeout():
	score += 1
	update_score(score)
#	on_score_update.emit()

func _on_start_timer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()
	if !debugging_mode:
		$SpawnPickupTimer.start()

func _on_spawn_pickup_timer_timeout():
	var pickup = pickup_scene.instantiate()
	var pickup_spawn_location = $PickupPath/PickupSpawnLocation
	pickup_spawn_location.progress_ratio = randf()
	pickup.position = pickup_spawn_location.position
	add_child(pickup)
	$PickupSpawnSound.play()

func increment_score(value):
	score += value
	update_score(score)

func update_score(new_score):
	$HUD.update_score(new_score)
