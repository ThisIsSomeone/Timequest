extends StaticBody2D

@onready var inArea = false
@export var sign_txt = ""
@export var sign_txt2 = "[center]Very well, I shall give you this [color=red]Boss Key[/color] that I found for 50 potions[/center]"
@export var sign_txt3 = "[center]Now pay up, or leave me be![/center]"
@export var textduration = 2
@export var textduration2 = 2
@export var textduration3 = 2
var alreadygotkey = false
var alreadyinteracting = false
var lastdialogue = false
var temp = null

signal isdone

func _ready():
	$RichTextLabel.text = str(sign_txt)

func _process(_delta):
	if Input.is_action_just_pressed("Interact") and inArea and alreadyinteracting == false:
		alreadyinteracting = true
		print("dialogue")
		displaydialogue()

func _on_interactzone_body_entered(body):
	if body.has_method("player"):
		inArea = true
		temp = body


func _on_interactzone_body_exited(body):
	if body.has_method("player"):
		inArea = false

func displaydialogue():
	if lastdialogue == false:
		lastdialogue = true
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration).timeout
		$RichTextLabel.visible = false
		$RichTextLabel.text = str(sign_txt2)
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration2).timeout
		$RichTextLabel.visible = false
		$RichTextLabel.text = str(sign_txt3)
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration3).timeout
		$RichTextLabel.visible = false
		emit_signal("isdone")
	else:
		if temp._money >= 50:
			if alreadygotkey == false:
				alreadygotkey = true
				sign_txt3 = "[center]Very well, here is that [color=red]Boss Key[/color][/center]"
				$RichTextLabel.text = str(sign_txt3)
				$RichTextLabel.visible = true
				await get_tree().create_timer(textduration3).timeout
				$RichTextLabel.visible = false
				temp.clear_money()
				temp.add_bosskey()
				sign_txt3 = "[center]What? That was all I had. Now go beat the [color=purple]Necrolancer[/color][/center]"
				$RichTextLabel.text = str(sign_txt3)
				$RichTextLabel.visible = true
				await get_tree().create_timer(textduration3).timeout
				$RichTextLabel.visible = false
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration3).timeout
		$RichTextLabel.visible = false
	alreadyinteracting = false
