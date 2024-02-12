extends CanvasLayer

func _ready():
	get_node("Blue").scale.x=0
	get_node("White").scale.x=0
	get_node("yellow").scale.x=0
	get_node("red").scale.x=0
	get_node("black").scale.x=0
	
func _process(delta):
	#if Input.is_key_pressed(KEY_SPACE):
		#open()
	#if Input.is_key_pressed(KEY_ESCAPE):
		#close()
	pass
	
	
func open():
	var Bluetween = get_tree().create_tween()
	var Whitetween = get_tree().create_tween()
	var Yellowtween = get_tree().create_tween()
	var Redtween = get_tree().create_tween()
	var Blacktween = get_tree().create_tween()
	Bluetween.tween_property(get_node("black"), "scale:x", 0, 1)
	Whitetween.tween_interval(0.2)
	Whitetween.tween_property(get_node("red"), "scale:x", 0, 0.8)
	Yellowtween.tween_interval(0.4)
	Yellowtween.tween_property(get_node("yellow"), "scale:x", 0, 0.6)
	Redtween.tween_interval(0.5)
	Redtween.tween_property(get_node("White"), "scale:x", 0, 0.5)
	Blacktween.tween_interval(0.6)
	Blacktween.tween_property(get_node("Blue"), "scale:x", 0, 0.4)
	
func close():
	var Bluetween = get_tree().create_tween()
	var Whitetween = get_tree().create_tween()
	var Yellowtween = get_tree().create_tween()
	var Redtween = get_tree().create_tween()
	var Blacktween = get_tree().create_tween()
	Bluetween.tween_property(get_node("Blue"), "scale:x", 1, 1)
	Whitetween.tween_interval(0.2)
	Whitetween.tween_property(get_node("White"), "scale:x", 1, 0.8)
	Yellowtween.tween_interval(0.4)
	Yellowtween.tween_property(get_node("yellow"), "scale:x", 1, 0.6)
	Redtween.tween_interval(0.65)
	Redtween.tween_property(get_node("red"), "scale:x", 1, 0.35)
	Blacktween.tween_interval(0.75)
	Blacktween.tween_property(get_node("black"), "scale:x", 1, 0.3)
