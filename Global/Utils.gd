extends Node

const SAVE_PATH = "user://SaveSettings.save"
var SoundValue = 0
var IsFullScreen = false

signal Loaded

func saveSettings():
	#print("saving")
	#print("new sound:")
	#print(Game.SoundValue)
	#print("new fullscreen:")
	#print(Game.IsFullScreen)
	#var save_dict: Dictionary ={
		#"Volume": Game.SoundValue,
		#"FullScreen": Game.IsFullScreen,
	#}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	#var json_string = JSON.stringify(save_dict)
	SoundValue = Game.SoundValue
	IsFullScreen = Game.IsFullScreen
	file.store_var(SoundValue)
	file.store_var(IsFullScreen)
	
func loadSettings():
	#print("entering load function")
	var file = FileAccess.open(SAVE_PATH,FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		#print("saveSetting found")
		#if not file.eof_reached():
			#var current_line = JSON.parse_string(file.get_line())
			#if current_line:
				#Game.SoundValue = current_line["Volume"]
				#Game.IsFullScreen = current_line["FullScreen"]
		SoundValue = file.get_var(SoundValue)
		IsFullScreen = file.get_var(IsFullScreen)
		Game.SoundValue = SoundValue
		Game.IsFullScreen = IsFullScreen
	else:
		#print("saveSetting not found")
		Game.SoundValue = 0.3
		Game.IsFullScreen = false
		saveSettings()
	Loaded.emit()
	#print("in settings sound = ")
	#print(SoundValue)
	#print("in settings fullscreen = ")
	#print(IsFullScreen)
