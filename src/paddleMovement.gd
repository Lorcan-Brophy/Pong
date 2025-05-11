extends CharacterBody2D

var speed = 600  # Speed of the paddle's movement

func _process(delta: float) -> void:
	# listen for kb inputs
	if Input.is_action_pressed("UP"): 
		velocity.y = -1  # up
	elif Input.is_action_pressed("DOWN"):
		velocity.y = 1  # down
	else:
		velocity.y = 0 

	velocity.y *= speed  # applies speed to paddle

	move_and_slide()
