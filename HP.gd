extends ProgressBar

func _process(_delta):
	value = Game.playerHP
	#if Game.playerHP == 10:
		#Control.Theme_Overrides.Styles.corner_radius_top_right = 10
		#corner_radius_bottom_right = 10
