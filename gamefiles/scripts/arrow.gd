extends Node2D

@export var speed = 400
@onready var anim = $AnimationPlayer

func get_input():
	look_at(get_global_mouse_position())
	
var charge
var can_press
func _process(delta):
	#print(charge, can_press)
	can_press = %Player.can_press
	charge = %Player.charge
	if charge == 0 and not can_press:
		anim.play("black")
	elif charge < 2:
		anim.play("loop")
	elif charge == 2:
		anim.play("orange")
	elif charge == 3:
		anim.play("yellow")
	get_input()

