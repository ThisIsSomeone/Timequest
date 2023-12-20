extends Node2D

var creditscene = false
var mainscene = false
var titlescene = false
var paused = false
var switcheroo = false
var videodone = false
var alreadyplayingmusic = false

signal gpaused
signal gunpaused

func _ready():
	var next_level_resource = load("res://TitleScreen.tscn")
	var next_level = next_level_resource.instantiate()
	get_tree().current_scene.add_child(next_level)
	await get_tree().create_timer(2).timeout
	titlescene = true

func _process(_delta):
	if creditscene:
		if Input.is_action_just_pressed("Escape"):
			get_tree().quit()
		if Input.is_action_pressed("Interact"):
			creditscene = false
			for c in get_children():
				remove_child(c)
				c.queue_free()
			var next_level_resource = load("res://TitleScreen.tscn")
			var next_level = next_level_resource.instantiate()
			get_tree().current_scene.add_child(next_level)
			await get_tree().create_timer(2).timeout
			titlescene = true
	if titlescene:
		if Input.is_action_just_pressed("Escape"):
			get_tree().quit()
		if Input.is_action_pressed("Interact"):
			titlescene = false
			for c in get_children():
				remove_child(c)
				c.queue_free()
			var next_level_resource = load("res://GameIntro.tscn")
			var next_level = next_level_resource.instantiate()
			alreadyplayingmusic = false
			get_tree().current_scene.add_child(next_level)
		if Input.is_action_pressed("Attack"):
			titlescene = false
			for c in get_children():
				remove_child(c)
				c.queue_free()
			var next_level_resource = load("res://creditscene.tscn")
			var next_level = next_level_resource.instantiate()
			get_tree().current_scene.add_child(next_level)
			await get_tree().create_timer(2).timeout
			creditscene = true
	if mainscene:
		if Input.is_action_just_pressed("Escape"):
			if !paused:
				paused = true
				get_tree().paused = true
				Global.ispaused = true
				emit_signal("gpaused")
			else:
				paused = false
				get_tree().paused = false
				Global.ispaused = false
				emit_signal("gunpaused")
	if switcheroo:
		switcheroo = false
		mainscene = false
		for c in get_children():
			remove_child(c)
			c.queue_free()
		var next_level_resource = load("res://creditscene.tscn")
		var next_level = next_level_resource.instantiate()
		get_tree().current_scene.add_child(next_level)
		creditscene = true
	if videodone:
		videodone = false
		for c in get_children():
			remove_child(c)
			c.queue_free()
		var next_level_resource = load("res://Scenes/main_world.tscn")
		var next_level = next_level_resource.instantiate()
		get_tree().current_scene.add_child(next_level)
		await get_tree().create_timer(2).timeout
		mainscene = true
