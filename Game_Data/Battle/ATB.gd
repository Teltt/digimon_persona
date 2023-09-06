extends Timer
const bpm = 120.0

var beats_divisor = 4:
	set(value):
		beats_divisor = value
		wait_time = (bpm/60.0)/value


# Called when the node enters the scene tree for the first time.
func _ready():
	timeout.connect(func():
		EventBus.beat_timeout.emit())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
