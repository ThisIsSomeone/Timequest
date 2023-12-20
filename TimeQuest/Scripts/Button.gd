extends Node2D

signal buttonOn
signal buttonOff

var frozen = false
var awaitingFreeze = false

@onready var PlayerController = get_node("../PlayerController")
@onready var pressed = false
@onready var inArea = false

func _ready():
	PlayerController.connect("stoptime", self.freeze,0)
	PlayerController.connect("starttime", self.unfreeze,0)

func _on_area_2d_body_entered(body):
	if body.name == "PlayerController":
		inArea = true


func _on_area_2d_body_exited(body):
	if body.name == "PlayerController":
		inArea = false
		if pressed:
			turnOff()

func _process(_delta):
	if Input.is_action_just_pressed("Interact") and inArea:
		if not pressed:
			$OnSound.play()
			buttonOn.emit()
		pressed = true
	
	if Input.is_action_just_released("Interact") and inArea:
		turnOff()
	
	#CHANGING COLOUR AS DEBUG: should change this out
	if pressed:
		modulate.r = 200
	else:
		modulate.r = 1

func turnOff():
	if awaitingFreeze:
		return
	
	if frozen:
		awaitingFreeze = true
		await PlayerController.starttime
		awaitingFreeze = false
	
	pressed = false
	buttonOff.emit()

func freeze():
	frozen = true

func unfreeze():
	frozen = false
