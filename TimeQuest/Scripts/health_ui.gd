extends Control

@export_category("Textures")
@export var HeartFullTexture: CompressedTexture2D
@export var HeartHalfTexture: CompressedTexture2D
@export var HeartEmptyTexture: CompressedTexture2D

@export_category("Heart Scene")
@export var HeartScene: PackedScene

#@onready var label = $Label
@onready var PlayerController = get_parent().get_parent()

var max_hearts: int = 6
var hearts: int = 6

var HeartsSceneArray = []

func set_max_hearts(value):
	max_hearts = max(value,1)
	HeartsSceneArray.clear()
	var newHeartAmount = (max_hearts - HeartsSceneArray.size())/2
	for c in get_children():
		remove_child(c)
		c.queue_free()
	for i in newHeartAmount:
		var newHeart = HeartScene.instantiate()
		add_child(newHeart)
		newHeart.position.x += (HeartsSceneArray.size() + i) * 30
		HeartsSceneArray.append(newHeart)

func get_max_hearts():
	return max_hearts

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	var heartIndex = hearts
	for heart in HeartsSceneArray:
		
		if heartIndex >= 2:
			heart.texture = HeartFullTexture
			heartIndex -= 2
		elif heartIndex == 1:
			heart.texture = HeartHalfTexture
			heartIndex -= 1
		else:
			heart.texture = HeartEmptyTexture


func get_hearts():
	return hearts

func _ready():
	if PlayerController.name != "PlayerController":
		return
	
	set_max_hearts(PlayerController._max_health) 
	set_hearts(PlayerController._health) 
	
	PlayerController.connect("health_changed", self.set_hearts, 0)
