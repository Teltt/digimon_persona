extends Node2D
class_name Task
@onready var anim_player:AnimationPlayer = $AnimationPlayer
var me = null
var them = null
var task_finished = false
signal finished
func finish():
	finished.emit()

func play(me_digi,they_digi):
	me = me_digi
	them = they_digi
	anim_player.play("task")
	await(anim_player.animation_finished)
	finish()
