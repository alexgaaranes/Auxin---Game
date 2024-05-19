extends Node



# variables
var health = 20
var exp = 0
var wave = 1

var goal_exp = 10

@onready var player = %Player
var screen_size
var camera_margin_left
var camera_margin_right
var player_x_pos
var upgradable = false

func addhp():
	if health < 20:
		health += 3
	
	if health > 20:
		health = 20

func fetch_wave():
	return wave

func game_over():
	health = 0

func addexp(amount):
	exp += amount
	var exp_label = $"../UI/exp_label"
	exp_label.text = "Exp: " + str(exp)

func addwave():
	wave += 1
	var wave_label = %wave_label
	wave_label.text = "Wave " + str(wave)

func corndmg(amount):
	health -= amount
	var hp_label = $"../UI/hp_label"
	if health < 0:
		health = 0
	hp_label.text = "Corn HP: " + str(health)

func _ready():
	screen_size = get_viewport().size
	print(screen_size)



@onready var lose_timer = $lose_timer
func _process(delta):
	player_x_pos = player.global_position.x
	camera_margin_left =  player_x_pos - (screen_size.x)*0.5
	camera_margin_right = player_x_pos + (screen_size.x)*0.5
	#print(wave, " ", exp)
	if wave < 5:
		if exp >= goal_exp:
			addwave()
			goal_exp += 10
	elif wave < 10:
		if exp >= goal_exp:
			addwave()
			goal_exp += 20
	else:
		if exp >= goal_exp:
			addwave()
			goal_exp += 50
	
	if wave >= 10 and upgradable:
		var player = %Player
		player.upgrade()
		upgradable = false
	

	# LOSE
	if health <= 0:
		$"../Corn".die()
		#lose_timer.start()
		#lose()


#func lose():
	#Engine.time_scale = 0.3
	#print(lose_timer.time_left)
	
	#print(player.global_position, camera_margin_left, camera_margin_right)
	
#func _on_lose_timer_timeout():
	#get_tree().change_scene_to_file("res://scenes/menu.tscn")
