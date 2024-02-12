extends StaticBody2D

var player
var gem = preload("res://Collectables/Diamond.tscn")
var cherry = preload("res://Collectables/Cherry.tscn")
var index
@export var NbItem: int = 1
enum Type {Gem,Cherry}
@export var type: Type = Type.Gem

func _ready():
	player = get_node( "../../Player/Player")
	index = get_index() 
	#print(index)

func SpawnItem():
	var ItemTemp
	match type:
		Type.Gem:
			ItemTemp = gem.instantiate()
		Type.Cherry:
			ItemTemp = cherry.instantiate()
	ItemTemp.position = position
	ItemTemp.scale = Vector2(1.3,1.3)
	ItemTemp.IsCrateInstance=true
	ItemTemp.z_index = 0
	add_sibling(ItemTemp)
	
	

func _on_bump_area_body_entered(body):
	if body.name == "Player":
		var Crate_Tween = get_tree().create_tween()
		Crate_Tween.tween_property(self,"position", position+Vector2(0,-7), .12)
		Crate_Tween.chain().tween_property(self, "position", position, .12)
		if NbItem>0:
			SpawnItem()
			NbItem -=1
			if NbItem == 0:
				get_node("Crate").texture = load("res://Sunny-land-files/Sunny-land-files/Graphical Assets/environment/Props/block.png") 

