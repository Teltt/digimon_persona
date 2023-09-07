@tool
extends Node
var sorters :Array[Sorter]
func _process(_delta):
	var i = 0
	while i <sorters.size():
		if not is_instance_valid(sorters[i]):
			
			sorters.remove_at(i)
			continue
		else:
			i+=1
	sorters.sort_custom(Sorter.compare_to_point)
	for s in sorters.size():
		sorters[s].parent.z_index = sorters.size()-s
	pass
