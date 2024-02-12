extends CanvasLayer

var GemObj
var DeathObj
var ReplayBtn 
var MainBtn

func _ready():
	GemObj = get_node("GemCount")
	GemObj.set_visible(false)
	
	DeathObj = get_node("DeathCount")
	DeathObj.set_visible(false)
	
	ReplayBtn = get_node("Replay")
	ReplayBtn.set_visible(false)
	
	MainBtn = get_node("Main")
	MainBtn.set_visible(false)
	
	#CountGem()
	
func CountGem():
	GemObj.set_visible(true)
	
	var GemLabel = get_node("GemCount/GemNb")
	GemLabel.set_text("0")
	
	var NbGem = Game.Gold
	var LabelTween = get_tree().create_tween()
	LabelTween.tween_interval(0.5)
	var Text
	for i in NbGem+1:
		Text =str(i)
		LabelTween.tween_property(GemLabel,"text",Text,0.1)
	LabelTween.tween_property(GemLabel,"scale",Vector2(1.5,1.5),0.5)
	LabelTween.tween_property(GemLabel,"scale",Vector2(1,1),0.5)
	LabelTween.tween_callback(CountDeath)
	
func CountDeath():
	DeathObj.set_visible(true)
	
	var DeathLabel = get_node("DeathCount/DeathNb")
	DeathLabel.set_text("0")
	
	var NbDeath = Game.Death
	var LabelTween = get_tree().create_tween()
	#LabelTween.tween_interval(0.5)
	var Text
	for i in NbDeath+1:
		Text =str(i)
		LabelTween.tween_property(DeathLabel,"text",Text,0.1)
	#LabelTween.tween_interval(0.5)
	LabelTween.tween_property(DeathLabel,"scale",Vector2(1.5,1.5),0.5)
	LabelTween.tween_property(DeathLabel,"scale",Vector2(1,1),0.5)
	LabelTween.tween_callback(ShowBtns)
	
func ShowBtns():
	ReplayBtn.set_visible(true)
	MainBtn.set_visible(true)




func _on_main_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_replay_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	Game.Replay()
