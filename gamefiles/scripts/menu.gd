extends Node2D


func _on_ready():
	Bgm.play_music_level()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_pressed():
	get_tree().quit()
