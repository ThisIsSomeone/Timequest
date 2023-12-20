extends StaticBody2D

@onready var inArea = false

var open = false

func _on_area_2d_body_entered(_body):
	if _body.name == "PlayerController":
		inArea = true

func _on_area_2d_body_exited(_body):
	if _body.name == "PlayerController":
		inArea = false

func _process(_delta):
	if open:
		return
	
	if Input.is_action_just_pressed("Interact") and inArea:
		$closed.visible = false
		$opened.visible = true
		$ClosedBlock.disabled = true
		$AudioDoor.play()
		open = true
