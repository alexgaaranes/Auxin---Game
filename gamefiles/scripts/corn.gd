extends CharacterBody2D

var on_cd: bool

@onready var dmg_cd = $"dmg _cd"
func _process(delta):
	var game_manager = %GameManager
	if not on_cd:
		for body in $Area2D.get_overlapping_bodies():
			if body.has_method("get_alias"):
				print(body.get_alias())
				alias = body.get_alias()
				if alias == "snail":
					game_manager.corndmg(1)
				elif alias == "rat":
					game_manager.corndmg(3)
		on_cd = true
		dmg_cd.start()



var alias
func _on_area_2d_body_entered(body):
	var game_manager = %GameManager
	#print(game_manager.health)
	print(body)
	if body.has_method("get_alias"):
		print(body.get_alias())
		alias = body.get_alias()
		if alias == "snail":
			game_manager.corndmg(1)
		elif alias == "rat":
			game_manager.corndmg(3)


func _on_dmg__cd_timeout():
	on_cd = false
