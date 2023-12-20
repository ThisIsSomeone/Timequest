extends StaticBody2D

var inArea = false
var alreadyopened = false
var player = null

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		inArea = true
		player = body

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		inArea = false

func _process(_delta):
	if Input.is_action_just_pressed("Interact") and inArea and alreadyopened == false:
		if not $opened.visible:
			$closed.visible = false
			$opened.visible = true
			$AudioStreamPlayer.play()
			alreadyopened = true
			$"inside object".visible = true
			await get_tree().create_timer(0.5).timeout
			$"inside object".visible = false
			player.restore_heart()
			player.restore_heart()
			player = null
			$"inside object".queue_free()
			$Area2D/CollisionShape2D.queue_free()
			$Area2D.queue_free()
			$AudioStreamPlayer.queue_free()
			$closed.queue_free()
			
			#TODO: Change the audio to be shorter? I like the sound but it's too long compared to the chest animation
			#Add whatever the chest does here
