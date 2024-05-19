extends Area2D

var amount
 
func _on_body_entered(body):
	if body.name == "Player":
		body.picked_exp(amount)
		queue_free()
 
