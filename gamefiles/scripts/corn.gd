extends CharacterBody2D

var on_cd: bool

@onready var dmg_cd = $"dmg _cd"
@onready var anim = get_node("AnimationPlayer")
var dead = false
func _process(delta):
	var game_manager = %GameManager
	if not on_cd and not dead:
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
	if body.has_method("get_alias") and not dead:
		print(body.get_alias())
		alias = body.get_alias()
		if alias == "snail":
			anim.play("hurt")
			game_manager.corndmg(1)
		elif alias == "rat":
			anim.play("hurt")
			game_manager.corndmg(3)
		
func _on_dmg__cd_timeout():
	on_cd = false

func die():
	Engine.time_scale = 0.3
	dead = true
	anim.play("die")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		Engine.time_scale = 1
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	if anim_name == "hurt":
		anim.play("idle")
