extends CharacterBody2D

@export var speed = 500
const gravity = 900
var ePressed = false
var orient = Vector2.RIGHT

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	#Movement
	var hMovement = Input.get_axis("walkLeft","walkRight")
	var vMovement = Input.get_axis("walkDown","walkUp")
	velocity.x = hMovement*speed
	
	#Vertical movement while mining
	if Global.isMining:
		velocity.y += gravity*delta
		if vMovement != 0:
			velocity.y = vMovement*speed
	else:
		velocity.y = 0
	
	#Orientation
	if hMovement != 0:
		direction.x = hMovement
		$Graphics/Sprite2D.flip_h = hMovement < 0
	
	if vMovement != 0:
		direction.y = vMovement
	
	if direction != Vector2.ZERO:
		orient = direction.normalized()
		
	move_and_slide()

	#Manages chimata's camera

	if Global.follow == true:
		$chimataCamera.enabled = true
	else:
		$chimataCamera.enabled = false
