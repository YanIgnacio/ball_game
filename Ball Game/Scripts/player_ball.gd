extends CharacterBody3D


const gravity = -30
var bounce = 0

func _ready():
	print(velocity)
	pass
	
func _physics_process(delta):
	
	var SPEED = 5 
	velocity.y += gravity*delta
	
	if Input.is_key_pressed(KEY_SHIFT):
		SPEED = SPEED*2
	
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
		$MeshInstance3D.rotate_z(deg_to_rad(SPEED))
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$MeshInstance3D.rotate_z(deg_to_rad(-SPEED))
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$MeshInstance3D.rotate_z(deg_to_rad(SPEED))
	else:
		velocity.x = lerp(velocity.x,0.0,0.1)
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0	
		$MeshInstance3D.rotate_x(deg_to_rad(SPEED))
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
		$MeshInstance3D.rotate_x(deg_to_rad(-SPEED))
	elif Input.is_action_pressed("ui_down"):
		velocity.z = SPEED
		$MeshInstance3D.rotate_x(deg_to_rad(SPEED))
	else:
		velocity.z = lerp(velocity.z,0.0,0.1)
			
	
	if is_on_floor() and Input.is_action_pressed("ui_select"):
		velocity.y = 15
	
	if is_on_floor() and bounce < -2:
		velocity.y = -bounce
		
	if get_position().y < -5:
		set_position(Vector3(0,5,0))
	
	bounce = velocity.y/1.5
	
	move_and_slide()


func _on_enemy_body_entered(body):
	get_tree().change_scene_to_file("res://Death.tscn")


