extends Node

var health = 20
var score = 0

func add_point():
	score += 1
	print(score)
	
func mush_heal():
	if health < 20:
		health += 2
	print(health)

func snail_dmg():
	health -= 1
	print(health)
	
func _process(delta):
	pass
