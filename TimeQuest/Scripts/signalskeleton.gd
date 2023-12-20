extends CharacterBody2D

@onready var PlayerController = get_node("../PlayerController")
@export var coiny : PackedScene

signal skel_no_health

var _moveSpeed = 42.0
var _health = 3
var player_chase = false
var player = null
var frozen = false
var player_inattack_zone = false
var attack_ip = false
var isdying = false
var cantakedamage = true
var flicker = false

func _ready():
	PlayerController.connect("stoptime", self.freeze,0)
	PlayerController.connect("starttime", self.unfreeze,0)

func _physics_process(_delta):
	damaged()
	flickering()
	if isdying == false:
		if attack_ip == false:
			if frozen == false: #dit lijkt geen problemen te veroorzaken
				if player_chase:
					velocity = (player.position - position)
					velocity = velocity.normalized() * _moveSpeed
					move_and_slide()
					$AnimatedSprite2D.play("Walk")
					if(player.position.x - position.x) < 0:
						$AnimatedSprite2D.flip_h = true
					else:
						$AnimatedSprite2D.flip_h = false
				else:
					$AnimatedSprite2D.play("Idle")
			else:
				$AnimatedSprite2D.stop()

func flickering():
	if _health > 0:
		if flicker == true:
			$AnimatedSprite2D.visible = false
			await get_tree().create_timer(0.1).timeout
			$AnimatedSprite2D.visible = true
		else:
			$AnimatedSprite2D.visible = true
	else:
		$AnimatedSprite2D.visible = false

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	player.musicenemies = player.musicenemies + 1

func _on_detection_area_body_exited(_body):
	player.musicenemies = player.musicenemies - 1
	player = null
	player_chase = false
	
func freeze():
	frozen = true

func unfreeze():
	frozen = false

func enemy():
	if isdying == false:
		attack_ip = true
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("Attack") 
		await $AnimatedSprite2D.animation_finished
		if player_inattack_zone == true and not isdying:
			PlayerController.lose_heart()
		attack_ip = false

func _on_enemy_damage_box_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_enemy_damage_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func damaged():
	if player_inattack_zone and Global.player_current_attack == true:
		if cantakedamage == true:
			$HitSound.play()
			cantakedamage = false
			$atkcd.start()
			print("hi")
			_health = _health - 1
			if PlayerController.alfury and _health > 0:
				_health = _health-1
			flicker = true
			#TODO: knockback
			if _health <= 0:
				flicker = false
				isdying = true
				_health = 1000
				emit_signal("skel_no_health")
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.play("Death")
				await $AnimatedSprite2D.animation_finished
				_health = 0
				$AnimatedSprite2D.visible = false
				$Detection_Area/CollisionShape2D.queue_free()
				$Detection_Area.queue_free()
				$Hitbox.queue_free()
				$Enemy_Damage_Box/CollisionShape2D.queue_free()
				$Enemy_Damage_Box.queue_free()
				$atkcd.queue_free()
				spawncoin()

func _on_atkcd_timeout():
	cantakedamage = true
	flicker = false

func envdamage():
	if cantakedamage == true:
			cantakedamage = false
			$atkcd.start()
			print("hi")
			_health = _health - 1
			flicker = true
			#TODO: knockback
			if _health <= 0:
				flicker = false
				isdying = true
				emit_signal("skel_no_health")
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.play("Death")
				await $AnimatedSprite2D.animation_finished
				_health = 0
				$AnimatedSprite2D.visible = false
				$Detection_Area/CollisionShape2D.queue_free()
				$Detection_Area.queue_free()
				$Hitbox.queue_free()
				$Enemy_Damage_Box/CollisionShape2D.queue_free()
				$Enemy_Damage_Box.queue_free()
				$atkcd.queue_free()
				spawncoin()

func spawncoin():
	var coin = coiny.instantiate()
	add_child(coin)
