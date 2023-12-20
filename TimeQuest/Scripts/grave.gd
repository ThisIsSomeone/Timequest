extends StaticBody2D

@onready var PlayerController = get_node("../PlayerController")
@export var sign_txt = ""
@export var textduration = 0
@export var whichartifact = 0 #0 = none, 1 = Massif's Magic, 2 = Alette's Fury, 3 = Mello's Amulet, 4 = Holy Salt,  5 = Potion of Healing
var alreadyinteracting = false
var lastdialogue = false
var inArea = false

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


func _on_interactzone_body_exited(body):
	if body.has_method("player"):
		inArea = false

func displaydialogue():
	if lastdialogue == false:
		lastdialogue = true
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration).timeout
		$RichTextLabel.visible = false
		emit_signal("isdone")
	else:
		$RichTextLabel.visible = true
		await get_tree().create_timer(textduration).timeout
		$RichTextLabel.visible = false
	alreadyinteracting = false

func _on_isdone():
	if whichartifact == 1:
		PlayerController.setmas()
	if whichartifact == 2:
		PlayerController.setal()
	if whichartifact == 3:
		PlayerController.setmel()
	if whichartifact == 4:
		PlayerController.setholy()
	if whichartifact == 5:
		PlayerController.setheal()
