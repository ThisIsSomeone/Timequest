extends Node2D

var howmanytimesdone = 0

func _on_npc_lastdialoguedone():
	if howmanytimesdone == 7:
		$PlayerController/NPC.sign_txt3 = "[center]Unless...[/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 3
		howmanytimesdone += 1
	if howmanytimesdone == 6:
		$PlayerController/NPC.sign_txt3 = "[center]Dangit... I'm trapped![/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 3
		howmanytimesdone += 1
	if howmanytimesdone == 5:
		$PlayerController/NPC.sign_txt3 = "[center]Better get a move on... there's more[/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 4
		howmanytimesdone += 1
	if howmanytimesdone == 4:
		$PlayerController/NPC.sign_txt3 = "[center]I'm glad I can manage five seconds of timefreeze![/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 4
		howmanytimesdone += 1
	if howmanytimesdone == 3:
		$PlayerController/NPC.sign_txt3 = "[center]Phew, that was close[/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 2
		howmanytimesdone += 1
	if howmanytimesdone == 2:
		$PlayerController/NPC.sign_txt3 = "[center]An ambush?![/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 2
		howmanytimesdone += 1
	if howmanytimesdone == 1:
		$PlayerController/NPC.sign_txt3 = "[center]A skeleton? What's it doing here?[/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 4
		howmanytimesdone += 1
	if howmanytimesdone == 0:
		$PlayerController/NPC.sign_txt3 = "[center]Seems like there's more![/center]"
		$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
		$PlayerController/NPC.textduration3 = 2
		howmanytimesdone += 1

func _on_npc_isdone():
	$PlayerController/NPC.sign_txt3 = "[center]You'll make for good practise.[/center]"
	$PlayerController/NPC/RichTextLabel.text = str($PlayerController/NPC.sign_txt3)
	$PlayerController/NPC.textduration3 = 2


func _on_music_changer_body_entered(body):
	if body.has_method("player"):
		$PlayerController.beginmusicintro = false
		$"PlayerController/BackgroundMusic/Title Screen".stop()
