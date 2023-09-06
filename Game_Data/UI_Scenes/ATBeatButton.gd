@tool
extends BoxContainer

@onready var bar = $Node2D/ATBeatBar
@onready var button = $Panel/MarginContainer/Button
@export var action = "square"
@export var back_action = "ui_left"
@export var button_text = "SKILL":
	set(value):
		button_text = value
		if not Engine.is_editor_hint():
			if is_instance_valid(button):
				button.text = "  -"+value
	
var beats_till_fill = 4:
	set(value):
		beats_till_fill = value
		if not Engine.is_editor_hint():
				bar.beats_till_fill = value
var beats_till_empty = 8:
	set(value):
		beats_till_empty = value
		if not Engine.is_editor_hint():
				bar.beats_till_empty = value
var beats_divisor = 4:
	set(value):
		beats_divisor = value
		if not Engine.is_editor_hint():
				bar.beats_divisor = value
signal pressed
signal full
signal empty
signal broken
# Called when the node enters the scene tree for the first time.
func _ready():
	beats_divisor = beats_divisor
	button_text = button_text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed(action):
			pressed.emit()
	pass


func _on_button_pressed():
	pressed.emit()
	pass # Replace with function body.


func _on_at_beat_bar_broken():
	broken.emit()
	pass # Replace with function body.


func _on_at_beat_bar_empty():
	empty.emit()
	pass # Replace with function body.


func _on_at_beat_bar_full():
	full.emit()
	pass # Replace with function body.
