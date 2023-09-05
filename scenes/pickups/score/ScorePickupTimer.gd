extends Timer

#note extend this variable to be possible to work in the editor
func _on_timeout():
	wait_time =  randf_range(0.5, 10)
