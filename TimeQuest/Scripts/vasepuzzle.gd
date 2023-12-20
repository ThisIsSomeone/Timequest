extends StaticBody2D

@export var coiny : PackedScene

var player_inattack_zone = false
var health = 1

signal broken

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(_delta):
	damaged()

func _on_damage_box_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_damage_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func damaged():
	if player_inattack_zone == true and Global.player_current_attack == true:
		health = health - 1
		if health <= 0:
			health = 1000
			get_parent().brokenvases += 1
			$VaseSound.play()
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.modulate = Color(0.616, 0.463, 0.345)
			$AnimatedSprite2D.play("break")
			await $AnimatedSprite2D.animation_finished
			$AnimatedSprite2D.queue_free()
			$Collision.queue_free()
			$DamageBox/CollisionShape2D.queue_free()
			$DamageBox.queue_free()
			spawncoin()
			emit_signal("broken")

func spawncoin():
	var coin = coiny.instantiate()
	coin.position = Vector2(0,-3)
	add_child(coin)
