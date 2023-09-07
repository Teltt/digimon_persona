extends Node
class_name FieldKicker
var message:MessageTree
@export var teleport_mc_to:String
@export_file var field:String
@export var change_time:bool = false
@export var time = Game.TimeOfDay.Evening
# Called when the node enters the scene tree for the first time.
func _ready():
	Game.main.display_msg_box(message)

	await Game.main.msg_box.closed
	if change_time:
		Game.main.change_time(time)
	Game.main.load_new_field(load(field))
	await(Game.main.load_fade.loaded)
	Game.main.mc.position = Game.main.field.get_node(teleport_mc_to).position
	Game.main.camera.position = Game.main.mc.position 
