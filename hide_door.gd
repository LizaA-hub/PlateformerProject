extends Node2D

#@onready var player = get_node("res://Player/Player.tscn")
var PlayerInCranckArea = false
var PlayerInDoorArea = false
var CranckDown = false

signal shake(Time)
			
func MoveBlock():
	var BlockTween = get_tree().create_tween()
	BlockTween.tween_property(get_node("Block"), "position",get_node("Block").position - Vector2(30,0), 1)
	Game.EmitShake(1)
	

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		#print("up pressed")
		if PlayerInCranckArea and CranckDown==false:
			get_node("Cranck").texture = load("res://Sunny-land-files/Sunny-land-files/Graphical Assets/environment/Props/crank-down.png") 
			MoveBlock()
			CranckDown = true
		elif PlayerInDoorArea and CranckDown:
			#print("Enter Room")
			get_node("../NewLocalisationArea").Transition("Hide Room")

func _on_cranck_area_body_entered(body):
		if body.name == "Player":
			#print("enter crack area")
			PlayerInCranckArea = true

func _on_cranck_area_body_exited(body):
	if body.name == "Player":
			#print("enter crack area")
			PlayerInCranckArea = false

func _on_door_area_body_entered(body):
	if body.name == "Player":
		#print("enter door area")
		PlayerInDoorArea = true


func _on_door_area_body_exited(body):
		if body.name == "Player":
			#print("exit door area")
			PlayerInDoorArea = false
