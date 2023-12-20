extends Node2D

@export var keychest : PackedScene
@export var heartchest : PackedScene

var alreadyon1 = false
var alreadyon2 = false
var alreadyon3 = false
var alreadyon4 = false

var firstwavepartone = false
var firstwaveparttwo = false

var secondwaveone = false
var secondwavetwo = false
var secondwavethree = false
var secondwavefour = false

var thirdwaveone = false
var thirdwavetwo = false
var thirdwavethree = false
var thirdwavefour = false
var thirdwavefive = false

signal switchtotitle

func _process(_delta):
	if(alreadyon1 == false):
		if($PlayerController._bosskeys == 1):
			$BossFountains/fountain/topoff.visible = false
			$BossFountains/fountain/bottomoff.visible = false
			$BossFountains/fountain/topon.visible = true
			$BossFountains/fountain/bottomon.visible = true
	if(alreadyon2 == false):
		if($PlayerController._bosskeys == 2):
			$BossFountains/fountain2/topoff.visible = false
			$BossFountains/fountain2/bottomoff.visible = false
			$BossFountains/fountain2/topon.visible = true
			$BossFountains/fountain2/bottomon.visible = true
	if(alreadyon3 == false):
		if($PlayerController._bosskeys == 3):
			$BossFountains/fountain3/topoff.visible = false
			$BossFountains/fountain3/bottomoff.visible = false
			$BossFountains/fountain3/topon.visible = true
			$BossFountains/fountain3/bottomon.visible = true
	if(alreadyon4 == false):
		if($PlayerController._bosskeys == 4):
			$BossFountains/fountain4/topoff.visible = false
			$BossFountains/fountain4/bottomoff.visible = false
			$BossFountains/fountain4/topon.visible = true
			$BossFountains/fountain4/bottomon.visible = true
		

func _on_signal_skeleton_skel_no_health():
	var stringy = "[center]You managed to defeat my minion?! How DARE you?! Either way, you aren't going to get past the next room, unless you can stop time! Mwahahahahaha[/center]"
	$Signs/Sign3/RichTextLabel.text = str(stringy)
	$"Bottom Layer/Door3".signalOn()

func _on_ghost_intro_isdone():
	#TODO: make fadeout
	$GhostIntro.queue_free()

func _on_log_ness_isdone():
	$PlayerController.add_bosskey()


func _on_grave_1_detector_body_entered(body):
	if body.has_method("player"):
		$"Secret Layer".visible = false


func _on_grave_1_detector_body_exited(body):
	if body.has_method("player"):
		$"Secret Layer".visible = true


func _on_player_detection_body_entered(body):
	if body.has_method("player"):
		$PlayerController.position = Vector2(-4010,3567)


func _on_backwards_body_entered(body):
	if body.has_method("player"):
		$PlayerController.position = Vector2(0,-1072)


func _on_pressure_plate_puzzle_solved():
	print("help")
	var helper = keychest.instantiate()
	helper.position = Vector2(192,-1230) #TODO: adjust based on puzzle position
	$PressureNPC.sign_txt3 = "[center]Good job! You did it![/center]"
	$PressureNPC.lastdialogue = true
	$PressureNPC/RichTextLabel.text = str($PressureNPC.sign_txt3)
	add_child(helper)
	$PressureNPC.displaydialogue()

func _on_vase_puzzle_stopping():
	$VaseVendor.lastdialogue = true
	$VaseVendor.sign_txt3 = "[center]Be Careful![/center]"
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()
	$VaseVendor.lastdialogue = false

func _on_vase_puzzle_scream():
	$VaseVendor.lastdialogue = true
	$VaseVendor.sign_txt3 = "[center]STOP IT![/center]"
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()


func _on_vase_puzzle_firstwave():
	print("phase one")
	$VaseVendor.lastdialogue = true
	$VaseVendor.sign_txt3 = "[center]I [color=red]warned[/color] you...[/center]"
	$VaseVendor.position = Vector2(-672,-944)
	$PlayerController.position = Vector2(-672, -896)
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()
	await get_tree().create_timer(1).timeout
	$vaseSkeleton1.position = Vector2(-600, -896)
	$vaseSkeleton2.position = Vector2(-720, -888)

func _on_vase_puzzle_secondwave():
	print("phase two")
	$VaseVendor.lastdialogue = true
	$VaseVendor.sign_txt3 = "[center]Ha! These [color=pink]skeletons[/color] are immune to your [color=blue]time-stopping][/color] shenanigans.[/center]"
	$VaseVendor.textduration3 = 2
	$VaseVendor.position = Vector2(-672,-944)
	$PlayerController.position = Vector2(-672, -896)
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()
	await get_tree().create_timer(1).timeout
	$secondWaveOne.position = Vector2(-824, -848)
	$secondWaveTwo.position = Vector2(-560, -912)
	$secondWaveThree.position = Vector2(-824, -920)
	$secondWaveFour.position = Vector2(-552, -848)


func _on_vase_puzzle_thirdwave():
	print("phase three")
	$VaseVendor.lastdialogue = true
	$VaseVendor.sign_txt3 = "[center]You won't be able to hit these [color=green]skeletons[/color] while they're looking at you! [color=red]Now Perish![/color][/center]"
	$VaseVendor.textduration3 = 3
	$VaseVendor.position = Vector2(-672,-944)
	$PlayerController.position = Vector2(-672, -896)
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()
	await get_tree().create_timer(1).timeout
	$thirdWaveOne.position = Vector2(-672, -832)
	$thirdWaveTwo.position = Vector2(-824, -848)
	$thirdWaveThree.position = Vector2(-560, -848)
	$thirdWaveFour.position = Vector2(-560, -920)
	$thirdWaveFive.position = Vector2(-828, -920)
	$LogSpawner.position = Vector2(-757, -960)
	$LogSpawner2.position = Vector2(-595, -960)

func _on_vase_puzzle_completed():
	$VaseVendor.lastdialogue = true
	$VaseVendor.sign_txt3 = "[center]Really?! All of it?! I have nothing left![/center]"
	$VaseVendor.textduration3 = 2
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()
	await get_tree().create_timer(2).timeout
	$VaseVendor.sign_txt3 = "[center]Well take everything why won't you? Take this boss key and [color=red]GET OUT![/color][/center]"
	$VaseVendor.textduration3 = 2
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
	$VaseVendor.displaydialogue()
	$PlayerController.add_bosskey()
	await get_tree().create_timer(2).timeout
	$VaseVendor.sign_txt3 = "[center][color=red]GET OUT![/color][/center]"
	$VaseVendor.textduration3 = 1
	$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)

func _on_vase_skeleton_1_skel_no_health():
	firstwavepartone = true
	if firstwavepartone and firstwaveparttwo:
		await get_tree().create_timer(1).timeout
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]Go away...[/color][/center]"
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)

func _on_vase_skeleton_2_skel_no_health():
	firstwaveparttwo = true
	if firstwavepartone and firstwaveparttwo:
		await get_tree().create_timer(1).timeout
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]Go away...[/color][/center]"
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)


func _on_second_wave_one_skel_no_health():
	secondwaveone = true
	if secondwavefour and secondwavethree and secondwavetwo and secondwaveone:
		await get_tree().create_timer(1).timeout
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]I won't hold back if you continue![/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)


func _on_second_wave_two_skel_no_health():
	secondwavetwo = true
	if secondwavefour and secondwavethree and secondwavetwo and secondwaveone:
		await get_tree().create_timer(1).timeout
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]I won't hold back if you continue![/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)


func _on_second_wave_three_skel_no_health():
	secondwavethree = true
	if secondwavefour and secondwavethree and secondwavetwo and secondwaveone:
		await get_tree().create_timer(1).timeout
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]I won't hold back if you continue![/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)


func _on_second_wave_four_skel_no_health():
	secondwavefour = true
	if secondwavefour and secondwavethree and secondwavetwo and secondwaveone:
		await get_tree().create_timer(1).timeout
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]I won't hold back if you continue![/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)


func _on_third_wave_one_skel_no_health():
	thirdwaveone = true
	if thirdwavefive and thirdwavefour and thirdwavethree and thirdwavetwo and thirdwaveone:
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]How dare you...[/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
		$LogSpawner.position = Vector2(208, -968)
		$LogSpawner2.position = Vector2(272, -968)

func _on_third_wave_two_skel_no_health():
	thirdwavetwo = true
	if thirdwavefive and thirdwavefour and thirdwavethree and thirdwavetwo and thirdwaveone:
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]How dare you...[/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
		$LogSpawner.position = Vector2(208, -968)
		$LogSpawner2.position = Vector2(272, -968)

func _on_third_wave_three_skel_no_health():
	thirdwavethree = true
	if thirdwavefive and thirdwavefour and thirdwavethree and thirdwavetwo and thirdwaveone:
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]How dare you...[/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
		$LogSpawner.position = Vector2(208, -968)
		$LogSpawner2.position = Vector2(272, -968)

func _on_third_wave_four_skel_no_health():
	thirdwavefour = true
	if thirdwavefive and thirdwavefour and thirdwavethree and thirdwavetwo and thirdwaveone:
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]How dare you...[/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
		$LogSpawner.position = Vector2(208, -968)
		$LogSpawner2.position = Vector2(272, -968)

func _on_third_wave_five_skel_no_health():
	thirdwavefive = true
	if thirdwavefive and thirdwavefour and thirdwavethree and thirdwavetwo and thirdwaveone:
		$PlayerController.position = Vector2(-152,-896)
		$VaseVendor.position = Vector2(-296, -896)
		$VaseVendor.sign_txt3 = "[center][color=red]How dare you...[/color][/center]"
		$VaseVendor.textduration3 = 1
		$VaseVendor/RichTextLabel.text = str($VaseVendor.sign_txt3)
		$LogSpawner.position = Vector2(208, -968)
		$LogSpawner2.position = Vector2(272, -968)


func _on_skeleton_8_skel_no_health():
	var helper = heartchest.instantiate()
	helper.position = Vector2(-376,-1072) #TODO: adjust based on puzzle position
	add_child(helper)



func _on_final_destination_body_entered(body):
	if body.has_method("player"):
		$PlayerController.bossmusic = true
		if $PlayerController/SoundEffects/LowHealthMusic.playing == true:
			$PlayerController/SoundEffects/LowHealthMusic.stop()
		if $PlayerController/BackgroundMusic/RelaxMusic.playing == true:
			$PlayerController/BackgroundMusic/RelaxMusic.stop()
		$PlayerController/BackgroundMusic/CombatMusic.play()
		$PlayerController.isincutscene = true
		$PlayerController/AnimatedSprite2D.stop()
		$PlayerController/AnimatedSprite2D.play("idle_side")
		$PlayerController/AnimatedSprite2D.flip_h = true
		$Necrolancer/BossText.visible = true
		await get_tree().create_timer(1).timeout
		$Necrolancer/BossText.visible = false
		$PlayerController.position = Vector2(-3991, 3270)
		$Necrolancer.lastdialogue = true
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration).timeout
		$Necrolancer/RichTextLabel.visible = false
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt2)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration2).timeout
		$Necrolancer/RichTextLabel.visible = false
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer/RichTextLabel.visible = false
		$Necrolancer.sign_txt3 = "[center]Well, that's just because I am the ghost haunting those pieces of wood over there.[/center]"
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer/RichTextLabel.visible = false
		$Necrolancer.sign_txt3 = "[center][color=red]Now, you will join me as ghost![/color][/center]"
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		speardeath()
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer.textduration3 = 2
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer/RichTextLabel.visible = false
		$Necrolancer.sign_txt3 = "[center][color=red]Any Last words?[/color][/center]"
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer/RichTextLabel.visible = false
		await get_tree().create_timer(0.5).timeout
		$"Necrolancer/Rescuer Text".visible = true
		$Necrolancer.sign_txt3 = "[center][color=red]What?![/color][/center]"
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer(0.5).timeout
		$"Necrolancer/Rescuer Text2".visible = true
		$Necrolancer.sign_txt3 = "[center][color=red]NO! Stop that![/color][/center]"
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer(0.5).timeout
		$"Necrolancer/Rescuer Text3".visible = true
		await get_tree().create_timer(0.5).timeout
		$"Necrolancer/Rescuer Text4".visible = true
		await get_tree().create_timer(0.5).timeout
		$Necrolancer/RichTextLabel.visible = false
		$"Necrolancer/Rescuer Text5".visible = true
		await get_tree().create_timer(0.5).timeout
		$"Necrolancer/Rescuer Text6".visible = true
		await get_tree().create_timer(0.5).timeout
		$PlayerController/AnimatedSprite2D.visible = false
		$"Necrolancer/Rescuer Text".visible = false
		$"Necrolancer/Rescuer Text2".visible = false
		$"Necrolancer/Rescuer Text3".visible = false
		$"Necrolancer/Rescuer Text4".visible = false
		$"Necrolancer/Rescuer Text5".visible = false
		$"Necrolancer/Rescuer Text6".visible = false
		$Necrolancer.sign_txt3 = "[center][color=red]Welp...[/color][/center]"
		$Necrolancer.textduration3 = 2.5
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer/RichTextLabel.visible = false
		$Necrolancer.sign_txt3 = "[center][color=red]Back to being lonely...[/color][/center]"
		$Necrolancer/RichTextLabel.text = str($Necrolancer.sign_txt3)
		$Necrolancer/RichTextLabel.visible = true
		await get_tree().create_timer($Necrolancer.textduration3).timeout
		$Necrolancer/RichTextLabel.visible = false
		$PlayerController.position = Vector2(-7596, 3879)
		await get_tree().create_timer(0.5).timeout
		$PlayerController/AnimatedSprite2D.visible = true
		$Rescuer.lastdialogue = true
		$Rescuer/RichTextLabel.visible = true
		$"PlayerController/BackgroundMusic/Title Screen".play() #TODO FIX
		await get_tree().create_timer($Rescuer.textduration).timeout
		$Rescuer/RichTextLabel.visible = false
		$Rescuer/RichTextLabel.text = str($Rescuer.sign_txt2)
		$Rescuer/RichTextLabel.visible = true
		await get_tree().create_timer($Rescuer.textduration2).timeout
		$Rescuer/RichTextLabel.visible = false
		$Rescuer/RichTextLabel.text = str($Rescuer.sign_txt3)
		$Rescuer/RichTextLabel.visible = true
		await get_tree().create_timer($Rescuer.textduration3).timeout
		$Rescuer/RichTextLabel.visible = false
		get_parent().switcheroo = true
		print("switching to credits")

func speardeath():
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AgainstWall/Spear0.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear0.visible = true
	$Necrolancer/AgainstWall/Spear1.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear1.visible = true
	$Necrolancer/AgainstWall/Spear2.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear2.visible = true
	$Necrolancer/AgainstWall/Spear3.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear3.visible = true
	$Necrolancer/AgainstWall/Spear4.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear4.visible = true
	$Necrolancer/AgainstWall/Spear5.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear5.visible = true
	$Necrolancer/AgainstWall/Spear6.visible = false
	await get_tree().create_timer(0.5).timeout
	$PlayerController/SoundEffects/LowHealthMusic.play()
	$Necrolancer/AroundPlayer/Spear6.visible = true
	$PlayerController/SoundEffects/LowHealthMusic.stop()


func _on_dialogue_1_body_entered(body):
	if body.has_method("player"):
		$PlayerController.interactdialogue()
		$Dialogue1.queue_free()


func _on_dialogue_2_body_entered(body):
	if body.has_method("player"):
		$PlayerController.attackdialogue()
		$Dialogue2.queue_free()

func _on_dialogue_3_body_entered(body):
	if body.has_method("player"):
		$PlayerController.freezedialogue()
		$Dialogue3.queue_free()

func _on_dialogue_4_body_entered(body):
	if body.has_method("player"):
		$PlayerController.movedialogue()
		$Dialogue4.queue_free()


func _on_dialogue_5_body_entered(body):
	if body.has_method("player"):
		$PlayerController.pausedialogue()
		$Dialogue5.queue_free()
