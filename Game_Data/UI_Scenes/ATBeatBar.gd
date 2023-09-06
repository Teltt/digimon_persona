extends ProgressBar
signal full
signal broken
signal empty
@export var auto_connect =true
@onready var atblabel= $Label
@export var beats_till_fill = 4:
	set(valu):
		beats_till_fill = valu
		max_value = valu
		if is_instance_valid(atblabel):
			atblabel.beats_till_fill = valu
@export var beats_till_empty = 8:
	set(valu):
		beats_till_empty = valu
		max_value = valu
		if is_instance_valid(atblabel):
			atblabel.beats_till_fill = valu
var beats_divisor = 1
var filling = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if auto_connect:
		EventBus.beat_timeout.connect(_on_atbeat_timeout)
	pass # Replace with function body.




func _on_atbeat_timeout():
	if filling:
		value+= step
		
		max_value = beats_till_fill
		atblabel.beats_till_fill = max_value
		if value == max_value and filling:
			filling = false
			max_value = beats_till_empty
			atblabel.beats_till_fill = max_value
			value = max_value
	elif not filling:
		value = min(value-step,max_value)
	pass # Replace with function body.


func _on_at_beat_bar_value_changed(myvalue):
	if myvalue == 0:
		max_value = beats_till_fill
		atblabel.beats_till_fill = max_value
		empty.emit()
		filling = true
	elif myvalue < 0:
		broken.emit()
		filling = true
	elif myvalue == beats_till_fill and filling == true:
		
		full.emit()
	pass # Replace with function body.


func _on_value_changed(_value):
	pass # Replace with function body.
