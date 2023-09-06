extends Label
var beats_till_fill = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_at_beat_bar_value_changed(value):
	text = str(value as int)+"/"+str(beats_till_fill)
	pass # Replace with function body.
