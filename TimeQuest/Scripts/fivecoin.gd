extends Area2D

func _on_body_entered(body):
	if body.has_method("player"):
		body.add_money()
		body.add_money()
		body.add_money()
		body.add_money()
		body.add_money()
		queue_free()
