extends CharacterBody2D

var SPEED = 150
var JUMP_VELOCITY = -400.0
var GRAVITY = 800
var l =0
var r =0
var n =0
var mobility = 10
var X
var CamSpeed = 1

var tt = 0
var f =0

@onready var  anim = get_node("AnimationPlayer")
@onready var cam = get_node("Camera2D")
var IsAlive = false
var IsAtCheckPoint = false

func _ready():
	set_floor_snap_length(32)
	Game.attacked.connect(TakeDamage)
	Game.death.connect(Death)
	modulate = Color(Color.WHITE,0)
	Start()
	#IsAlive = true

func _physics_process(delta):
	#preventing the player from falling on the edge
	if is_on_floor():
		f = 0.1
	else:
		f -= delta
	
	if IsAlive:
		if is_on_floor() or f>0:
			l =0
			r =0
			n =0
			#horizontal movement
			if Input.is_action_pressed("ui_left"):
				velocity.x = -SPEED
				get_node("AnimatedSprite2D").flip_h = true
				anim.play("Run")
			elif Input.is_action_pressed("ui_right"):
				velocity.x =  SPEED
				get_node("AnimatedSprite2D").flip_h = false
				anim.play("Run")
			else:
				velocity.x = 0
				anim.play("Idle")
			#Vertical movement
			if Input.is_action_pressed("Jump"):
				velocity.y = JUMP_VELOCITY
				anim.play("Jump")
				
			#Sprint
			if Input.is_action_pressed("Run"):
				SPEED = 250
				if get_real_velocity().x >0:
					JUMP_VELOCITY = -350
			else:
				SPEED = 150
				JUMP_VELOCITY = -300
		else:
			# Add the gravity.
			velocity.y += GRAVITY * delta
			if velocity.y >0:
				anim.play("Fall")
				
			#movement in the air
			if Input.is_action_pressed("ui_left"):
				l+=delta*mobility*5
				velocity.x = move_toward(velocity.x,-SPEED,l)
				get_node("AnimatedSprite2D").flip_h = true
			elif Input.is_action_pressed("ui_right"):
				r += delta*mobility*5
				velocity.x = move_toward(velocity.x,SPEED,r)
				get_node("AnimatedSprite2D").flip_h = false
			else:
				n +=delta*mobility
				velocity.x = move_toward(velocity.x,0,n)
			#print(velocity.x)
			#is_action_just_released
			

	else:#player death
		anim.play("Death")
	
	#set camera offset
	if velocity.x <0:
		tt+= delta
		if tt>1:
			X= lerp(cam.get_offset().x, 0.0, delta)
			cam.set_offset(Vector2(X,0))
	else:
		tt =0
		X= lerp(cam.get_offset().x, 150.0, delta)
		cam.set_offset(Vector2(X,0))
		

	move_and_slide()
	
func Jump():
	velocity.y = JUMP_VELOCITY
	anim.play("Jump")
	
func TakeDamage(val):
	Game.TakeDamage(2)
	if IsAlive:
		var TweenPlayer = get_tree().create_tween()
		TweenPlayer.tween_callback(set_process_input.bind(false))
		TweenPlayer.tween_method(set_velocity,velocity,velocity + Vector2(val*200.0,-200.0),0.2)
		#set_process_input(false) set_velocity(value)
		#velocity = Vector2(100.0,100.0)
		for i in 3:
			modulate = Color.RED
			await get_tree().create_timer(0.1).timeout
			modulate = Color.WHITE
			await get_tree().create_timer(0.1).timeout
		#set_process_input(true)
		TweenPlayer.tween_callback(set_process_input.bind(true))
	
	
	
func Death():
	IsAlive = false
	#get_node("CollisionShape2D").set_disabled(true)
	set_collision_layer_value(1,false)
	
	#print("is dead")
	#anim.play("Death")
	#marche pas!!!
	var Playertween = get_tree().create_tween()
	Playertween.tween_property(self, "position", position + Vector2(0,-200), 0.5)
	Playertween.tween_interval(0.2)
	Playertween.connect("finished",restart)


#func _on_animated_sprite_2d_animation_finished():
	#if anim.name == "Death":
		#restart()
		#IsAlive = true

func restart():
	if IsAtCheckPoint:
		get_node("../../NewLocalisationArea").Transition("Check Point")
	else:
		get_node("../../NewLocalisationArea").Transition("Begining")
	IsAlive = true
	Game.ResetHealth()
	set_collision_layer_value(1,true)
	
func Start():
	#IsAlive= false
	set_physics_process(false)
	var Introtween = get_tree().create_tween()
	var Animtween = get_tree().create_tween()
	Introtween.tween_property(cam, "zoom", Vector2(3,3),0.1)
	Introtween.tween_property(cam, "offset", Vector2(100,0),0.1)
	Introtween.tween_property(get_node("../../Evironment/House/Door-opened"), "modulate:a", 1,1)
	Introtween.tween_property(self,"modulate:a", 1, 1)
	#Animtween.tween_property(anim,"play","Run",1)
	Animtween.tween_interval(1)
	Animtween.tween_method(anim.play,"Idle","Run",1)
	#anim.play("Run")
	Introtween.tween_property(self,"position", position + Vector2(50,0), 1)
	#anim.play("Idle")
	Animtween.tween_method(anim.play,"Run","Idle",1)
	Introtween.tween_property(get_node("../../Evironment/House/Door-opened"),"modulate:a", 0, 1)
	Animtween.tween_interval(1)
	Introtween.tween_property(cam, "zoom", Vector2(1.6,1.6),0.5)
	Animtween.tween_property(cam, "offset", Vector2(150,0),0.5)
	Introtween.tween_callback(AliveToggle)
	#IsAlive= true
	#set_physics_process(true)
	#
func AliveToggle():
	IsAlive = !IsAlive
	set_physics_process(true)

