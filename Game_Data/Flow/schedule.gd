extends Resource
class_name Schedule
@export var name:String = "NPC_"
@export var from_month:int = 4
@export var from_day:int = 12
@export var time: Game.TimeOfDay= Game.TimeOfDay.Morning
@export var to_month:int = 4
@export var to_day:int = 13
@export var child_schedule:Array[Schedule]
@export var message:MessageTree = null
@export var scene:PackedScene = null
@export var spawn_location:Node2D = null
@export_group("Conditions")
@export var spawn_if_function = ""
##Skips the message if the flag in the save data is true
@export_multiline var spawn_expression = ""
func check_spawn() -> bool:
	return Game.check_spawn(spawn_if_function,spawn_expression)
func spawn(node:Node2D):
	if Game.is_time_of_day(time)and( 
		Game.time_check_greater_than_or_equal(from_day,from_month) and 
		Game.time_check_less_than_or_equal(to_day,to_month)
		):
			if check_spawn():
				for schedule in child_schedule:
					schedule.spawn(node)
				if is_instance_valid(scene):
					var scene_instance = scene.instantiate()
					if  is_instance_valid(message):
						scene_instance.message = message
					node.add_child(scene_instance)
					if is_instance_valid(spawn_location):
						node.position =spawn_location.position
		
