extends RigidBody2D


const SPEED = 10


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

func _process(delta):
	#var player = get_tree().root.get_node("Node2D/Player")
	#if player:
		#var direction = (player.position - position).normalized()
		#
		#if direction.length() > 0:
			#apply_central_impulse(direction * SPEED)
	pass
