extends Control

@export var current_message:Array[BattleMessage]=[]
var index:int = -1
var actor:Node
var displaying = false
var temp_participant
@onready var anim_player = $"AnimationPlayer"
@onready var box = $"Poly"
@onready var message_label = $"Poly/Message"
@onready var atbeat = $ATBeat
var awaiting = false
signal closed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func display(new_message):
	if current_message.size() < 5:
		if is_instance_valid(new_message):
			index = current_message.size()
			current_message.push_back(new_message)
			atbeat.display(new_message)
			displaying = true
			anim_player.play("popup")
			awaiting = true
			await(anim_player.animation_finished)
			awaiting = false
			change_message(new_message,index,"")
func close():
	anim_player.play("popout")
	awaiting = true
	await(anim_player.animation_finished)
	awaiting = false
	displaying = false
	message_label.text = ''
	closed.emit()
func change_message(next_message,i,virtue):
	
	if is_instance_valid(next_message): 
		if is_instance_valid(current_message[i]):
			next_message.participants = current_message[i].participants
			current_message[i] = next_message
			current_message[i].call_functions()
			if is_instance_valid(current_message[i].attack):
				var attack = current_message[i].attack
				actor.health_bar.hp_total_change -= attack.physical_power
			message_label.text = current_message[i].line1+'\n'+current_message[index].line2+'\n'+current_message[index].line3+'\n'
			message_label.text = message_label.text.replace("<actor>",actor.get_actor_name())
			message_label.text = message_label.text.replace("<virtue>",virtue)
			
			for participant in next_message.participants.dictionary:
				var identifier = participant.identifier
				if is_instance_valid(participant.actor):
					var actor_name = participant.actor.get_actor_name()
					message_label.text = message_label.text.replace(identifier,actor_name)
			atbeat.bars[i].beats_till_fill = next_message.time
			atbeat.bars[i].beats_till_empty = next_message.drain
			atbeat.bars[i].value = 1
			return not current_message[i].close_message_box
	else:
		current_message.remove_at(i)
		atbeat.close_atbeat()
		anim_player.play("popout")
	return false
func progress_text_box(my_virtue,i):
	var continue_display = true
	var next = current_message[i].dont_care_message
	if current_message[i].loops:
		next = current_message[i]
	if current_message[i].virtue_response.virtue_in(my_virtue):
		next = current_message[i].virtue_response.get_by_virtue(my_virtue).msg
	
	continue_display = change_message(next,i,my_virtue)
	if continue_display:
		anim_player.play("progress")
		return
	else:
		if i in range(current_message.size()):
			current_message.remove_at(i)
			atbeat.close_atbeat()
			anim_player.play("popout")
		return
	
func break_anim():
	var _breakpoin = 1


func _on_battle_menu_virtue(virtue_str,mactor):
	if current_message.size() <= index:
		index = current_message.size()
		return
	if(current_message[index].participants.identifier_in("<actor2>")):
		var participant = current_message[index].participants.get_by_identifier("<actor2>")
		participant.actor = mactor
		
	progress_text_box(virtue_str,index)
	pass # Replace with function body.



