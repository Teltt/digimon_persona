extends Control

@export var current_message:MessageTree =null
@export var choices: Array[MessageChoice] = []
var displaying = false
var current_choice = -1
var choosing = false
var during_digivolution = false
@onready var anim_player = $"AnimationPlayer"
@onready var box = $"Poly"
@onready var portrait = $"Portrait"
@onready var name_label = $"Poly/Name"
@onready var message_label = $"Poly/Message"
@onready var choices_node = $"Choices"
var awaiting = false
signal closed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func display(new_message):
	if is_instance_valid(new_message):
		
		displaying = true
		anim_player.play("popup")
		awaiting = true
		await(anim_player.animation_finished)
		awaiting = false
		change_message(new_message)
func close():
	anim_player.play("popout")
	awaiting = true
	await(anim_player.animation_finished)
	awaiting = false
	displaying = false
	name_label.text = ''
	message_label.text = ''
	closed.emit()
func change_message(next_message):
	
	if is_instance_valid(next_message): 
		current_message = next_message
		current_message.set_flags()
		current_message.call_functions()
		if not current_message.change_speaker.is_empty():
			if current_message.change_speaker == 'None':
				name_label.text = ''
			else:
				name_label.text = '[center]'+current_message.change_speaker
		message_label.text = current_message.line1+'\n'+current_message.line2+'\n'+current_message.line3+'\n'
		return not current_message.close_message_box
	else:
		current_message = null
	return false
func progress_text_box():
	var continue_display = true
	if not choosing and current_message.check_skip():
		choices.clear()
		var choices_valid = false
		var indx = 0
		for choice in current_message.choices:
			if is_instance_valid(choice):
				if not choice.check_skip():
					continue
				choices_valid = true
				choices.push_back(choice)
				indx += 1
				if indx > 3:
					print("too_many choices")
					break
			else:
					print("invalid choice")
		if choices_valid:
			choosing = true
			anim_player.play("display_choices")
			current_choice = 0
			return
	if not choosing:
		continue_display = change_message(current_message.next_message)
		choosing = false
		if continue_display:
			anim_player.play("progress")
			return
		else:
			close()
			return
	if choosing:
		if current_message.is_digivolution_question:
			if choices[current_choice].is_digivolution_answer:
				Game.data.digivolution_questions.push_back(current_message)
		
		anim_player.play("popout_choices")
		awaiting = true
		await(anim_player.animation_finished)
		awaiting = false
		choices[current_choice].set_flags()
		choices[current_choice].call_functions()
		continue_display = change_message(choices[current_choice].next_message)
		choosing = false
		if continue_display:
			anim_player.play("progress")
			return
		else:
			anim_player.play("popout_choices")
			awaiting = true
			await(anim_player.animation_finished)
			awaiting = false
			
			close()
			return
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if awaiting:
		return
	if is_instance_valid(current_message):
		if Input.is_action_just_pressed("ui_accept") or not current_message.check_skip():
			progress_text_box()
			pass
		if choosing:
			
			if Input.is_action_just_pressed("ui_down"):
				current_choice = (current_choice+1)%choices.size()
				
			if Input.is_action_just_pressed("ui_up"):
				current_choice = wrapi(current_choice-1,0,choices.size())
			for child_indx in choices_node.get_child_count():
				var child = choices_node.get_child(child_indx)
				child.color = Color(0.14509804546833, 0.21960784494877, 0.14509804546833)
				if child_indx < choices.size():
					child.get_child(0).text = choices[child_indx].text
					child.set_visible(true)
				else:
					child.get_child(0).text = ""
					child.set_visible(false)
			if current_choice >= 0 and current_choice < choices.size() and current_choice < choices_node.get_child_count():
				choices_node.get_child(current_choice).color = Color(0.14509804546833, 0.71764707565308, 0.14509804546833)
		pass
	pass
func break_anim():
	var _breakpoin = 1
