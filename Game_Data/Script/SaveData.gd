extends Resource
class_name SaveData
@export var flags:Dictionary = {
	'on_monday':false,
	'on_tuesday':false,
	'on_wednesday':false,
	'on_thursday':false,
	'on_friday':false,
	'on_saturday':true,
	'on_sunday':false,
}
@export var counters:Dictionary = {
	
}
@export var digivolution_questions :Array[MessageTree] = []
@export var month:int = 4
@export var day:int =12
@export var time:Game.TimeOfDay = Game.TimeOfDay.Morning

@export var yolei_bond :CharacterBond= load("res://Game_Data/Social/Character/Yolei.tres")
@export  var sora_bond :CharacterBond= load("res://Game_Data/Social/Character/Sora.tres")
@export var mimi_bond :CharacterBond= load("res://Game_Data/Social/Character/Mimi.tres")

##Battle
@export var mood_scheduler:Mood_Mgr= preload("res://Game_Data/Battle/Mood/Mood_Manager.tres")
@export var digi_vmon:ResDigimon = preload("res://Game_Data/Battle/Fighters/VMon/Fighter.tres")
@export var chara_davis:ResCharacter = preload("res://Game_Data/Battle/Fighters/Davis/Character.tres")
var party_members = {
	chara_davis:digi_vmon,
	chara_davis.duplicate():digi_vmon.duplicate(),
	chara_davis.duplicate():digi_vmon.duplicate()
}
