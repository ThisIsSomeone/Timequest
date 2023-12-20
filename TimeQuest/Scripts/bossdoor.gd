extends StaticBody2D

@onready var inArea = false
@export var bosskeys = 0
var player = null

var open = false

func _on_area_2d_body_entered(body):
	if body.name == "PlayerController":
		inArea = true
		player = body

func _on_area_2d_body_exited(body):
	if body.name == "PlayerController":
		inArea = false
		player = null

func _process(_delta):
	if open:
		return
	
	if Input.is_action_just_pressed("Interact") and inArea:
		if player._bosskeys >= bosskeys:
			$closed.visible = false
			$opened.visible = true
			$ClosedBlock.disabled = true
			$DoorSound.play()
			player._bosskeys = player._bosskeys - bosskeys
			open = true
