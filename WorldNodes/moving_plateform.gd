extends AnimatableBody2D

@export var Destination: Vector2 = Vector2(0,0)
@export var Speed: float = 1
var InitPos
var Forward = true
var Dest

func _ready():
	InitPos = position
	Dest = position+Destination
	Move()
	
func Move():
	var PTween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	PTween.set_loops().set_parallel(false)
	PTween.tween_property(self,"position",Dest,Speed)
	PTween.tween_interval(2)
	PTween.tween_property(self,"position",InitPos,Speed)
	PTween.tween_interval(2)
	
#func _process(delta):
	#if Forward:
		#position = Vector2(move_toward(position.x,Dest.x,Speed),move_toward(position.y,Dest.y,Speed))
		#if position == Dest:
			#Forward = false
	#else:
		#position = Vector2(move_toward(position.x,InitPos.x,Speed),move_toward(position.y,InitPos.y,Speed))
		#if position == InitPos:
			#Forward = true
	
		
	
	
