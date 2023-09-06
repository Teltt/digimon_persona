extends Node2D

@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_animation(anim_name:String):
	anim_player.play(anim_name)
func stop_animation():
	anim_player.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
