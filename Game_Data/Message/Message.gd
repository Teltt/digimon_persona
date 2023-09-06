extends Resource
class_name MessageTree

@export var is_digivolution_question = false
@export var line1:String = ""
@export var line2:String = ""
@export var line3:String = ""
## The next message by default, overrided by choices
@export var next_message :MessageTree = null
## The choices the player can make for this message
@export var choices : Array[MessageChoice] = []
## The Speaker name
@export var change_speaker = ""
## The file name of the portrait you want to use
@export var portrait_file_name = ""
@export_group("Function Calls")
##Names of the functions you want to call, make sure it is defined in GameNode.gd first
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
@export_group("Event Logic")
@export var seek_time = -1
@export var close_message_box = false
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
	Game.call_functions(function_names,self,"Message")
