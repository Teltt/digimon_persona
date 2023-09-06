extends Control
class_name BattleMenu
enum ACTBOX_STATE {
	COLLAPSED,
	SKILL,
	ITEM,
	ACT,
	ACT_DIGIVOLVE,
	ACT_CREST_POWER,
	ACT_MERCY
}
@export var battle:Battle
@onready var textbox = $TextBox/Panel/MarginContainer/TextEdit
@onready var msg = $msg
@onready var actbox_container = $ActBox
@onready var actbox = $ActBox
@onready var skill = $Skill
@onready var skillbox = $SkillBox
@onready var skill2 = $Skill2
@onready var skillbox2 = $SkillBox2
@onready var skill3 = $Skill3
@onready var skillbox3 = $SkillBox3
@onready var act = $Act
@onready var sfx_turn_start = $Sfx/TurnStart
@onready var sfx_select = $Sfx/Select
@onready var sfx_turn_end = $Sfx/TurnEnd
var actbox_state = ACTBOX_STATE.COLLAPSED
var get_actor_davis = func():
	var temp = Battle.get_davis()
	return temp
const COURAGE:String = "Act brave and reckless."
const FRIENDSHIP = "Act fun and peaceful."
const LOVE= "Act caring and envigorating."
const KNOWLEDGE = "Act curious and informative."
const SINCERITY= "Act genuine and honest."
const RELIABILITY = "Act trustworthy and responsible."
const HOPE = "Act patient and strong."
const LIGHT = "Act cheerful and colorful."
const KINDNESS = "Act considerate and respectful."
const MIRACLE = "Act optimistic and dream big."
signal virtue(virtue_str:String,mactor:Node)

func on_skill_pressed():

	pass



func on_crest_power_pressed():
	collapse_box(actbox)
	show_box(actbox,ACTBOX_STATE.ACT_CREST_POWER)
	actbox.add_item("Courage",on_courage_pressed,
	COURAGE,true)
	actbox.add_item("Friendship",on_friendship_pressed,
	FRIENDSHIP)
	actbox.add_item("Love",on_love_pressed,
	LOVE)
	actbox.add_item("Knowledge",on_knowledge_pressed,
	KNOWLEDGE
	)
	actbox.add_item("Sincerity",on_sincerity_pressed,
	SINCERITY)
	actbox.add_item("Reliability",on_reliability_pressed,
	RELIABILITY)
	actbox.add_item("Hope",on_hope_pressed,
	HOPE)
	actbox.add_item("Light",on_light_pressed,
	LIGHT)
	actbox.add_item("Kindness",on_kindness_pressed,
	KINDNESS)
	actbox.add_item("Miracle",on_miracle_pressed,
	MIRACLE)
	actbox.dofocus()
func on_courage_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Courage",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_friendship_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Friendship", get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_love_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Love",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_knowledge_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Knowledge",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_sincerity_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Sincerity",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_reliability_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Reliability",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_hope_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Hope",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_light_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Light",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass
func on_kindness_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Kindness",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass	
func on_miracle_pressed():
	var davis = get_actor_davis.call()
	davis.scheduled = func ():
		virtue.emit("Miracle",get_actor_davis.call())
		collapse_box(actbox)
	end_turn(actbox,true,false)
	pass

func on_Run_pressed():
	pass


func set_textbox_text(text):
	textbox.text = text
func collapse_box(scrollbox,igrab_focus = null):
	scrollbox.scale.x = 0.0
	scrollbox.state = ACTBOX_STATE.COLLAPSED
	scrollbox.clear()
	if is_instance_valid(igrab_focus):
		igrab_focus.grab_focus()
func show_box(scrollbox,state:ACTBOX_STATE):
	if scrollbox.accepting_input:
			
		actbox.unfocus()
		skillbox2.unfocus()
		skillbox3.unfocus()
		skillbox.unfocus()
		scrollbox.state = state
		scrollbox.scale.x = 1.0
		scrollbox.dofocus()
# Called when the node enters the scene tree for the first time.
func _ready():
	skill.grab_focus()
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	pass
func show_act_menu():
	
	if actbox.accepting_input:
		actbox.add_item("DIGIVOLVE",on_digivolve_pressed,
		"Digivolve your Digimon",true)
		actbox.add_item("Virtue",on_crest_power_pressed,
		"Act in alignment with a crest virtue for a friend or foe.")
		actbox.add_item("run",on_Run_pressed,
		"Escape.")
		actbox.dofocus()
func on_act_pressed():
	if actbox.state == ACTBOX_STATE.COLLAPSED:
		show_box(actbox,ACTBOX_STATE.ACT)
		show_act_menu()
	
func _on_act_box_back_button():
	match actbox.state:
		ACTBOX_STATE.ACT:
					collapse_box(actbox)
					actbox.unfocus()
		ACTBOX_STATE.ACT_DIGIVOLVE:
					collapse_box(actbox)
					show_box(actbox,ACTBOX_STATE.ACT)
					show_act_menu()
		ACTBOX_STATE.ACT_CREST_POWER:
					collapse_box(actbox)
					show_box(actbox,ACTBOX_STATE.ACT)
					show_act_menu()
func on_digivolve_pressed():
	collapse_box(actbox)
	
	show_box(actbox,ACTBOX_STATE.ACT_DIGIVOLVE)
	if actbox.accepting_input:
		actbox.add_item("Evolve",on_evolve_pressed,
		"Digivolve by a single rank.",true)
		actbox.add_item("Armor",on_armor_evolve_pressed,
		"Armor Digivolve using a Digimental.")
		actbox.add_item("Jogress",on_jogress_pressed,
		"DNA Digivolve with a partner.")
func on_armor_evolve_pressed():
	pass
func on_evolve_pressed():
	pass
func on_jogress_pressed():
	pass
	pass # Replace with function body.


func _on_skill_box_3_back_button():
	collapse_box(skillbox3)
	pass # Replace with function body.


func _on_skill_box_3_forward_button():
	if battle.ally_digimon.size() > 2:
		if skillbox3.state == ACTBOX_STATE.COLLAPSED and skillbox3.accepting_input:
			show_box(skillbox3,ACTBOX_STATE.ACT)
			for attack in battle.ally_digimon[2].res.attacks:
				skillbox3.add_item(attack.name,
				func():
					var digimon = battle.ally_digimon[2]
					
					apply_attack(digimon,attack)
					
					collapse_box(skillbox3)
					skillbox3.accepting_input = false
					end_turn(skillbox3,true,false),
				attack.get_desc(),true)
	pass # Replace with function body.


func _on_skill_box_2_back_button():
	collapse_box(skillbox2)
	pass # Replace with function body.


func _on_skill_box_2_forward_button():
	if battle.ally_digimon.size() > 1:
		if skillbox2.state == ACTBOX_STATE.COLLAPSED and skillbox2.accepting_input:
			show_box(skillbox2,ACTBOX_STATE.ACT)
			for attack in battle.ally_digimon[1].res.attacks:
				skillbox2.add_item(attack.name,

				func():
					var digimon = battle.ally_digimon[1]
					
					apply_attack(digimon,attack)
					collapse_box(skillbox2)
					skillbox2.accepting_input = false
					end_turn(skillbox2,true,false)
				,
				attack.get_desc(),true)


func _on_skill_box_back_button():
	
	collapse_box(skillbox)
	pass # Replace with function body.


func _on_skill_box_forward_button():
	if battle.ally_digimon.size() > 0:
		if skillbox.state == ACTBOX_STATE.COLLAPSED and skillbox.accepting_input:
			show_box(skillbox,ACTBOX_STATE.ACT)
			for attack in battle.ally_digimon[0].res.attacks:
				skillbox.add_item(attack.name,
				
				func():
					var digimon = battle.ally_digimon[0]
					apply_attack(digimon,attack)
					
					collapse_box(skillbox)
					skillbox.accepting_input = false
					end_turn(skillbox,true,false),
				attack.get_desc(),true)
	pass # Replace with function body.
func start_turn(scroll_box):
	scroll_box.accepting_input = true
	sfx_turn_start.play(0.0)	
func end_turn(scroll_box,play_sound = true,play_wasted = true):
	if scroll_box.accepting_input:
		if play_wasted and play_sound:
			sfx_turn_end.play(0.0)
		if play_sound and not play_wasted:

			sfx_select.play(0.0)
	scroll_box.accepting_input = false
func _on_skill_full():
	start_turn(skillbox)
	pass # Replace with function body.
func _on_skill_empty():
	end_turn(skillbox)	
func _on_skill_3_full():	
	start_turn(skillbox3)
func _on_skill_3_empty():
	end_turn(skillbox3)	


func _on_skill_2_empty():
	end_turn(skillbox2)	
	pass # Replace with function body.


func _on_skill_2_full():	
	start_turn(skillbox2)
	pass # Replace with function body.


func _on_act_full():
	start_turn(actbox)	
	pass # Replace with function body.


func _on_act_empty():
	end_turn(actbox)	
	pass # Replace with function body.

func apply_attack(me_digi,attack):
	BattleGlobal.apply_attack_from_ally(me_digi,attack)
