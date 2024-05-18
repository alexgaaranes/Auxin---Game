extends CharacterBody2D


const SPEED = 300
var player


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
	player = get_node("%Player")
	if player:
		var direction = (player.position - self.position).normalized()
		print(direction)

		if direction.x > 0:
			pass
		velocity.x = 1 * SPEED
		
	move_and_slide()
