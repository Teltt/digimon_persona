extends Control
@onready var texturerect = $Panel/TextureRect
signal turn_over
var awaiting = false
var actor = null
var texture:AtlasTexture:
	set(value):
		texturerect.texture = value
	get:
		return texturerect.texture
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func do_turn():
	if is_instance_valid(actor):
		actor.do_turn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
