extends BoxContainer
var state :BattleMenu.ACTBOX_STATE = BattleMenu.ACTBOX_STATE.COLLAPSED
@export var battle_menu:Node
@export var button:Node
@onready var box = $Panel/MarginContainer/ScrollContainer/VBoxContainer
@onready var button_scene=preload("res://Game_Data/UI_Scenes/button.tscn")
var focus_memory = -1
var is_focus = false
var accepting_input = false
signal back_button
signal forward_button
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func add_item(button_name,press_method,focus_string,igrab_focus = false):
	scale.x =1.0
	var button = button_scene.instantiate()
	
	var actual_button =  button
	actual_button.text = button_name.to_upper()
	box.add_child(button)
	actual_button.connect("pressed",press_method,CONNECT_ONE_SHOT)
	var focus_method = func (str = focus_string):
		battle_menu.set_textbox_text(str)
	actual_button.connect("focus_entered",focus_method)
	if is_instance_valid(igrab_focus):
		actual_button.grab_focus()
func unfocus():
	is_focus = false
func dofocus():
	var i2 = 0
	if focus_memory > box.get_child_count():
		focus_memory = -1
	for i in box.get_child_count():
		var child = box.get_child(i)
		if i2 == focus_memory and not child.is_queued_for_deletion():
			child.grab_focus()
			break
		if focus_memory == -1 and not child.is_queued_for_deletion():
			child.grab_focus()
			break
		i2+=1
	is_focus = true
func clear():
	for child in box.get_children():
		child.queue_free()
	unfocus()
	scale.x = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if not battle_menu.battle.awaiting:
		if is_focus:
			is_focus = false
			for i in box.get_child_count():
				if box.get_children()[i].has_focus():
					focus_memory = i
					is_focus = true
					break
				
			if focus_memory == -1:
				focus_memory = 0
				is_focus = true
		if is_focus:
			button.button.modulate = Color8(198,198,255)
			
			if Input.is_action_just_pressed(button.back_action):
				back_button.emit()

		else:
			button.button.modulate = Color8(255,255,255)
		pass
		if accepting_input == false:
			button.button.modulate = button.button.modulate*0.5


func _on_pressed():
	if not battle_menu.battle.awaiting:
		is_focus = true
		if is_focus:
			for i in box.get_child_count():
				if box.get_children()[i].has_focus():
					if  accepting_input:
						box.get_children()[i].pressed.emit()
						dofocus()
			if  accepting_input:
				forward_button.emit()
				dofocus()
		
		dofocus()
	pass # Replace with function body.
