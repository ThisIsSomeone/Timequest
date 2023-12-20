extends Node2D

var pp1 = false
var pp2 = false
var pp3 = false
var pp4 = false
var pp5 = false
var pp6 = false
var pp7 = false
var pp8 = false
var pp9 = false
var pp10 = false
var pp11 = false
var pp12 = false
var pp13 = false
var pp14 = false
var pp15 = false

var issolved = false

signal solved

func _process(_delta):
	if pp1 and pp2 and pp3 and pp4 and pp5 and pp6 and pp7 and pp8 and pp9 and pp10 and pp11 and pp12 and pp13 and pp14 and pp15:
		if issolved == false:
			issolved = true
			emit_signal("solved")

func _on_pressure_plate_puzzel_pressure_plate_off():
	pp1 = true

func _on_pressure_plate_puzzel_pressure_plate_on():
	pp1 = false

func _on_pressure_plate_puzzel_2_pressure_plate_off():
	pp2 = true

func _on_pressure_plate_puzzel_2_pressure_plate_on():
	pp2 = false

func _on_pressure_plate_puzzel_3_pressure_plate_off():
	pp3 = false

func _on_pressure_plate_puzzel_3_pressure_plate_on():
	pp3 = true

func _on_pressure_plate_puzzel_4_pressure_plate_off():
	pp4 = true

func _on_pressure_plate_puzzel_4_pressure_plate_on():
	pp4 = false

func _on_pressure_plate_puzzel_5_pressure_plate_off():
	pp5 = true

func _on_pressure_plate_puzzel_5_pressure_plate_on():
	pp5 = false

func _on_pressure_plate_puzzel_6_pressure_plate_off():
	pp6 = true


func _on_pressure_plate_puzzel_6_pressure_plate_on():
	pp6 = false


func _on_pressure_plate_puzzel_7_pressure_plate_off():
	pp7 = false


func _on_pressure_plate_puzzel_7_pressure_plate_on():
	pp7 = true


func _on_pressure_plate_puzzel_8_pressure_plate_off():
	pp8 = false


func _on_pressure_plate_puzzel_8_pressure_plate_on():
	pp8 = true


func _on_pressure_plate_puzzel_9_pressure_plate_off():
	pp9 = false


func _on_pressure_plate_puzzel_9_pressure_plate_on():
	pp9 = true


func _on_pressure_plate_puzzel_10_pressure_plate_off():
	pp10 = true


func _on_pressure_plate_puzzel_10_pressure_plate_on():
	pp10 = false


func _on_pressure_plate_puzzel_11_pressure_plate_off():
	pp11 = false


func _on_pressure_plate_puzzel_11_pressure_plate_on():
	pp11 = true


func _on_pressure_plate_puzzel_12_pressure_plate_off():
	pp12 = false


func _on_pressure_plate_puzzel_12_pressure_plate_on():
	pp12 = true


func _on_pressure_plate_puzzel_13_pressure_plate_off():
	pp13 = false


func _on_pressure_plate_puzzel_13_pressure_plate_on():
	pp13 = true


func _on_pressure_plate_puzzel_14_pressure_plate_off():
	pp14 = false


func _on_pressure_plate_puzzel_14_pressure_plate_on():
	pp14 = true


func _on_pressure_plate_puzzel_15_pressure_plate_off():
	pp15 = false


func _on_pressure_plate_puzzel_15_pressure_plate_on():
	pp15 = true
