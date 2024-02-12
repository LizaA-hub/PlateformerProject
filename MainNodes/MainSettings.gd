extends TextureButton

var IsOpen = false
var IsFullScreen
var SoundValue
var bus_index :int


func _ready():
	get_node("Panel").scale = Vector2(0,0)
	bus_index = AudioServer.get_bus_index("Master")
	Utils.Loaded.connect(LoadSettings)
	
func LoadSettings():
	IsFullScreen = Game.IsFullScreen
	SoundValue = Game.SoundValue
	_on_check_button_toggled(IsFullScreen)
	get_node("Panel/Volume/VolValue").text = str(SoundValue*10)
	get_node("Panel/Volume/HSlider").value = SoundValue
	_on_check_button_toggled(IsFullScreen)
	$Panel/FullScreen/CheckButton.set_pressed(IsFullScreen)
	_on_h_slider_value_changed(SoundValue)


func _on_pressed():
	if IsOpen:
		get_node("AnimationPlayer").play("Transition")
		IsOpen = false
		texture_normal = load("res://UI/SettingIcon.tga")
		Utils.saveSettings()
	else:
		get_node("AnimationPlayer").play_backwards("Transition")
		IsOpen =true
		texture_normal = load("res://UI/SettingIconPressed.tga")

func _on_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		IsFullScreen = true
		Game.IsFullScreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		IsFullScreen = false
		Game.IsFullScreen = false


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value/10))
	get_node("Panel/Volume/VolValue").text = str(value*10)
	SoundValue = value
	Game.SoundValue = value
	#SoundPlayer.set_volume_db(ToDB(value))
	#print(value)
	#print(ToDB(value))
	if value == 0:
		get_node("Panel/Volume/SoundIcon").texture = load("res://UI/SoundOff.tga")
	elif value >0 && value <=0.5:
		get_node("Panel/Volume/SoundIcon").texture = load("res://UI/SoundMin.tga")
	elif value >0.5 && value <1:
		get_node("Panel/Volume/SoundIcon").texture = load("res://UI/SoundPlus.tga")
	else:
		get_node("Panel/Volume/SoundIcon").texture = load("res://UI/SoundMax.tga")
		


func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	#print("clicked")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and IsOpen:
		_on_pressed()
	
func ToDB(value):
	return (value/10*10.4-8)*10
