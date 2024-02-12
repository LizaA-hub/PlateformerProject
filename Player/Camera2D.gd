extends Camera2D
# The starting range of possible offsets using random values
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
# Multiplier for lerping the shake strength to zero
@export var SHAKE_DECAY_RATE: float = 5.0

#@onready var camera = $camera
@onready var rand = RandomNumberGenerator.new()
#@onready var apply_button = $ui/apply_shake

var shake_strength: float = 0.0
var Duration = 0
var IsShaking = false

func _ready() -> void:
	rand.randomize()
	Game.shake.connect(apply_shake)

func apply_shake(T : float) -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH
	Duration = T
	IsShaking = true
	#var CamTween = get_tree().create_tween()
	#CamTween.tween_property(self,"offset",Vector2(0,0),0.5)
	

func _process(delta: float) -> void:
	if Duration>0:
		Duration -= delta
	else:
		# Fade out the intensity over time
		shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
		if shake_strength ==0:
			IsShaking= false

	if IsShaking:
		# Shake by adjusting camera.offset so we can move the camera around the level via it's position
		offset = Vector2(150,0)+get_random_offset()

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
