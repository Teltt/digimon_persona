extends Control
class_name Battle
var tasks:Array[Task] = []
@export var enemy_actor:Array[ResActor] = []
@export var ally_actor:Array[ResActor] = []
var enemy_digimon:Array[Digimon] = []
var enemy_character:Array[Character] = []
var ally_digimon:Array[Digimon] = []
var ally_character:Array[Character] = []
@onready var menu = $"Battle Menu"
@onready var timer = $Timer
@onready var digipos = [$Digimonpos1,$Digimonpos2,$Digimonpos3]
@onready var charapos = [$CharacterPos,$CharacterPos2,$CharacterPos3]
@onready var enemydigipos = [$Digimonpos4,$Digimonpos5,$Digimonpos6]
@onready var enemycharapos = [$CharacterPos4,$CharacterPos5,$CharacterPos6]
@onready var target_reticle = %Target
const digimon_scene = preload("res://Game_Data/Battle/Fighters/digimon.tscn")
const character_scene = preload("res://Game_Data/Battle/Fighters/character.tscn")
const atbeat_scene = preload("res://Game_Data/UI_Scenes/at_beat_bar.tscn")
const possible_tasks = {
	"damage" :preload("res://Game_Data/Battle/Anims/display_damage.tscn"),
	"stats" :preload("res://Game_Data/Battle/Anims/display_damage.tscn")
}
var awaiting = false
var signal_to_await
var target_x = 1
var target_y = 0
var target = null
var targetting = false
var targetting_ally = false
# Called when the node enters the scene tree for the first time.
func _ready():
	BattleGlobal.battle = self
	var digimon_added = 0
	var characters_added = 0
	for ally in ally_actor:
		if ally is ResDigimon and digimon_added < 3:
			digimon_added += 1
			var digimon:Digimon = digimon_scene.instantiate()
			
			digimon.res = ally
			digimon.texture = digimon.res.sprite_normal
			ally_digimon.append(digimon)
			$Players.add_child(digimon)
			if digimon_added == 1:
				menu.msg.actor = digimon
				digimon.auto_battles = false
				menu.msg.display(preload("res://Game_Data/Battle/Message/Final/Ken.tres").duplicate(true))
				digimon.atb = menu.skill
				menu.skill.beats_till_fill =ally.stats.WAIT
				menu.skill.beats_till_empty =ally.stats.DRAIN
				menu.skill.full.connect(digimon.on_at_beat_bar_full)
				menu.skill.empty.connect(digimon.on_at_beat_bar_empty)
				menu.skill.broken.connect(digimon.on_at_beat_bar_broken)
				digimon.global_position = digipos[0].global_position
			elif digimon_added == 2:
				digimon.atb = menu.skill2
				digimon.auto_battles = false
				menu.skill2.beats_till_fill =ally.stats.WAIT
				menu.skill2.beats_till_empty =ally.stats.DRAIN
				menu.skill2.full.connect(digimon.on_at_beat_bar_full)
				menu.skill2.empty.connect(digimon.on_at_beat_bar_empty)
				menu.skill2.broken.connect(digimon.on_at_beat_bar_broken)
				digimon.global_position = digipos[1].global_position
			elif digimon_added == 3:
				digimon.atb = menu.skill3
				digimon.auto_battles = false
				menu.skill3.beats_till_fill =ally.stats.WAIT
				menu.skill3.beats_till_empty =ally.stats.DRAIN
				menu.skill3.full.connect(digimon.on_at_beat_bar_full)
				menu.skill3.empty.connect(digimon.on_at_beat_bar_empty)
				menu.skill3.broken.connect(digimon.on_at_beat_bar_broken)
				digimon.global_position = digipos[2].global_position
		if ally is ResCharacter:
			var character:Character = character_scene.instantiate()
			ally_character.append(character)
			$Players.add_child(character)
			character.res = ally
			if characters_added == 0:
				menu.act.beats_till_fill = 1
				menu.act.beats_till_empty = 7
				menu.act.full.connect(character.on_at_beat_bar_full)
				menu.act.empty.connect(character.on_at_beat_bar_empty)
				menu.act.broken.connect(character.on_at_beat_bar_broken)
			
	for enemy in enemy_actor:
		if enemy is ResDigimon :
			var digimon:Digimon = digimon_scene.instantiate()
			digimon.res = enemy
			digimon.texture = digimon.res.sprite_normal
			enemy_digimon.append(digimon)
			$Enemies.add_child(digimon)
			
		if enemy is ResCharacter:
			var character:Character = character_scene.instantiate()
			character.res = enemy
			enemy_character.append(character)
			$Enemies.add_child(character)
	for i in min(2,enemy_digimon.size()):
		var digimon = enemy_digimon[i]
		var atbeat = atbeat_scene.instantiate()
		digimon.add_child(atbeat)
		digimon.atb = atbeat
		digimon.atb.full.connect(digimon.on_at_beat_bar_full)
		digimon.atb.broken.connect(digimon.on_at_beat_bar_broken)
		digimon.atb.empty.connect(digimon.on_at_beat_bar_empty)
		digimon.position = enemydigipos[i].position
	for i in min(2,enemy_character.size()):
		var digimon = enemy_character[i]
		digimon.auto_battles = true
		digimon.position = enemycharapos[i].position
	for i in min(2,ally_character.size()):
		var digimon = ally_character[i]
		digimon.position = charapos[i].position
	pass # Replace with function body.
static func get_davis():
	return Game.main.get_node("Battle").ally_character[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if awaiting:
		return
	if Input.is_action_just_pressed("target_left"):
		target_x = wrapi(target_x-1,0,2)
	if Input.is_action_just_pressed("target_right"):
		target_x = wrapi(target_x+1,0,2)
	if Input.is_action_just_pressed("target_up"):
		target_y = wrapi(target_y-1,0,3)
	if Input.is_action_just_pressed("target_down"):
		target_y = wrapi(target_y+1,0,3)
	if target_x == 0:
		target_reticle.position = enemydigipos[target_y].position
		if enemy_digimon.size() > target_y:
			target = enemy_digimon[target_y]
			targetting_ally = false
		else:
			target = null
			targetting_ally = false
			targetting = false
	if target_x == 1:
		target_reticle.position = digipos[target_y].position
		if ally_digimon.size() > target_y:
			target = ally_digimon[target_y]
			targetting_ally = true
			targetting = false
		else:
			target = null
			targetting_ally = true
			targetting = false
func await_signal(sig):
	awaiting = true
	timer.paused = true
	await(sig)
	timer.start()
	timer.paused = false
	awaiting = false
