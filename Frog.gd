extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var direction = Vector2(0,0)
var Fdir

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	player =get_node( "../../Player/Player")

func _physics_process(delta):
	velocity.y += gravity*delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Jump")
		direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			Fdir = 1
		else:
			get_node("AnimatedSprite2D").flip_h = false
			Fdir = -1
		velocity.x = direction.x  * SPEED
	else : 
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		player.TakeDamage(Fdir)

func death():
	#Game.Gold += 5
	player.Jump()
	#get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("PlayerDeath/CollisionShape2D").set_deferred("disabled", true)
	get_node("PlayerCollision/CollisionShape2D").set_deferred("disabled", true)

	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()


#func _on_player_collision_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#if body.name == "Player":
		#Game.TakeDamage(2)
