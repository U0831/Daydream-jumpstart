extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -1800.0
signal hit
signal start
signal apple
var have_eat = 0
var stop1 =true
var stop2 = true

func _ready():
	$AnimatedSprite2D.animation = "stop"
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if have_eat == 0:
		start.emit()
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = "jump"
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if velocity.x == 0 and velocity.y == 0 :
			$AnimatedSprite2D.animation = "stop"
	if velocity.x == 0 and velocity.y != 0 :
			$AnimatedSprite2D.animation = "jump"
	if direction:
		velocity.x = direction * SPEED
		var n = direction * SPEED
		if velocity.x > 0:
			$AnimatedSprite2D.play("right")
		else:
			$AnimatedSprite2D.play("left")
	else:
		velocity.x = move_toward(velocity.x, 0, 15)
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if stop1:
		hit.emit()
		if $AnimatedSprite2D.animation == "left":
			$AnimatedSprite2D.flip_h = false
		else :
			$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.animation = ("eat")
		$AnimatedSprite2D.flip_h = false
		++have_eat
		stop1 = false
		if have_eat == 2:
			stop1.emit()

func _on_apple_body_entered(body: Node2D) -> void:
	if stop2:
		apple.emit()
		if $AnimatedSprite2D.animation == "left":
			$AnimatedSprite2D.flip_h = false
		else :
			$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.animation = ("eat")
		$AnimatedSprite2D.flip_h = false
		++have_eat
		stop2 = false
		if have_eat == 2:
			stop2.emit()
		

	
