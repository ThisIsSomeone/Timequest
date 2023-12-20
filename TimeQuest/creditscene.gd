extends Camera2D

var cameraspeed = -1
var scrolling = false
var alreadyfreezing = false

func _ready():
	await get_tree().create_timer(3).timeout
	scrolling = true

func _process(delta):
	if scrolling == true:
		$CanvasLayer/Parenter.position = $CanvasLayer/Parenter.position + Vector2(0,cameraspeed)
	if Input.is_action_just_pressed("MoveUp"):
		if cameraspeed < 5:
			print("slower")
			cameraspeed = cameraspeed + 1
	if Input.is_action_just_pressed("MoveDown"):
		if cameraspeed > -5:
			print("faster")
			cameraspeed = cameraspeed - 1
	if Input.is_action_just_pressed("TimeStopActivation"):
			print("freeze")
			cameraspeed = 0
	if cameraspeed == 0:
		if alreadyfreezing == false:
			alreadyfreezing = true
			$CanvasLayer/AnimatedSprite2D.visible = true
			$CanvasLayer/AnimatedSprite2D.play("default")
	if cameraspeed != 0:
		if alreadyfreezing == true:
			alreadyfreezing = false
			$CanvasLayer/AnimatedSprite2D.visible = false
			$CanvasLayer/AnimatedSprite2D.stop()
