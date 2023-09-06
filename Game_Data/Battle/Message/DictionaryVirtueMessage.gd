extends Resource
class_name DictionaryVirtueMessage
@export var dictionary:Array[VirtueMessage] = []
func get_by_virtue(virtue):
	for item in dictionary:
		if virtue == item.virtue:
			return item
	{}[virtue]= "x"
func set_by_virtue(virtue ,value):
	for i in dictionary.size():
		var item = dictionary[i]
		if virtue == item.virtue:
			dictionary[i] =value
			return
	dictionary.push_back(value)
	return
func virtue_in(virtue):
	for item in dictionary:
		if virtue == item.virtue:
			return true
	return false
