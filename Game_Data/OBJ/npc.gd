extends Interactable

@export var message:MessageTree= null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func interact():
	Game.main.display_msg_box(message)
