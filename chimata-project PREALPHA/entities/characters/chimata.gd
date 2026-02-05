extends CharacterBody2D

@export var speed = 500
const gravity = 900
var ePressed = false

func _physics_process(delta):
	var direction = Vector2.ZERO
	var orientation = Vector2.ZERO
	
	#Movement
	var hMovement = Input.get_axis("walkLeft","walkRight")
	velocity.x = hMovement*speed
	
	#Orientation
	if hMovement > 0:
		$Graphics/Sprite2D.flip_h = false
	elif hMovement < 0:
		$Graphics/Sprite2D.flip_h = true

	#Gravity
	if not is_on_floor() && Global.isMining == true:
		velocity.y += gravity*delta
	else:
		velocity.y = 0
	
	move_and_slide()

	#Manages chimata's camera

	if Global.follow == true:
		$chimataCamera.enabled = true
	else:
		$chimataCamera.enabled = false
