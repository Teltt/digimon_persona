extends Node2D

@onready var message_box = $"msg_box"
@onready var button = $"msg_box/Button"
@export var initial_message:MessageTree = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	button.release_focus()
	message_box.display(initial_message)
	pass # Replace with function body.
