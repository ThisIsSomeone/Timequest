extends StaticBody2D

@onready var inArea = false
@export var sign_txt = ""
@export var sign_txt2 = ""
@export var sign_txt3 = ""
@export var textduration = 2
@export var textduration2 = 2
@export var textduration3 = 2
var alreadyinteracting = false
var lastdialogue = false

signal isdone
signal lastdialoguedone

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
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration3).timeout
		$RichTextLabel.visible = false
		print("lastdone")
		emit_signal("lastdialoguedone")
	alreadyinteracting = false
