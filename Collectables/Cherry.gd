extends Area2D
var IsCrateInstance = false


func _on_body_entered(body):
	if body.name == "Player":
		Game.Heal()
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0,35), 0.3)
		tween1.tween_property(self, "modulate:a", 0, 0.2)
		tween.tween_callback(queue_free)

func _on_tree_entered():
	if IsCrateInstance:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + Vector2(0,-27), 0.3)
