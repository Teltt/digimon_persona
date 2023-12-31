extends Interactable
class_name FieldTransition

@export var teleport_mc_to:Vector2
@export_file var field:String
@export var change_time:bool = false
@export var time = Game.TimeOfDay.Evening
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func interact():
	if change_time:
		Game.main.change_time(time)
	Game.main.load_new_field(load(field))
	await(Game.main.load_fade.loaded)
	Game.main.mc.position = teleport_mc_to
	Game.main.camera.position = teleport_mc_to
