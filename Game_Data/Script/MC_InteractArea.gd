extends Area2D
class_name MC_InteractArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Game.main.can_interact():
		for collision in get_overlapping_areas():
			if collision is Interactable and Input.is_action_just_pressed("ui_accept"):
				collision.interact()
	pass
