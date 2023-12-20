extends Node2D

@export var _spriteOff: Texture2D
@export var _spriteOn: Texture2D

@onready var PlayerController = get_node("../../PlayerController")
@onready var pressed = false
@onready var frozen = false

var awaitingUnfreeze = false
var playerOnPlate = false
var isactive = false

signal pressurePlateOn
signal pressurePlateOff

func _ready():
	pressurePlateOff.emit()
	PlayerController.connect("stoptime", self.freeze,0)
	PlayerController.connect("starttime", self.unfreeze,0)

#ON
func _on_area_2d_body_entered(body):
	if body.name == "PlayerController":
		playerOnPlate = true
		
		if pressed:
			return
		
		pressed = true
		$Sound.play()
		pressurePlateOn.emit()
		$Sprite2D.texture = _spriteOn

#OFF
func _on_area_2d_body_exited(body):
	playerOnPlate = false
	
	if awaitingUnfreeze:
			return
	
	if body.name == "PlayerController":
		
		if frozen:
			awaitingUnfreeze = true
			await PlayerController.starttime
			awaitingUnfreeze = false
			pressurePlateOff.emit()
		else:
			pressurePlateOff.emit()
			
			if playerOnPlate:
				return
		
		pressed = false
		$Sprite2D.texture = _spriteOff

func freeze():
	frozen = true

func unfreeze():
	frozen = false
