extends Node2D

@export var newpuzzle : PackedScene
@export var reward : PackedScene
var vasepuzzle = null
var rewardin = null
var solved = false
var isinspawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	vasepuzzle = newpuzzle.instantiate()
	rewardin = reward.instantiate()

func _on_player_detector_body_exited(body): 
	if body.has_method("player"):
		if solved == false:
			remove_child(vasepuzzle)
			vasepuzzle.queue_free()
			#vasepuzzle = newpuzzle.instantiate()
			#self.call_deferred("add_child", vasepuzzle)
			#vasepuzzle.completed.connect(_on_vasepuzzle_completed)
			#TODO: old puzzle remains present despite queueing free?


func _on_vasepuzzle_completed():
	solved = true
	add_child(rewardin)

func _on_player_detector_body_entered(body):
	if body.has_method("player"):
		if solved == false:
			vasepuzzle = newpuzzle.instantiate()
			self.call_deferred("add_child", vasepuzzle)
			vasepuzzle.completed.connect(_on_vasepuzzle_completed)


func _on_respawn_timeout():
	pass # Replace with function body.
