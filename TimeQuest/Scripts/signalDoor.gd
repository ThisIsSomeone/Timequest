extends StaticBody2D

@export var signalAmount : int
var signalOnAmount = 0
var open = false

func openDoor():
	if open:
		return
		
	$closed.visible = false
	$opened.visible = true
	$ClosedBlock.disabled = true
	$AudioDoor.play()
	open = true

func signalOn():
	signalOnAmount += 1
	if signalOnAmount == signalAmount:
		call_deferred("openDoor")

func signalOff():
	signalOnAmount = max(signalOnAmount - 1, 0)
