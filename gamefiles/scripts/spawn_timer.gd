extends Timer

const max_enemy = 15



var time = 0
var snail_enemy = load("res://scenes/snail.tscn")
var rat_enemt = load("res://scenes/rat.tscn")

@onready var game_manager = %GameManager

func _process(delta):
	pass

# spawn enemy 2 secs
func _on_timeout():
	time += 1
	
	
	if max_enemy <= 15:
		var snail = snail_enemy.instantiate()
		snail.position.x = randi_range(game_manager.camera_margin_left,game_manager.camera_margin_right)
		snail.position.y = -1
		add_child(snail)
	
	wait_time = 5

