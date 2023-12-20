extends Area2D

var PlayerController #set by spawner

var frozen = false
var breaking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$StaticBody2D/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("default")
	PlayerController.connect("stoptime", self.freeze,0)
	PlayerController.connect("starttime", self.unfreeze,0)

func _process(_delta):
	if frozen == false and not breaking:
		position = position + Vector2(0,1.5)
	else:
		pass

func _on_body_entered(body):
	var dontdelete = false
	if frozen:
		return
	if body.has_method("log_spawner"):
		return
	if body.has_method("player"):
		body.lose_heart()
		
	else:
		if body.has_method("enemy"):
			if body.isdying == false:
				body.envdamage()
			else:
				dontdelete = true
		else:
			frozen = true
			$AnimatedSprite2D.stop()
	if dontdelete == false:
		call_deferred("breakLog")
		breaking = true
		$AnimatedSprite2D.modulate = Color(0.459, 0.325, 0.216)
		$AnimatedSprite2D.play("break")
		await $AnimatedSprite2D.animation_finished
		queue_free()

func breakLog():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Hitbox.disabled = true

func freeze():
	if breaking:
		return
	frozen = true
	$StaticBody2D/CollisionShape2D.disabled = false
	$AnimatedSprite2D.stop()

func unfreeze():
	if breaking:
		return
	frozen = false
	$StaticBody2D/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("default")
