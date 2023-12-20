extends CharacterBody2D

@export var _max_health: int = 6
@export var _health: int = 6
@export var _moveSpeed: float = 10.0
@export var _money: int = 0 
@export var _bosskeys: int = 0
@export var beginmusicintro = false

var artifactcounter = 0

var isincutscene = false

var enemy_in_range = false
var enemy_attack_cooldown = true
var alreadystopped = false
var player_alive = true
var is_frozen = false
var attacker = null
var attack_ip = false
var invulnerable = false
var flicker = false
var dir = 1
var atanimation = false
var immuneenemy = false
var musicenemies = 0
var hasjustswapped = false
var isdead = false

#0 = none, 1 = Massif's Magic, 2 = Alette's Fury, 3 = Mello's Amulet, 4 = Holy Salt,  5 = Potion of Healing
var masmagic = false
var alfury = false
var melamul = false
var holysal = false
var healpot = false

var timestoplength = 5

var bossmusic = false
var titlemusic = false

var respawnposition = Vector2(0,32)

#0 = error
# 1 is down, 2 is right, 3 is up, 4 is left
signal no_health
signal health_changed(value)
signal stoptime
signal starttime

func _physics_process(_delta):
	if isincutscene == false:
		if _health <= 0:
			player_alive = false
			dir = 0
			if isdead == false:
				if $SoundEffects/LowHealthMusic.playing:
					$SoundEffects/LowHealthMusic.stop()
				if $BackgroundMusic/CombatMusic.playing:
					$BackgroundMusic/CombatMusic.stop()
				if $BackgroundMusic/RelaxMusic.playing:
					$BackgroundMusic/RelaxMusic.stop()
				$SoundEffects/GameOver.play()
				$AnimatedSprite2D.play("death")
				isdead = true
				#TODO something here
				$"CanvasLayer/Game Over".visible = true
				$CanvasLayer/Interface.visible = false
				$CanvasLayer/Money.visible = false
				$CanvasLayer/BossKeys.visible = false
			if Input.is_action_just_pressed("Interact"):
				self.position = respawnposition
				isdead = false
				player_alive = true
				$CanvasLayer/BossKeys.visible = true
				$"CanvasLayer/Game Over".visible = false
				$CanvasLayer/Interface.visible = true
				$CanvasLayer/Money.visible = true
				restore_heart()
				restore_heart()
				restore_heart()
				restore_heart()
				restore_heart()
				restore_heart()
		else:
			velocity.y = Input.get_axis("MoveUp", "MoveDown")
			velocity.x = Input.get_axis("MoveLeft", "MoveRight")
		
		if bossmusic == false and titlemusic == false and isdead == false:
			combatmusic()
		flickering()
		attack()
		enemy_attack()
		
		getdir()
		
		#Normalized for diagonal movement
		velocity = velocity.normalized() * _moveSpeed
		move_and_slide()
		
		if velocity.length() > 0:
			playFootsteps()

		if isincutscene == false:
			if Input.is_action_just_pressed("TimeStopActivation"):
				if isdead == false:
					timestop()
			if Input.is_action_just_pressed("Heal"):
				if isdead == false:
					if healpot == true:
						print("healing")
						healpot = false
						restore_heart()
						restore_heart()
						restore_heart()
						restore_heart()
						restore_heart()
						restore_heart()
						restore_heart()
						restore_heart()
						$CanvasLayer/Interface/healtext.visible = false
						$CanvasLayer/Interface/heal_button.visible = false
				

func playFootsteps():
	if $SoundEffects/Footstep.playing:
		return
	$SoundEffects/Footstep.play()

func getdir():
	if atanimation == false:
		if Input.is_action_pressed("MoveDown"):
			dir = 1
		if Input.is_action_pressed("MoveRight"):
			dir = 2
		if Input.is_action_pressed("MoveUp"):
			dir = 3
		if Input.is_action_pressed("MoveLeft"):
			dir = 4
		if velocity.x == 0 and velocity.y == 0:
			if dir == 1:
				$AnimatedSprite2D.play("idle_down")
			if dir == 2:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("idle_side")
			if dir == 3:
				$AnimatedSprite2D.play("idle_up")
			if dir == 4:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("idle_side")
		else:
			if dir == 1:
				$AnimatedSprite2D.play("walk_down")
			if dir == 2:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("walk_side")
			if dir == 3:
				$AnimatedSprite2D.play("walk_up")
			if dir == 4:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("walk_side")

func flickering():
	if flicker == true:
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.visible = true
	else:
		$AnimatedSprite2D.visible = true

func set_health(value):
	_health = value
	emit_signal("health_changed", _health)
	if _health <= 0:
		emit_signal("no_health")

func restore_heart():
	$SoundEffects/RestoreHeart.play()
	_health = min(_health + 1, _max_health)
	emit_signal("health_changed", _health)

func lose_heart():
	if invulnerable == false:
		if _health == 0:
			return
		#TODO: Add knockback?
		$SoundEffects/HitSound.play()
		invulnerable = true
		flicker = true
		_health = _health - 1
		emit_signal("health_changed", _health)
		$invulnerability_frames.start()

func lose_heart_two():
	if invulnerable == false:
		if _health == 0:
			return
		#TODO: Add knockback?
		$SoundEffects/HitSound.play()
		invulnerable = true
		flicker = true
		_health = _health - 2
		emit_signal("health_changed", _health)
		$invulnerability_frames.start()

func timestop():
	if alreadystopped == false:
		alreadystopped = true
		is_frozen = true
		print("Stopping time")
		emit_signal("stoptime")
		$SoundEffects/TimeFreeze.play()
		$CanvasLayer/TimeStopFilter/timeclock.visible = true
		$CanvasLayer/TimeStopFilter/timeclock.play("default")
		await get_tree().create_timer(timestoplength).timeout #Time stop lasts 5/7 seconds
		$CanvasLayer/TimeStopFilter/timeclock.stop()
		$CanvasLayer/TimeStopFilter/timeclock.visible = false
		print("Starting time")
		emit_signal("starttime")
		is_frozen = false
		$CanvasLayer/TimeStopFilter/timeclock.visible = true
		$CanvasLayer/TimeStopFilter/timeclock.play("cooldown")
		await get_tree().create_timer(5).timeout #Time stop cooldown lasts 5 seconds
		$CanvasLayer/TimeStopFilter/timeclock.stop()
		$CanvasLayer/TimeStopFilter/timeclock.visible = false
		print("Cooldown Over")
		alreadystopped = false

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"): #TODO: add empty func enemy in every enemy
		enemy_in_range = true
		attacker = body

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"): #TODO: add empty func enemy in every enemy
		enemy_in_range = false
		attacker = null

func enemy_attack():
	if enemy_in_range == true and enemy_attack_cooldown == true and is_frozen == false:
		attacker.enemy()
		enemy_attack_cooldown = false
		await get_tree().create_timer(1).timeout
		enemy_attack_cooldown = true
	if is_frozen == true and immuneenemy == true:
		attacker.enemy()
		enemy_attack_cooldown = false
		await get_tree().create_timer(1).timeout
		enemy_attack_cooldown = true

func attack():
	if isdead == false:
		if attack_ip == false:
			if Input.is_action_just_pressed("Attack"):
				Global.player_current_attack = true
				attack_ip = true
				atanimation = true
				$SoundEffects/SwordSwipe.play()
				$AnimatedSprite2D.stop()
				if dir == 0: #What happens after being dead
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("attack_side")
				if dir == 1:
					$AnimatedSprite2D.play("attack_down")
				if dir == 2:
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("attack_side")
				if dir == 3:
					$AnimatedSprite2D.play("attack_up")
				if dir == 4:
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("attack_side")
				checkertje()
				$attacking.start()
				$atkduration.start()

func checkertje():
	await $AnimatedSprite2D.animation_finished
	atanimation = false

func player():
	pass

func _on_attacking_timeout():
	$attacking.stop()
	attack_ip = false

func _on_atkduration_timeout():
	Global.player_current_attack = false


func _on_invulnerability_frames_timeout():
	invulnerable = false
	flicker = false

func add_money():
	$SoundEffects/AddMoney.play()
	_money = _money + 1
	var stringy = "[right]" + str(_money) + "[/right]"
	$CanvasLayer/Money/RichTextLabel.text = str(stringy)
	$CanvasLayer/PauseMenu/TotalTreasure.text = "[center]Total Treasure - " + str(_money) + " Coins[/center]"

func clear_money():
	_money = _money - 50
	var stringy = "[right]" + str(_money) + "[/right]"
	$CanvasLayer/Money/RichTextLabel.text = str(stringy)

func add_bosskey():
	_bosskeys = _bosskeys + 1
	print(_bosskeys)
	var stringy = "[right]" + str(_bosskeys) + "[/right]"
	$CanvasLayer/BossKeys/RichTextLabel.text = str(stringy)
	$CanvasLayer/PauseMenu/BossKeys.text = "[center]Bosskeys Obtained - " + str(_bosskeys) + "/4"

func combatmusic():
	if beginmusicintro == false:
		if _health > 2:
			if $SoundEffects/LowHealthMusic.playing == true:
				$SoundEffects/LowHealthMusic.stop()
				$BackgroundMusic/CombatMusic.stop()
			if musicenemies > 0:
				$BackgroundMusic/RelaxMusic.stop()
				if $BackgroundMusic/CombatMusic.playing == false:
					$BackgroundMusic/CombatMusic.play()
				hasjustswapped = true
			else:
				if is_frozen == false:
					if hasjustswapped == false:
						if $BackgroundMusic/RelaxMusic.playing == false:
							$BackgroundMusic/RelaxMusic.play()
					else:
						if $BackgroundMusic/RelaxMusic.playing == false:
							$BackgroundMusic/CombatMusic.stop()
							$BackgroundMusic/RelaxMusic.play()
						hasjustswapped = false
		else:
			if $BackgroundMusic/RelaxMusic.playing == true:
				$BackgroundMusic/RelaxMusic.stop()
				$BackgroundMusic/CombatMusic.play()
			if $SoundEffects/LowHealthMusic.playing == false:
				$SoundEffects/LowHealthMusic.play()
			if $BackgroundMusic/CombatMusic.playing == false:
				$BackgroundMusic/CombatMusic.play()
	else:
		if $"BackgroundMusic/Title Screen".playing == false:
			$"BackgroundMusic/Title Screen".play()
	# Play freeze sound effect

func setmas():
	artifactcounter += 1
	masmagic = true
	$CanvasLayer/PauseMenu/Artifacts.text = "[center]Artifacts Obtained - " + str(artifactcounter) + "/5"
	print("masmagic enabled")
	$CanvasLayer/Dialogue.text = "[center]You found: Massif's Magic: Timestop upgraded![/center]"
	$CanvasLayer/Dialogue.visible = true
	timestoplength = 7
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialogue.visible = false

func setal():
	artifactcounter += 1
	alfury = true
	$CanvasLayer/PauseMenu/Artifacts.text = "[center]Artifacts Obtained - " + str(artifactcounter) + "/5"
	print("alfury enabled")
	$CanvasLayer/Dialogue.text = "[center]You found: Alette's Fury: Damage upgraded![/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialogue.visible = false

func setmel():
	artifactcounter += 1
	melamul = true
	$CanvasLayer/PauseMenu/Artifacts.text = "[center]Artifacts Obtained - " + str(artifactcounter) + "/5"
	print("melamul enabled")
	var helper = _max_health + 2
	_max_health = _max_health + 2
	$CanvasLayer/HealthUI.set_max_hearts(helper)
	set_health(helper)
	$CanvasLayer/Dialogue.text = "[center]You found: Mello's Amulet: Health upgraded![/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialogue.visible = false

func setholy():
	artifactcounter += 1
	holysal = true
	$CanvasLayer/PauseMenu/Artifacts.text = "[center]Artifacts Obtained - " + str(artifactcounter) + "/5"
	print("holysal enabled")
	$CanvasLayer/Dialogue.text = "[center]You found: Holy Salt: Slime Instakill![/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialogue.visible = false

func setheal():
	artifactcounter += 1
	healpot = true
	$CanvasLayer/PauseMenu/Artifacts.text = "[center]Artifacts Obtained - " + str(artifactcounter) + "/5"
	print("healpot enabled")
	$CanvasLayer/Dialogue.text = "[center]You found: A Healing Potion! Press [color=blue]V[/color] to use.[/center]"
	$CanvasLayer/Interface/healtext.visible = true
	$CanvasLayer/Interface/heal_button.visible = true
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialogue.visible = false

func interactdialogue():
	$CanvasLayer/Dialogue.text = "[center]Press [color=forestgreen]X[/color] to interact with objects and NPCs.[/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Dialogue.visible = false

func attackdialogue():
	$CanvasLayer/Dialogue.text = "[center]Press [color=red]C[/color] to attack baddies![/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Dialogue.visible = false

func freezedialogue():
	$CanvasLayer/Dialogue.text = "[center]Press [color=lightblue]Z[/color] to freeze time![/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Dialogue.visible = false

func movedialogue():
	$CanvasLayer/Dialogue.text = "[center]Use The Arrow Keys to move![/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Dialogue.visible = false

func pausedialogue():
	$CanvasLayer/Dialogue.text = "[center]Press Escape to Pause[/center]"
	$CanvasLayer/Dialogue.visible = true
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Dialogue.visible = false
