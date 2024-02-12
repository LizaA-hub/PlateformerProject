extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		get_node("../Player/Player").Death()
