extends Node2D

@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("event")
	pass # Replace with function body.
func play_message_set(message:MessageTree):
	if Game.main.can_progress_event():
		Game.main.display_msg_box(message)
func s():
	pass

func set_evening():
	Game.main.change_time(Game.TimeOfDay.Evening)
func load_new_field(field:PackedScene):
	Game.main.load_new_field(field,true)
	queue_free()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.main.can_progress_event():
		anim_player.advance(delta)
	pass
