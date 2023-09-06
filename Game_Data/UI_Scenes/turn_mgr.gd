extends Control
@onready var turns = $Turns

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func do_turn():
	turns.get_child(0).do_turn()
func add_turn(turn):
	turns.add_child(turn)
func organize_turns():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
