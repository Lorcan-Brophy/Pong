extends CharacterBody2D

var speed = 650
var speedMultiplier = 1.6
var speedTime = 0.8
var speedBoostTimer = 0.0

var direction = Vector2(1, 0)

var paddleInRadius = false
var Paddle = null

var opponentInRadius = false
var Opponent = null


# Called every frame
func _process(delta: float) -> void:
	if speedBoostTimer > 0:
		speedBoostTimer -= delta
		if speedBoostTimer <= 0:
			speed = 600
	
	velocity = direction * speed
	move_and_slide()

	var ballWidth = $CollisionShape2D.shape.extents.x
	var ballHeight = $CollisionShape2D.shape.extents.y

	var screenWidth = get_viewport().size.x
	var screenHeight = get_viewport().size.y
	
	const maxBounceAngle = deg_to_rad(40)

	# check for screen boundaries 
	if position.x - ballWidth <= 0 or position.x + ballWidth >= screenWidth:
		direction.x *= -1  

	if position.y - ballHeight <= 0 or position.y + ballHeight >= screenHeight:
		direction.y *= -1 
		
	if paddleInRadius:
		speed *= speedMultiplier
		
		var paddleHeight = Paddle.get_node("CollisionShape2D").shape.extents.y
		var distanceFromPaddleCentre = position.y - Paddle.position.y
		var normalisedDistanceFromPaddleCentre = distanceFromPaddleCentre/paddleHeight
		var bounceAngle = normalisedDistanceFromPaddleCentre * maxBounceAngle		
		var directionSign = -sign(direction.x)
		direction = Vector2(cos(bounceAngle) * directionSign, sin(bounceAngle)).normalized()
		
		speedBoostTimer = speedTime
		
		paddleInRadius = false
		
	if opponentInRadius:
		speed *= speedMultiplier
		
		var opponentHeight = Opponent.get_node("CollisionShape2D").shape.extents.y
		var distanceFromOpponentCentre = position.y - Opponent.position.y
		var normalisedDistanceFromOpponentCentre = distanceFromOpponentCentre / opponentHeight
		var bounceAngle = normalisedDistanceFromOpponentCentre * maxBounceAngle		
		var directionSign = -sign(direction.x)
		direction = Vector2(cos(bounceAngle) * directionSign, sin(bounceAngle)).normalized()
		
		speedBoostTimer = speedTime
		opponentInRadius = false
	#print("X: ", position.x)
	#print("Y: ", position.y)


func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Paddle":
		paddleInRadius = true
		Paddle = body
	if body.name == "Opponent":
		opponentInRadius = true
		Opponent = body

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Paddle":
		paddleInRadius = false
	elif body.name == "Opponent":
		opponentInRadius = false
