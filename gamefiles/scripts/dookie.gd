extends Area2D

var amount
  
func _on_body_entered(body):
	if body.name == "Player":
		body.picked_dookie()
		queue_free()
