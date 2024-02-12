extends Sprite2D

var FirstPlay = true

func _on_area_2d_body_entered(body):
	
	if FirstPlay and body.name == "Player":
		get_node("AnimationPlayer").play("CheckPoint")
		get_node("../Player/Player").IsAtCheckPoint = true
		FirstPlay = false
