extends Node2D
@onready var field = $field
@onready var event = $event
@onready var msg_box = $CanvasLayer/msg_box
@onready var load_fade = $CanvasLayer/loadfade
@onready var rank_up = $"CanvasLayer/Rank Up"
@onready var date = $CanvasLayer/date
@onready var camera = $Camera
@onready var mc = $field/mc_field
var tasks :Array[Task] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.field = field
	Game.main = self
	var month = Game.data.month - 3
	if month < 1:
		month+=12
	date.set_date(month,Game.data.day)
	pass # Replace with function body.
func can_interact():
	return not msg_box.displaying and not rank_up.displaying and not load_fade.loading
func can_progress_event():
	return not msg_box.displaying and not rank_up.displaying and not load_fade.loading
func display_msg_box(new_message):
	msg_box.display(new_message)
func load_new_field(new_field, from_scratch = false):
	load_fade.lambada = load_field
	load_fade.load_instance = new_field
	load_fade.from_scratch = from_scratch
	load_fade.fade_out()
func load_new_event(new_event, from_scratch = false):
	load_fade.lambada = load_event
	load_fade.load_instance = new_event
	load_fade.from_scratch = from_scratch
	load_fade.fade_out()
func load_field(new_field, from_scratch = false):
	if not from_scratch:
		if is_instance_valid(field):
			var old_field = field
			remove_child(old_field)
			old_field.queue_free()
			mc.queue_free()
		if is_instance_valid(event):
			var old_event = event
			remove_child(old_event)
			old_event.queue_free()
			
	mc = load("res://Game_Data/OBJ/mc_field.tscn").instantiate()
		
	var n_field = new_field.instantiate()
	n_field.set_visible(false)
	add_child(n_field)
	n_field.add_child(mc)
	mc.position = n_field.get_node("Default_MC_Pos").position
	n_field.name = "field"
	field = n_field
func load_event(p_event, from_scratch = false):
	if not from_scratch:
		if is_instance_valid(field):
			var old_field = field
			remove_child(old_field)
			old_field.queue_free()
			mc.queue_free()
		if is_instance_valid(event):
			var old_event = event
			remove_child(old_event)
			old_event.queue_free()
		
	var n_event = p_event.instantiate()
	n_event.set_visible(false)
	add_child(n_event)
	camera.position = n_event.get_node("Camera_Pos").position
	n_event.name = "event"
	event = n_event
	load_fade.fade_in()
func change_time(time):
	Game.data.time = time
	date.set_time(time)
func progress_date(by_days = 1):
	
	var month = Game.convert_to_actual_month(Game.data.month,Game.data.day)
	Game.data.flags['on_'+Game.get_week_day(month,Game.data.day).to_lower()] = false
	Game.data.day += by_days
	Game.data.time =Game.TimeOfDay.Morning
	date.set_time(Game.data.time)
	if Game.data.day > Game.days_in_month_dictionary[month]:
		Game.data.day = 1
		Game.data.month = Game.convert_to_fake_month(Game.data.month+1)
	month = Game.convert_to_actual_month(Game.data.month,Game.data.day)
	Game.data.flags['on_'+Game.get_week_day(month,Game.data.day).to_lower()] = true
	date.set_date(month,Game.data.day)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#get_tree().paused = true
	if is_instance_valid(field):
		field.set_visible(true)
	if is_instance_valid(event):
		event.set_visible(true)
	pass
