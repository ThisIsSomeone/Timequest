extends StaticBody2D

@onready var inArea = false
@export var sign_txt = ""
@export var textduration = 2
var alreadyinteracting = false

func _ready():
	$RichTextLabel.text = str(sign_txt)

func _process(_delta):
	if Input.is_action_just_pressed("Interact") and inArea and alreadyinteracting == false:
		alreadyinteracting = true
		displaydialogue()

func _on_interactzone_body_entered(body):
	if body.has_method("player"):
		inArea = true


func _on_interactzone_body_exited(body):
	if body.has_method("player"):
		inArea = false

func displaydialogue():
	$RichTextLabel.visible = true
	await get_tree().create_timer(textduration).timeout
	$RichTextLabel.visible = false
	alreadyinteracting = false
