extends Node

var SoundValue =0.1
var IsFullScreen =false

var playerHP = 10
var Gold = 0
var Death=0
var Player

signal attacked
signal death
signal shake(T:float)

#func _ready():
	#Utils.Loaded.connect(DisplayValue)

func Heal():
	if playerHP < 10:
		playerHP += 1
		
		
func TakeDamage(value):
	playerHP-=value
	if(playerHP<=0):
		death.emit()
		
	#else:
		#attacked.emit()
func ResetHealth():
	playerHP = 10
	Death +=1
	
func EmitShake(T:float):
	shake.emit(T)
	
func Replay():
	Death = 0
	Gold = 0
	playerHP = 10
	
#func DisplayValue():
	#print("in Gamescript sound = ")
	#print(SoundValue)
	#print("in Gamescript fullscreen = ")
	#print(IsFullScreen)
	
