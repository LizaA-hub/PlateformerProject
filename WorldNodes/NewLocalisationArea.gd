extends Node2D
@onready var player = get_node("../Player/Player")
@onready var transitionWindow = get_node("../Transitions")
var IsAtDoor = false
var Location : String

func _ready():
	BackGroundMusic.ChangeTrack("OutSound")

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		if IsAtDoor:
			Transition("Exit Hide Room")
			

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Transition("Cave")
		
func Transition(Place : String):
	player.set_physics_process(false)
	Location = Place
	var TransTween = get_tree().create_tween()
	TransTween.tween_callback(transitionWindow.close)
	TransTween.tween_interval(2)
	TransTween.connect("finished",changePlayerPos.bind(Location))
		
		
		
func changePlayerPos(Place):
	if Place == "Cave":
		BackGroundMusic.ChangeTrack("UnderGroungSound")
		player.position = Vector2(0,1175)
		player.get_node("Camera2D").set_limit(SIDE_TOP,850)
		player.get_node("Camera2D").set_limit(SIDE_BOTTOM,1600)
		player.get_node("Camera2D").set_limit(SIDE_RIGHT,2850)
		transitionWindow.open()
		player.set_physics_process(true)
		
	elif Place == "Begining":
		BackGroundMusic.ChangeTrack("OutSound")
		player.position = Vector2(89,350)
		player.get_node("Camera2D").set_limit(SIDE_TOP,0)
		player.get_node("Camera2D").set_limit(SIDE_BOTTOM,512)
		player.get_node("Camera2D").set_limit(SIDE_LEFT,-150)
		player.get_node("Camera2D").set_limit(SIDE_RIGHT,4750)
		transitionWindow.open()
		player.set_physics_process(true)
		
	elif Place == "Check Point":
		BackGroundMusic.ChangeTrack("UnderGroungSound")
		player.position = Vector2(50,1175)
		player.get_node("Camera2D").set_limit(SIDE_TOP,850)
		player.get_node("Camera2D").set_limit(SIDE_BOTTOM,1600)
		player.get_node("Camera2D").set_limit(SIDE_RIGHT,2850)
		transitionWindow.open()
		player.set_physics_process(true)
		
	elif Place == "Hide Room":
		#BackGroundMusic.ChangeTrack("UnderGroungSound")
		player.position = Vector2(2129,1970)
		player.get_node("Camera2D").set_limit(SIDE_LEFT,1850)
		player.get_node("Camera2D").set_limit(SIDE_BOTTOM,2080)
		player.get_node("Camera2D").set_limit(SIDE_TOP,1664)
		player.get_node("Camera2D").set_limit(SIDE_RIGHT,2600)
		transitionWindow.open()
		player.set_physics_process(true)
		
	elif Place == "Exit Hide Room":
		#BackGroundMusic.ChangeTrack("OutSound")
		player.position = Vector2(2411,1477)
		player.get_node("Camera2D").set_limit(SIDE_TOP,850)
		player.get_node("Camera2D").set_limit(SIDE_BOTTOM,1600)
		player.get_node("Camera2D").set_limit(SIDE_RIGHT,2850)
		player.get_node("Camera2D").set_limit(SIDE_LEFT,-150)
		transitionWindow.open()
		player.set_physics_process(true)
		
	elif Place == "Exit Cave":
		BackGroundMusic.ChangeTrack("OutSound")
		player.position = Vector2(5099,447)
		player.get_node("Camera2D").set_limit(SIDE_TOP,0)
		player.get_node("Camera2D").set_limit(SIDE_BOTTOM,650)
		player.get_node("Camera2D").set_limit(SIDE_LEFT,4900)
		player.get_node("Camera2D").set_limit(SIDE_RIGHT,6350)
		transitionWindow.open()
		player.set_physics_process(true)


func _on_hide_room_exit_body_entered(body):
	if body.name == "Player":
		IsAtDoor = true
		


func _on_cave_exit_body_entered(body):
	if body.name == "Player":
		Transition("Exit Cave")


func _on_hide_room_exit_body_exited(body):
	if body.name == "Player":
		IsAtDoor = false
