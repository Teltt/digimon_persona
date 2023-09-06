extends Node
var data:SaveData = SaveData.new()
var field = null
var main = null
var awaiting = false
enum Digivolution_Level {
	Baby,
	Intraining,
	Rookie,
	Champion,
	Ultimate,
	Mega,
	SuperUltimate,
	ModeChange
}
##TIME
enum TimeOfDay {
	EarlyMorning,
	Morning,
	School,
	Noon,
	AfterSchool,
	AfterNoon,
	BeforeEvening,
	Evening,
	Night,
	LateNight,
}
const time_of_day_dictionary = {
	TimeOfDay.EarlyMorning : "Early-Morning",
	TimeOfDay.Morning : "Morning",
	TimeOfDay.School : "School",
	TimeOfDay.Noon : "Noon",
	TimeOfDay.AfterSchool : "After-School",
	TimeOfDay.AfterNoon : "After-Noon",
	TimeOfDay.BeforeEvening : "Before-Evening",
	TimeOfDay.Evening : "Evening",
	TimeOfDay.Night : "Night",
	TimeOfDay.LateNight : "LateNight",
}
const actual_days_in_month_dictionary = {
	1:  30,
	2: 31,
	3:  30,
	4: 31,
	5:  30,
	6: 31,
	7:  30,
	8: 31,
	9:  30,
	10: 31,
	11: 28,
	12: 31,
	13: 30,
}
const days_in_month_dictionary = {
	1:  30,
	2: 31,
	3:  30,
	4: 31,
	5:  30,
	6: 31,
	7:  30,
	8: 31,
	9:  30,
	10: 31,
	11: 28,
	12: 31,
	13: 30,
}
const month_dictionary = {
	1:  "April",
	2: "May",
	3:  "June",
	4: "July",
	5:  "August",
	6: "September",
	7: "October",
	8: "November",
	9:  "December",
	10: "January",
	11: "Febuary",
	12: "March",
	13: "April",
}
const weekday_dictionary ={
	0:"Monday",
	1:"Tuesday",
	2:"Wednesday",
	3:"Thursday",
	4:"Friday",
	5:"Saturday",
	6:"Sunday"
}
func get_time_string(p_time):
	return time_of_day_dictionary[p_time]
func get_week_day(p_month,p_day):
	var day_number = p_day
	for i in range(1,p_month):
		day_number+=actual_days_in_month_dictionary[i]
	return weekday_dictionary[day_number%7]
func get_month_from_number(p_month):
	return month_dictionary[p_month]
func is_time_of_day(time):
	return data.time == time
func convert_to_actual_month(month,day):
	var actual_month = month -3
	if day < 12 and actual_month == 1:
		return 13
	if actual_month < 1:
		actual_month+=12
	return actual_month
func convert_to_fake_month(month):
	var fake_month= wrap((month+3),1,13)
	return fake_month
func time_check_greater_than(from_day,from_month):
	var month = convert_to_actual_month(data.month,data.day)
	var m_from_month =  convert_to_actual_month(from_month,from_day)
	return month > m_from_month and data.day > from_day
func time_check_greater_than_or_equal(from_day,from_month):

	var month = convert_to_actual_month(data.month,data.day)
	var m_from_month =  convert_to_actual_month(from_month,from_day)
	return month >= m_from_month and data.day >= from_day
func time_check_less_than(from_day,from_month):

	var month = convert_to_actual_month(data.month,data.day)
	var m_from_month =  convert_to_actual_month(from_month,from_day)
	return month < m_from_month and data.day < from_day
func time_check_less_than_or_equal(from_day,from_month):

	var month = convert_to_actual_month(data.month,data.day)
	var m_from_month =  convert_to_actual_month(from_month,from_day)
	return month <= m_from_month and data.day <= from_day
func time_check_equal(from_day,from_month):

	var month = convert_to_actual_month(data.month,data.day)
	var m_from_month =  convert_to_actual_month(from_month,from_day)
	return month == m_from_month and data.day == from_day
func time_check_not_equal(from_day,from_month):

	var month = convert_to_actual_month(data.month,data.day)
	var m_from_month =  convert_to_actual_month(from_month,from_day)
	return month != m_from_month and data.day != from_day
func progress_date_normally(_msg):
	main.progress_date(1)
	main.load_new_field(load("res://Game_Data/Field/field_bedroom.tscn"))
	
	await(Game.main.load_fade.loaded)
	main.mc.global_position = main.field.get_node("Default_MC_Pos").global_position
	main.camera.position = main.mc.position

##Field Transition
func transition_to_bedroom(_msg):
	main.change_time(TimeOfDay.Evening)
	main.load_new_field(load("res://Game_Data/Field/field_bedroom.tscn"))
	
	await(Game.main.load_fade.loaded)
	
	main.mc.global_position = main.field.get_node("Default_MC_Pos").global_position
	main.camera.position = main.mc.position

##Misc
func close_msg(_msg):
	main.msg_box.close()
	await(main.msg_box.anim_player.animation_finished)
func check_spawn(function_check,expression) -> bool:
	var ret = true
	ret = try_function_call(function_check,
	self,"this spawn function doesn't exist")
	var flag_test = evaluate_expression(expression,true)
	if flag_test and ret:
		return true
	return false
func check_skip(function_check,expression) -> bool:
	var ret = true
	ret = try_function_call(function_check,
	self,"this skip function doesn't exist")
	var flag_test = evaluate_expression(expression,false)
	if flag_test or not ret:
		return false
	return true
func replace_in_msg(msg:MessageTree,replace:String,change:String):
	
	var new_msg = msg.duplicate()
	new_msg.line1=new_msg.line1.replace(replace,change)
	new_msg.line2=new_msg.line2.replace(replace,change)
	new_msg.line3=new_msg.line3.replace(replace,change)
	main.msg_box.current_message = new_msg
func call_functions(func_array,object,debug = "object"):
	for i in func_array.size():
		var func_str = func_array[i]
		try_function_call(func_str,object,"function "+ var_to_str(i)+ " of this "+debug+" doesn't exist, please define it!" )
func try_function_call(func_str,object,debug, ret = true):
	if not func_str.is_empty():
		if Game.has_method(func_str):
			ret = Game.call(func_str,object)
		elif Social.has_method(func_str):
			ret = Social.call(func_str,object)
		else:
			print(debug)
	return ret



func tokenize(expression: String) -> Array:
	var tokens = []
	var current_token = ""
	
	for char in expression:
		if char == " ":
			if current_token != "":
				tokens.append(current_token)
				current_token = ""
		elif char == "(" or char == ")":
			if current_token != "":
				tokens.append(current_token)
				current_token = ""
			tokens.append(char)
		else:
			current_token += char
	
	if current_token != "":
		tokens.append(current_token)
	
	return tokens
func evaluate_expression(expression: String,default = true) -> bool:
	var tokens = tokenize(expression)

	var postfix = []
	var operator_stack = []

	for token in tokens:
		if token in ["&&", "||"]:
			while operator_stack.size() > 0 and operator_stack[-1] != "(":
				postfix.append(operator_stack.pop_back())
			operator_stack.append(token)
		elif token == "(":
			operator_stack.append(token)
		elif token == ")":
			while operator_stack.size() > 0 and operator_stack[-1] != "(":
				postfix.append(operator_stack.pop_back())
			operator_stack.pop_back()  
		else:
			postfix.append(token)

	while operator_stack.size() > 0:
		postfix.append(operator_stack.pop_back())

	var value_stack = []

	for token in postfix:
		if token in ["&&", "||"]:
			var b = value_stack.pop_back()
			var a = value_stack.pop_back()
			if token == "&&":
				value_stack.append(a && b)
			else:
				value_stack.append(a || b)
		else:
			if token == "true":
				value_stack.append(true)
			elif token == "false":
				value_stack.append(false)
			elif token in data.flags:
				value_stack.append(data.flags[token])
			else:
				print("are you sure flag:"+data.flags[token]+" exists?")
	if value_stack.size() == 1:
		return value_stack[0]
	else:
		return default

