extends Node
var MainSound = load("res://Music by Ansimuz/Music by Ansimuz/Hurt_and_heart.ogg")
var OutSound = load("res://Music by Ansimuz/Music by Ansimuz/happywalking.ogg")
var UnderGroungSound = load("res://Music by Ansimuz/Music by Ansimuz/summer nights.ogg")
@onready var Track1 = $Track1
@onready var Track2 = $Track2
@onready var Anim = $AnimationPlayer
var currentTrack : AudioStreamPlayer

func _ready():
	currentTrack = Track1
func _process(delta):
	
	if not currentTrack.is_playing():
		currentTrack._set_playing(true)
	

func ChangeTrack(SoundName: String):
	match SoundName:
		"MainSound":
			if currentTrack.get_stream() != MainSound:
				crossfade_to(MainSound) 
		"OutSound":
			if currentTrack.get_stream() != OutSound:
				crossfade_to(OutSound) 
		"UnderGroungSound":
			if currentTrack.get_stream() != UnderGroungSound:
				crossfade_to(UnderGroungSound) 

func crossfade_to(stream : AudioStream):
	# If both tracks are playing, we're calling the function in the middle of a fade.
	# We return early to avoid jumps in the sound.
	if Track1.playing and Track2.playing:
		return

	# The `playing` property of the stream players tells us which track is active. 
	# If it's track two, we fade to track one, and vice-versa.
	if Track2.playing:
		Track1.stream = stream
		Track1.play()
		Anim.play_backwards("SwitchTrack")
		currentTrack = Track1
		#Track2._set_playing(false)
	else:
		Track2.stream = stream
		Track2.play()
		Anim.play("SwitchTrack")
		currentTrack = Track2
		#Track1._set_playing(false)


