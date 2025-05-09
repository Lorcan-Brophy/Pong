extends CharacterBody2D

var speed = 600
var direction = Vector2(1, 0)  # Ball starts moving to the right
var paddleInRadius = false

# Called every frame
func _process(delta):
	velocity = direction * speed
	move_and_slide()

	var ball_width = $CollisionShape2D.shape.extents.x * 2
	var ball_height = $CollisionShape2D.shape.extents.y * 2

	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y

	# check for screen boundaries 
	if position.x - ball_width / 2 <= 0 or position.x + ball_width / 2 >= screen_width:
		direction.x *= -1  

	if position.y - ball_height / 2 <= 0 or position.y + ball_height / 2 >= screen_height:
		direction.y *= -1 
		
	if paddleInRadius:
		direction *= -1
		paddleInRadius = false

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Paddle":
		paddleInRadius = true
