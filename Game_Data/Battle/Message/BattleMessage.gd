extends Resource
class_name BattleMessage


@export var close_message_box = false
@export var actor:Node
@export var attack: Attack
@export var time:int = 15
@export var drain:int = 7

## Key: Mood, Value Participant
@export var participants:ParticipantDictionary = ParticipantDictionary.new()
@export var line1:String = ""
@export var line2:String = ""
@export var line3:String = ""
@export var emits_virtues :Array[String]
@export_group("SucessandFailure")
## The next message by default, overrided by choices
@export var virtue_response :DictionaryVirtueMessage = DictionaryVirtueMessage.new()
@export var dont_care_message :BattleMessage = null
@export var loops = false
@export_group("Function Calls")
@export var function_names :Array[String]
## if this function returns false skip
@export var skip_function = ""
@export_group("Flags")
##Skips the message if the this expression is true
@export_multiline var skip_expression : String
##Sets a flag to the result of the expression STRING
@export var set_flag_dictionary : Dictionary
##Sets a counter to the result of the INT
@export var set_counter_dictionary : Dictionary 
##Increments counter to by the INT
@export var increment_counter_dictionary : Dictionary
func check_skip() -> bool:
	return Game.check_skip(skip_function,skip_expression)
func set_flags():
	for flag in set_flag_dictionary.keys():
		Game.data.flags[flag] = Game.evaluate_expression(set_flag_dictionary[flag])
	for counter in set_counter_dictionary:
		Game.data.counters[counter] = set_counter_dictionary[counter]
	for counter in increment_counter_dictionary:
		Game.data.counters[counter] += increment_counter_dictionary[counter]
func call_functions():
	Game.call_functions(function_names,self,"Choice")

