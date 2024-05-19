extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		body.picked_exp()
		queue_free()
 
