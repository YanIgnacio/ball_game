extends Area3D

var rotSpeed = 3
signal coinCollected

func _physics_process(delta):
	rotate_y(deg_to_rad(rotSpeed))

func _on_body_entered(body):
	if body.name == "Player_Ball":
		emit_signal("coinCollected")
		$AnimationPlayer.play("bounce")
		$Timer.start()

func _on_timer_timeout():
	queue_free()
