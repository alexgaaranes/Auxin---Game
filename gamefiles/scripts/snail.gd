extends CharacterBody2D


const SPEED = 15

const dmg = 1

var health = 4

var spawning = true
var getting_hurt = false
var player
var direction
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var drop = true

@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")

func got_hit(damage):
	health -= damage
	#print("snail damage! health is ", health)
	$hit.play()
	anim.play("hurt")
	getting_hurt = true

var exp_obj = load("res://scenes/exp.tscn")

func death():
	if drop:
		var exp =  exp_obj.instantiate()
		exp.position = Vector2(self.position.x, self.position.y - 10)
		exp.amount = 1
		get_tree().get_root().add_child(exp)
		drop = false 
	anim.play("die")
	
func get_alias():
	return "snail"

func _process(delta):
	if health <= 0:
		death()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hurt":
		getting_hurt = false
	if anim_name == "die":
		queue_free()
	if anim_name == "spawn":
		spawning = false

func _ready():
	anim.play("spawn")

func _physics_process(delta):
	if not spawning and not getting_hurt:
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
		if health > 0:
			anim.play("walk")
			
		velocity.x = direction * SPEED
			
		move_and_slide()



