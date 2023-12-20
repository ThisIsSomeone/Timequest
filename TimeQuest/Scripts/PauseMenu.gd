extends Node2D

var havepaused = false
var displaycontrols = false


func _process(_delta):
	if havepaused == false:
		if Global.ispaused == true:
			havepaused = true
			self.show()
	if havepaused == true:
		if Global.ispaused == false:
			displaycontrols = false
			$Resumer.visible = true
			$Artifacts.visible = true
			$TotalTreasure.visible = true
			$BossKeys.visible = true
			$ResumerAlt.visible = false
			$Controls.visible = false
			self.hide()
			havepaused = false
	if havepaused == true:
		if Input.is_action_just_pressed("Attack"):
			if displaycontrols == false:
				displaycontrols = true
				$Resumer.visible = false
				$Artifacts.visible = false
				$TotalTreasure.visible = false
				$BossKeys.visible = false
				$ResumerAlt.visible = true
				$Controls.visible = true
			else:
				displaycontrols = false
				$Resumer.visible = true
				$Artifacts.visible = true
				$TotalTreasure.visible = true
				$BossKeys.visible = true
				$ResumerAlt.visible = false
				$Controls.visible = false
