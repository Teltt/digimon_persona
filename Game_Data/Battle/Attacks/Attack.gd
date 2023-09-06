extends Resource
class_name Attack
func apply(me_digi:Digimon,they_digi:Digimon):
	var damage = BattleGlobal.get_damage(me_digi,they_digi,self)
	
	if grants_technical and check_grants_technical(they_digi):
		damage *= 1.25
		they_digi.atb.value = -they_digi.res.stats.BREAK+extra_break_time
		they_digi.atb._on_at_beat_bar_value_changed(they_digi.atb.value)
		pass
	if breaks_with_weakness :
		var break_result = check_grants_break(they_digi)
		if break_result == 0:
			pass
			##they_digi resists check if it nulls resistance
		if break_result == 1:
			pass
			##nothing
		if break_result == 2:
			damage *= 1.25
			they_digi.atb.value = -they_digi.res.stats.BREAK+extra_break_time
			they_digi.atb._on_at_beat_bar_value_changed(they_digi.atb.value)
		pass
	var statuses = get_statuses()
	for key in statuses:
		if statuses[key]:
			grant_status(they_digi)
			break
	if is_instance_valid(animation_scene):
		var anim = animation_scene.instantiate()
		if anim is Task:
				
			if anim is DamageTask:
				they_digi.health_bar.hp_total_change -= damage
			anim.play(me_digi,they_digi)
			Game.main.get_node("Battle").await_signal(anim.finished)
			await anim.finished
	if is_instance_valid(next_hit):
		next_hit.apply(me_digi,they_digi)
	pass
func check_grants_technical(they_digi):
	var dict = Attack.new().get_statuses()
	for effect in they_digi.effects:
		dict = merge_statuses(dict,effect.attack.get_statuses())
	var req = technical_requirments.get_statuses()
	for key in req:
		if req[key] and req[key]== dict[key]:
			return true
	return false
func check_grants_break(they_digi):
	if type == Attack.Type.Fire and they_digi.res.type == Attack.Type.Grass:
		return 2
	if they_digi.res.type == Attack.Type.Fire and type == Attack.Type.Grass:
		return 0
	if type == Attack.Type.Grass and they_digi.res.type == Attack.Type.Water:
		return 2
	if they_digi.res.type == Attack.Type.Grass and type == Attack.Type.Water:
		return 0
	if type == Attack.Type.Water and they_digi.res.type == Attack.Type.Fire:
		return 2
	if they_digi.res.type == Attack.Type.Water and type == Attack.Type.Fire:
		return 0
	if type == Attack.Type.Earth and they_digi.res.type == Attack.Type.Lightning:
		return 2
	if they_digi.res.type == Attack.Type.Earth and type == Attack.Type.Lightning:
		return 0
	if type == Attack.Type.Lightning and they_digi.res.type == Attack.Type.Wind:
		return 2
	if they_digi.res.type == Attack.Type.Lightning and type == Attack.Type.Wind:
		return 0
	if type == Attack.Type.Wind and they_digi.res.type == Attack.Type.Earth:
		return 2
	if they_digi.res.type == Attack.Type.Wind and type == Attack.Type.Earth:
		return 0
	if they_digi.res.type == Attack.Type.Light and type == Attack.Type.Dark:
		return 2
	if type == Attack.Type.Light and they_digi.res.type == Attack.Type.Dark:
		return 2
	return 1
func grant_status(they_digi):
	var status = Attack.new()
	var dict = get_statuses(true)
	for key in dict.keys():
		status[key] = dict[key]
	var effect = Effect.new()
	effect.attack = status
	effect.turns_left = effect_lasts
	they_digi.effects.push_back(effect)
func get_desc():
	var string = ""
	if physical_power != 0:
		string += "[PHYS POW ("+var_to_str(physical_power)+")]"
	if magic_power != 0:
		string += "[MAGI POW ("+var_to_str(magic_power)+")]"
	if physical_penetration_power != 0:
		string += "[INT PEN ("+var_to_str(physical_penetration_power)+")]"
	if magic_penetration_power != 0:
		string += "[INT PEN ("+var_to_str(magic_penetration_power)+")]"
	if heals_for != 0:
		string += "[HEAL POW ("+var_to_str(heals_for)+")]"
	string+= get_statuses_desc()
	if breaks_with_weakness or grants_technical:
		if extra_break_time != 0:
			string += "[TIME BRK+ ("+var_to_str(extra_break_time)+")]"
		if grants_technical and technical_requirments:
			string+=technical_requirments.get_technical_desc()
		if breaks_with_weakness and type != Type.Neutral:
			string+= get_break_desc()
	return string
func get_technical_desc():
	var dict = get_statuses()
	var string = "[TECH ("
	for key in dict.keys():
		if dict[key]:
			string+= key.replace("assigns_","").replace("_"," ").to_upper()+","
	
	return string + ")]"
func get_break_desc():
	var string = "[BRKE ("+str(type)+")]"
func get_statuses_desc():
	var dict = get_statuses()
	
	var string = "[STATUS ("
	if assigns_random_bad:
		string += "{BAD STATUS @ RAND}"
	if assigns_random_good:
		string += "{GOOD STATUS @ RAND}"
	for key in dict.keys():
		if dict[key]:
			string+= key.replace("assigns_","").replace("_"," ").to_upper()+","
	return string + ")]"
func get_statuses(include_random = false)->Dictionary:
	var dict = {
		"assigns_all_charge":assigns_all_charge,
		"assigns_all_counter":assigns_all_counter,
		"assigns_all_sheild":assigns_all_sheild, 
		"assigns_endure":assigns_endure,
		"assigns_magic_counter":assigns_magic_counter,
		"assigns_magic_sheild":assigns_magic_sheild,
		"assigns_mind_charge":assigns_mind_charge,
		"assigns_phys_counter":assigns_phys_counter,
		"assigns_phys_sheild":assigns_phys_sheild,
		"assigns_power_charge":assigns_power_charge,
		"assigns_status_charge":assigns_status_charge,
		"assigns_status_counter":assigns_status_counter,
		"assigns_status_sheild":assigns_status_sheild,
		"assigns_stun":assigns_stun,
		"assigns_bug":assigns_bug,
		"assigns_confuse":assigns_confuse, 
		"assigns_dot":assigns_dot,
		"assigns_parylyze":assigns_parylyze,
		"assigns_sleep":assigns_sleep,
		"assigns_poison":assigns_poison,
	}
	if assigns_random_bad and include_random:
		dict = pick_random_bad(dict)
	if assigns_random_good and include_random:
		dict = pick_random_good(dict)
	return dict
static func pick_random_good(sta:Dictionary):
	var dict = {
		"assigns_random_good":0,
		"assigns_all_charge":1,
		"assigns_all_counter":2,
		"assigns_all_sheild":3, 
		"assigns_endure":4,
		"assigns_magic_counter":5,
		"assigns_magic_sheild":6,
		"assigns_mind_charge":7,
		"assigns_phys_counter":8,
		"assigns_phys_sheild":9,
		"assigns_power_charge":9,
		"assigns_status_charge":9,
		"assigns_status_counter":0,
		"assigns_status_sheild":2,
	}
	var number = 0
	for key in dict.keys():
		if sta[key]:
			number += 1
	var rand = randi_range(0,number)
	number = 0
	var true_key = ""
	for key in dict.keys():
		if sta[key]:
			number += 1
		if number == rand:
			true_key = key
			break
	for key in dict.keys():
		sta[key] = false
	sta[true_key] = true
	return sta
static func pick_random_bad(sta:Dictionary):
	var dict = {
		"assigns_stun":sta["assigns_stun"],
		"assigns_bug":sta["assigns_bug"],
		"assigns_confuse":sta["assigns_confuse"],
		"assigns_dot":sta["assigns_dot"],
		"assigns_parylyze":sta["assigns_parylyze"],
		"assigns_sleep":sta["assigns_sleep"],
		"assigns_poison":sta["assigns_poison"]
	}
	var number = 0
	for key in dict.keys():
		if sta[key]:
			number += 1
	var rand = randi_range(0,number)
	number = 0
	var true_key = ""
	for key in dict.keys():
		if sta[key]:
			number += 1
		if number == rand:
			true_key = key
			break
	for key in dict.keys():
		sta[key] = false
	sta[true_key] = true
	return sta
static func merge_statuses(sta1,sta2):
	var dict = {}
	for key in sta1:
		dict[key] = sta1[key] or sta2[key]
	return dict

enum Type {
	Fire,
	Grass,
	Water,
	Earth,
	Lightning,
	Wind,
	Light,
	Dark,
	Neutral
}
@export var desc:String = "A 100 accuracy Fire attack\nwith 10 magic, and 10 phys power"
@export var type:Type = Type.Neutral
@export var name:String = "Default"
@export_group("Points")
@export var accuracy:int = 100
@export var magic_power:int = 0
@export var physical_power:int = 0
@export var physical_penetration_power:int = 0
@export var magic_penetration_power:int = 0
@export var stamina_cost:int = 5
@export var heals_for:int = 0
@export_group("Press Turn")
@export var breaks_with_weakness = false
@export var grants_technical = false
@export var technical_requirments:Attack
@export var extra_break_time:int = 0

@export_group("Animation")
@export var animation_scene:PackedScene

@export_group("Multi Hit and Turn")
@export var is_multi_hit:bool = false
@export var next_hit:Attack
@export var stop_on_miss = false
@export var effect_lasts:int = 0 

@export_group("Target")
@export var hits_all_enemies = false
@export var hits_all_allies = false
@export var hits_self = false
@export var can_target_allies = false
@export var can_target_enemies = false
@export var can_target_self = false
@export_category("Misc")
@export_group("Harm Status")
@export var assigns_random_bad = false
@export var assigns_confuse = false
@export var assigns_parylyze = false
@export var assigns_stun = false
@export var assigns_sleep = false
@export var assigns_poison = false
@export var assigns_dot = false
@export var assigns_bug = false

@export_group("Good Status")
@export var assigns_random_good = false
@export var assigns_endure = false
@export var assigns_phys_sheild = false
@export var assigns_magic_sheild = false
@export var assigns_status_sheild = false
@export var assigns_all_sheild = false
@export var assigns_power_charge = false
@export var assigns_mind_charge = false
@export var assigns_status_charge = false
@export var assigns_all_charge = false
@export var assigns_phys_counter = false
@export var assigns_magic_counter = false
@export var assigns_status_counter = false
@export var assigns_all_counter = false
@export_group("Status Breaker")

@export var physical_shield_breaker =  false
@export var magic_shield_breaker = false
@export var status_shield_breaker = false
@export var all_shield_breaker = false
@export var physical_charge_breaker =  false
@export var magic_charge_breaker = false
@export var status_charge_breaker = false
@export var all_charge_breaker = false
@export var physical_counter_breaker =  false
@export var magic_counter_breaker = false
@export var status_counter_breaker = false
@export var all_counter_breaker = false
@export_group("Stat Change")
@export var enemy_atk = 0
@export var enemy_def = 0
@export var enemy_int = 0
@export var enemy_spd = 0
@export var ally_atk = 0
@export var ally_def = 0
@export var ally_int = 0
@export var ally_spd = 0
@export var ally_acu = 0
@export var ally_eva = 0
@export var ally_crt = 0
