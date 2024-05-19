extends Timer

var time = 0
var snail_enemy = load("res://scenes/snail.tscn")
var rat_enemy = load("res://scenes/rat.tscn")
var wave
var upgrade = false
var rat_chance = 20
var x_pos

@onready var game_manager = %GameManager

func _ready():	
	wave = game_manager.wave

func _process(delta):
	pass

func raise_diff():
	if wave > 10 and upgrade:
		raise_diff()
		upgrade = false

func rand_left_pos():
	return randi_range(game_manager.camera_margin_left, game_manager.camera_margin_left-100)

func rand_right_pos():
	return randi_range(game_manager.camera_margin_right+100, game_manager.camera_margin_right)

func summon(addend):
	var summon_num = randi_range(0,rat_chance+addend)
	var pos_left_right = [rand_left_pos(),rand_right_pos()]
	
	if summon_num % 2 == 0:
		x_pos = pos_left_right[0]
	else:
		x_pos = pos_left_right[1]
	
	if summon_num < 18:
		var snail = snail_enemy.instantiate()
		snail.position.x = x_pos
		snail.position.y = -1
		add_child(snail)
	else:
		var rat = rat_enemy.instantiate()
		rat.position.x = x_pos
		rat.position.y = -1
		get_tree().get_root().add_child(rat)

# spawn enemy 2 secs
func _on_timeout():
	wave = %GameManager.fetch_wave()
	#print(wave, " ", num_enemies)
	if wave < 5:
		summon(wave)
	elif wave < 10:
		summon(wave+floor((wave*0.5)))
	else:
		summon(100)

	wait_time = 5
