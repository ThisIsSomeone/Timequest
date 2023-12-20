extends Control

@onready var PlayerController = get_parent().get_parent()
@onready var BlueTransparent = get_node("BlueTransparant")

func _ready():
	PlayerController.connect("stoptime", self.freeze,0)
	PlayerController.connect("starttime", self.unfreeze,0)
	BlueTransparent.visible = false

func freeze():
	BlueTransparent.visible = true

func unfreeze():
	BlueTransparent.visible = false
