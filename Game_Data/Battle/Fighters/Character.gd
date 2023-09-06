extends Node2D
class_name Character
@export var actor_name = "Default"
@export var res:ResCharacter
var did_schedule = false
var scheduled = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_actor_name():
	return res.name
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (scheduled is Callable) and did_schedule == false:
		did_schedule = true
		scheduled.call()
		scheduled = null
	pass

func on_at_beat_bar_full():
	
	if (scheduled is Callable) and did_schedule == false:
		did_schedule = true
		scheduled.call()
		scheduled = null
	pass # Replace with function body.

func on_at_beat_bar_broken():
	pass
func on_at_beat_bar_empty():
	if (scheduled is Callable) and did_schedule == false:
		did_schedule = true
		scheduled.call()
		scheduled = null
	did_schedule = false
	pass # Replace with function body.
