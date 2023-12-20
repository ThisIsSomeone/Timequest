extends Camera2D

var alreadypaused = false
var justpaused = false

func _on_video_stream_player_finished():
	get_parent().videodone = true
	
func _process(_delta):
	if Input.is_action_just_pressed("TimeStopActivation"):
		if alreadypaused == false:
			$CanvasLayer/VideoStreamPlayer.paused = true
			alreadypaused = true
			justpaused = true
			$CanvasLayer/pausetext.visible = true
		if alreadypaused == true and justpaused == false:
			$CanvasLayer/VideoStreamPlayer.paused = false
			alreadypaused = false
			$CanvasLayer/pausetext.visible = false
		justpaused = false
	if Input.is_action_just_pressed("Attack"):
		get_parent().videodone = true
