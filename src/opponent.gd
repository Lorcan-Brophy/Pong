extends CharacterBody2D

var speed = 600
var ball = null

var ballInRadius = false

func _process(delta: float) -> void:
	ball = get_node("../Ball")
	#var distanceToPaddleX = self.position.x - ball.position.x 
	#var distanceToPaddleY = self.position.y - ball.position.y 
	
	#var screenWidth = get_viewport().size.x
	#var screenHeight = get_viewport().size.y
	
	#var easyX = screenWidth / 4
	#var easyY = screenHeight / 4
	
	var distanceToPaddleY = self.position.y - ball.position.y
	

	if distanceToPaddleY > 25:
		velocity.y = -speed
	elif distanceToPaddleY < -25:
		velocity.y = speed
	else:
		velocity.y = 0
	move_and_slide()
