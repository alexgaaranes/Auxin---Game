extends Node



# variables
var health = 20
var exp = 0
var wave = 1

@onready var player = %Player
var screen_size
var camera_margin_left
var camera_margin_right
var player_x_pos

func addexp():
	exp += 1
	var exp_label = $"../UI/exp_label"
	exp_label.text = "Exp: " + str(exp)
	

func _ready():
	screen_size = get_viewport().size
	print(screen_size)

func _process(delta):
	player_x_pos = player.global_position.x
	camera_margin_left =  player_x_pos - (screen_size.x)*0.5
	camera_margin_right = player_x_pos + (screen_size.x)*0.5
	
	

	#print(player.global_position, camera_margin_left, camera_margin_right)
