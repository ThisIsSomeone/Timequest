extends StaticBody2D

@export var loggie : PackedScene
@export var offset : float

@onready var PlayerController = get_node("../PlayerController")


var isspawning = false

func _ready():
	PlayerController.connect("stoptime", self.freeze,0)
	PlayerController.connect("starttime", self.unfreeze,0)
	$Timer.wait_time = offset

func spawnlog():
	var helper = loggie.instantiate()
	helper.PlayerController = PlayerController
	helper.y_sort_enabled = true
	get_tree().get_root().add_child(helper)
	helper.position = position + Vector2(0,10)

func freeze():
	$Timer.stop()

func unfreeze():
	$Timer.start()

func log_spawner():
	pass
