extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const CSPEED = 10.0
var base_dmg = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")
var directionXY
var charge = 0
var direction
var charging_spin: bool
var charge_exceed: bool
var can_press = true
var level1: bool
var level2: bool
var is_dropping: bool
var can_release: bool
var attacking: bool
var dyn_dmg
var accumulated_charge

var time1 = 1.25
var time2 = 0.75

func upgrade():
	base_dmg = 2
	time1 = 0.75
	time2 = 0.25
	charge_time.wait_time = 1.0

# Get direction
func get_direction():
	var rel_mouse_pos = $".".get_local_mouse_position()
	# get unit vector
	var denom = ((rel_mouse_pos[0])**2 + (rel_mouse_pos[1])**2)**0.5
	direction = [rel_mouse_pos[0]/denom, rel_mouse_pos[1]/denom]
	return direction


func spin_restart():
	charge = 0
	charging_spin = true
	can_press = false
	can_release = true
	level1 = true
	level2 = true
	charge_time.start()
	
@onready var charge_time = $charge_time
func _process(delta):
	if Input.is_action_just_pressed("hold_left") and can_press and not is_on_floor():
		spin_restart()	# Restart initial values when charging
		directionXY = get_direction()
		if directionXY[0] > 0:
			sprite.flip_h = false
		if directionXY[0] < 0:
			sprite.flip_h = true
		velocity.y = 0	# Suspend midair
		$spin.play()
		anim.play("spin")
		charge += 1
		
	if level1:
		if $charge_time.time_left < time1:
			charge += 1
			level1 = false
			#print("level 2")
	if level2: 
		if $charge_time.time_left < time2:
			charge += 1
			level2 = false
			#rint("level 3")
	
func _on_charge_time_timeout():
	#print("over charge")
	is_dropping = true
	anim.play("fall")
	velocity.y = 0
	charge = 0
	can_release = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not charging_spin:
		velocity.y += gravity * delta
	
	if is_dropping and not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_released("hold_left") and not is_on_floor() and can_release:
		attacking = true
		can_release = false
		accumulated_charge = charge
		charge_time.stop()
		#print(accumulated_charge, charge)
		$attack.play()
		anim.play("attack")
		charging_spin = false
		directionXY = get_direction()
		if directionXY[0] < 0:
			sprite.flip_h = false
		if directionXY[0] > 0:
			sprite.flip_h = true
		velocity.x = SPEED * charge * directionXY[0]
		velocity.y = SPEED * charge * directionXY[1]
		attacking = false
		
	
	
	
	if Input.is_action_just_pressed("jump") and velocity.y == 0 and not can_release:
		charging_spin = false
		velocity.y = JUMP_VELOCITY
		$jump.play()
		anim.play("jump")
	
	# Causes pause
	if velocity.y == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.y > 0 and can_press:
		anim.play("fall")
	
	if is_on_floor() and velocity.y == 0:
		charge = 0
		can_press = true
		is_dropping = false
		direction = Input.get_axis("crawl_left", "crawl_right")
		if direction:
			if direction > 0:
				sprite.flip_h = false
			if direction < 0:
				sprite.flip_h = true
			anim.play("crawl")
			velocity.x = direction * CSPEED
		else:
			anim.play("idle")


	move_and_slide()

func picked_exp(amount):
	var game_manager = %GameManager
	game_manager.addexp(amount)

func picked_dookie():
	var game_manager = %GameManager
	game_manager.addhp()

func die():
	anim.play("die")

# ATTACK
func _on_attack_area_body_entered(body):
	if body.has_method("got_hit"):
		if charge == 0:
			dyn_dmg = 0
		elif charge > 0:
			dyn_dmg = base_dmg * accumulated_charge
		#print(accumulated_charge)
		body.got_hit(dyn_dmg)


func _on_pick_up_body_entered(body):
	if body:
		print(body.name)
