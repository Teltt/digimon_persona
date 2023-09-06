extends Node2D

@onready var p = $"../"
@onready var atbeatbar1 = $Bar
@onready var atbeatbar2=  $Bar2
@onready var atbeatbar3 = $Bar3
@onready var atbeatbar4 = $Bar4
@onready var atbeatbar5 = $Bar5
const DONTCARE = "Don'tCare"
@onready var bars = [$Bar,$Bar2,$Bar3,$Bar4,$Bar5]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func display(new_message):
	if p.current_message.size() < 5:
		if is_instance_valid(new_message):
			var index = p.current_message.size()-1
			if index == 0:
				atbeatbar1.set_visible(true)
				EventBus.beat_timeout.connect(atbeatbar1._on_atbeat_timeout)
			if index == 1:
				atbeatbar2.set_visible(true)
				EventBus.beat_timeout.connect(atbeatbar2._on_atbeat_timeout)
			if index == 2:
				atbeatbar3.set_visible(true)
				EventBus.beat_timeout.connect(atbeatbar3._on_atbeat_timeout)
			if index == 3:
				atbeatbar4.set_visible(true)
				EventBus.beat_timeout.connect(atbeatbar4._on_atbeat_timeout)
			if index == 4:
				atbeatbar5.set_visible(true)
				EventBus.beat_timeout.connect(atbeatbar5._on_atbeat_timeout)
func close_atbeat():
	var indexs = p.current_message.size()
	if indexs == 0:
		atbeatbar1.set_visible(false)
		EventBus.beat_timeout.disconnect(atbeatbar1._on_atbeat_timeout)
	if indexs == 1:
		atbeatbar2.set_visible(false)
		EventBus.beat_timeout.disconnect(atbeatbar2._on_atbeat_timeout)
	if indexs == 2:
		atbeatbar3.set_visible(false)
		EventBus.beat_timeout.disconnect(atbeatbar3._on_atbeat_timeout)
	if indexs == 3:
		atbeatbar4.set_visible(false)
		EventBus.beat_timeout.disconnect(atbeatbar4._on_atbeat_timeout)
	if indexs == 4:
		atbeatbar5.set_visible(false)
		EventBus.beat_timeout.disconnect(atbeatbar5._on_atbeat_timeout)

func _on_bar_full():
	p.progress_text_box(DONTCARE,0)
	pass # Replace with function body.


func _on_bar_2_full():
	p.progress_text_box(DONTCARE,1)
	pass # Replace with function body.


func _on_bar_3_full():
	p.progress_text_box(DONTCARE,2)
	pass # Replace with function body.


func _on_bar_4_full():
	p.progress_text_box(DONTCARE,3)
	pass # Replace with function body.


func _on_bar_5_full():
	p.progress_text_box(DONTCARE,4)
	pass # Replace with function body.
