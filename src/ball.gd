extends CharacterBody2D

var speed = 500
var speedMultiplier = 1.7
var speedTime = 0.8
var speedBoostTimer = 0.0

var direction = Vector2(1, 0)  # Ball starts moving to the right
var paddleInRadius = false
var Paddle = null

# Called every frame
func _process(delta):
	if speedBoostTimer > 0:
		speedBoostTimer -= delta
		if speedBoostTimer <= 0:
			speed = 600
	
	velocity = direction * speed
	move_and_slide()

	var ballWidth = $CollisionShape2D.shape.extents.x * 2
	var ballHeight = $CollisionShape2D.shape.extents.y * 2

	var screenWidth = get_viewport().size.x
	var screenHeight = get_viewport().size.y
	
	const maxBounceAngle = deg_to_rad(40)

	# check for screen boundaries 
	if position.x - ballWidth / 2 <= 0 or position.x + ballWidth / 2 >= screenWidth:
		direction.x *= -1  

	if position.y - ballHeight / 2 <= 0 or position.y + ballHeight / 2 >= screenHeight:
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
		
		if speed > 600:
			print(speed)
		
		paddleInRadius = false


func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Paddle":
		paddleInRadius = true
		Paddle = body
