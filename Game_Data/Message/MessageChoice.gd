extends Resource
class_name MessageChoice

@export var is_digivolution_answer = false
@export var digivolution_level :Game.Digivolution_Level = Game.Digivolution_Level.Baby 
@export var text :String
@export var next_message :MessageTree
@export_group("Function Calls")
##Name of the function you want to call, make sure it is defined in GameNode.gd first
@export var function_names :Array[String] = [] 
## if this function returns false skip
@export var skip_function = ""
@export_group("Save_Data")
##Skips the message if the this expression is true
@export_multiline var skip_expression : String
##Sets a flag to the result of the expression STRING
@export var set_flag_dictionary : Dictionary = {}
##Sets a counter to the result of the INT
@export var set_counter_dictionary : Dictionary = {}
##Increments counter to by the INT
@export var increment_counter_dictionary : Dictionary = {}
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
	Game.call_functions(function_names,self,"Choice")
