extends Node2D

@export var howmanytobreak : int

var done = false
var donezero = false
var doneone = false
var donetwo = false
var donethree = false
var donefour = false
var donefive = false
var brokenvases = 0

signal completed
signal stopping
signal scream
signal firstwave
signal secondwave
signal thirdwave

func _process(_delta):
	if done == false:
		if brokenvases == howmanytobreak:
			done = true
			emit_signal("completed")
	if donezero == false:
		if brokenvases < 8 and brokenvases > 0:
			emit_signal("stopping")
	if doneone == false:
		if brokenvases > 11 and brokenvases < 16:
			doneone = true
			emit_signal("scream")
	if donetwo == false:
		if brokenvases > 21 and brokenvases < 27:
			donetwo = true
			emit_signal("firstwave")
	if donethree == false:
		if brokenvases > 25 and brokenvases < 36:
			emit_signal("secondwave")
			donethree = true
	if donefour == false:
		if brokenvases > 41 and brokenvases < 50:
			emit_signal("thirdwave")
			donefour = true
	if donefive == false:
		if brokenvases > 60:
			emit_signal("completed")
			print("done")
			donefive = true
