extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		var game_manager = %GameManager
		game_manager.game_over()
