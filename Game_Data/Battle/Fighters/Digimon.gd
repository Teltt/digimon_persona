extends Node2D
class_name Digimon
var awaiting = false
var auto_battles = true
@onready var health_bar = $Health
@onready var sprite = $Sprite2D
@export var effects :Array[Effect] = []
@export var res :ResDigimon
var texture:
	set(value):
		texture = value
		if is_instance_valid(sprite):
			sprite.texture = value
var atb = null
# Called when the node enters the scene tree for the first time.
func _ready():
	texture = texture
	health_bar.health = health_bar.health
	pass # Replace with function body.
func get_actor_name():
	return res.name
func _update_state():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func on_at_beat_bar_full():
	if auto_battles:
		var target = BattleGlobal.battle.ally_digimon[0]
		BattleGlobal.apply_attack_from_enemy(self,res.attacks[0],target, false)
		BattleGlobal.apply_attack_from_enemy(self,res.attacks[1],self, true)
	pass # Replace with function body.

func on_at_beat_bar_broken():
	pass
func on_at_beat_bar_empty():
	pass # Replace with function body.
func change_res(new_res):
	res =new_res
	
