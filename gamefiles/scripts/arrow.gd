extends Node2D

@export var speed = 400
@onready var anim = $AnimationPlayer

func get_input():
	look_at(get_global_mouse_position())
	
func _process(delta):
	anim.play("loop")
	get_input()

