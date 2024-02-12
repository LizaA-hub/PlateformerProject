extends Node2D

func _ready():
	#Utils.saveSettings()
	Utils.loadSettings()
	BackGroundMusic.ChangeTrack("MainSound")


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://WorldNodes/world.tscn")

func _on_quit_2_pressed():
	get_tree().quit()
