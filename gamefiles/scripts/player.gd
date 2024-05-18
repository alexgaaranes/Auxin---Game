extends CharacterBody2D


const SPEED = 10.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")
var is_spinning: bool = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if not is_spinning:
			velocity.y += gravity * delta
		if Input.is_action_just_pressed("ui_accept"):
			is_spinning = true
			velocity.y = 0
			anim.play("spin")
		if Input.is_action_just_released("ui_accept"):
			is_spinning = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 0
	if velocity.y == 0 and not is_spinning:
		direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1:
		sprite.flip_h = false
	if direction == -1:
		sprite.flip_h = true
	if direction:
		if velocity.y == 0 and not is_spinning:
			anim.play("crawl")
		velocity.x = direction * SPEED
	else:
		if velocity.y == 0 and not is_spinning:
			anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.y > 0:
		anim.play("fall")

	move_and_slide()
