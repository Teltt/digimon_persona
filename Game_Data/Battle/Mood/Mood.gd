extends Resource
class_name Mood
@export var moods :Array[Mood]
@export var messages :Array[BattleMessage]
@export var applies_to_who:Array[ResActor]
@export var mood_name = "Default"
@export var is_main = false
@export_group("Limits")
@export var per_battle = -1
@export var per_day = -1
@export var per_save = -1
@export var delay = 0
@export_subgroup("Appearances")
var appeared_battle:int = 0
var appeared_day:int = 0
var appeared_save:int = 0
@export_subgroup("Tries")
@export var tries_battle_again = false
@export var tried_battle = 0
@export var tried_battle_until_appear = 0
@export var tries_day_again = false
@export var tried_day = 0
@export var tried_day_until_appear = 0
@export var tries_save_again = false
@export var tried_save = 0
@export var tried_save_until_appear = 0
@export_group("Conditions")
@export_subgroup("Appears")
@export var at_low_partner_health = false
@export var at_partner_hungry = false
@export var regularly = true
@export var at_high_partner_health = false
@export var at_partner_full= false
@export var at_party_low_morale= false
@export var at_party_high_morale= false
@export var at_general_low_health= false
@export var at_general_high_health= false
@export var at_general_hunger_health= false
@export_subgroup("Time")
@export var from_month:int = 4
@export var from_day:int = 12
@export var to_month:int = 4
@export var to_day:int = 11
@export_subgroup("Spawn")
@export var spawn_if_function = ""
##Spawns the mood if the flag in the save data is true
@export_multiline var spawn_expression = ""
func check_spawn() -> bool:
	if is_main:
		return true
	var can_spawn = Game.check_spawn(spawn_if_function,spawn_expression)
	var time_period_correct =( 
		Game.time_check_greater_than_or_equal(from_day,from_month) and 
		Game.time_check_less_than_or_equal(to_day,to_month)
		)
	if per_battle > -1 and tried_battle >= per_battle:
		can_spawn = false
	if per_day > -1 and tried_day >= per_day:
		can_spawn =  false
	if per_save > -1 and tried_save >= per_save:
		can_spawn =  false
	tried_battle += 1
	tried_day += 1
	tried_save += 1
	if tried_battle < tried_battle_until_appear:
		can_spawn = false
	if tried_day < tried_day_until_appear:
		can_spawn = false
	if tried_save < tried_save_until_appear:
		can_spawn = false
	if tries_battle_again and tried_battle > tried_battle_until_appear:
		tried_battle = 0
	if tries_day_again and tried_day > tried_day_until_appear:
		tried_day = 0
	if tries_save_again and tried_save > tried_save_until_appear:
		tried_save = 0
	if tried_battle > tried_battle_until_appear:
		can_spawn = false
	if tried_day > tried_day_until_appear:
		can_spawn = false
	if tried_save > tried_save_until_appear:
		can_spawn = false
	if can_spawn and time_period_correct:
		appeared_battle += 1
		appeared_day += 1
		appeared_save += 1
	return can_spawn and time_period_correct
func spawn():
	if check_spawn():
		return self
	else:
		return null
