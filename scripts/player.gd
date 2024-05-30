extends CharacterBody2D


const SPEED = 100.0
const ACCELERATION = 800.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sfx_jump = $sfx_jump
@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sfx_jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("run")
		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >- 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_VELOCITY/ 2:
			velocity.y = JUMP_VELOCITY / 2
