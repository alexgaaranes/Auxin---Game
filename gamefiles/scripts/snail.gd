extends CharacterBody2D


const SPEED = 5
var player
var direction
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")


func _ready():
	#var rand = RandomNumberGenerator.new()
	#var snail_scene = load("res://scenes/snail.tscn")
#
	#var screen_size = get_viewport().get_visible_rect().size
#
	#for i in range(1):
		#var snail = snail_scene.instance()
		#rand.randomize()
			#
		#var x = rand.randf_range(0, screen_size.x)
		#var y = -1
			#
		#snail.position.y = y
		#snail.position.x = x
			#
		#add_child(snail)
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if 0 - self.position.x > 0:
		direction = 1
	if 0 - self.position.x < 0:
		direction = -1

	if direction > 0:
		sprite.flip_h = true
	if direction < 0:
		sprite.flip_h = false
	anim.play("walk")
	velocity.x = direction * SPEED
		
	move_and_slide()
