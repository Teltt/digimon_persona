extends Resource

class_name ParticipantDictionary
@export var dictionary : Array[Participant] 
func get_by_file(file):
	var path = file.resource_path
	for item in dictionary:
		if path == item.mood:
			return item
	{}[path]= "x"
func set_by_file(file,value):
	var path = file.resource_path
	for i in dictionary.size():
		var item = dictionary[i]
		if path == item.mood:
			value.mood = path
			dictionary[i] =value
			return
	dictionary.push_back(value)
	return
func get_by_identifier(identifier):
	for item in dictionary:
		if identifier == item.identifier:
			return item
	{}[identifier] = "x"
func identifier_in(identifier):
	for item in dictionary:
		if identifier == item.identifier:
			return true
	return false
func set_by_identifier(identifier,value):
	for i in dictionary.size():
		var item = dictionary[i]
		if identifier == item.identifier:
			value.identifier = identifier
			dictionary[i] =value
			return
	dictionary.push_back(value)
	return
func get_by_actor(actor):
	for item in dictionary:
		if actor == item.actor:
			return item
	{}[actor]= "x"
func set_by_actor(actor,value):
	for i in dictionary.size():
		var item = dictionary[i]
		if actor == item.actor:
			value.actor = actor
			dictionary[i] =value
			return
	dictionary.push_back(value)
	return
func get_by_path(path):
	for item in dictionary:
		if path == item.mood:
			return item
	{}[path]= "x"
func set_by_path(path,value):
	for i in dictionary.size():
		var item = dictionary[i]
		if path == item.mood:
			value.mood = path
			dictionary[i] =value
			return
	dictionary.push_back(value)
	return
