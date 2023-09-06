extends Resource
class_name SceneScheduler
@export var schedules:Array[Schedule]

func spawn(node:Node2D):
	for schedule in schedules:
		schedule.spawn(node)
