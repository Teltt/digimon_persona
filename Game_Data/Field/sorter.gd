@tool
extends Line2D
class_name Sorter
var y_sort_point
var parent:Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	y_sort_point = $YSortPoint.position
	organizePoints()
	parent = get_parent()
	if self not in SorterGlobal.sorters:
		SorterGlobal.sorters.push_back(self)
	pass # Replace with function body.
	if not Engine.is_editor_hint():
		set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
static func compare_to_point(sortera:Sorter,sorterb:Sorter):
	for i in sortera.points.size():
		var i2 = i+1
		if i2 >= sortera.points.size():
			break
		var line1 = sortera.to_global(sortera.points[i])
		var line2 = sortera.to_global(sortera.points[i2])
		var is_first = i == 0
		var is_last = i2 == sortera.points.size()-1
		var ret = isPointAboveOrBelowLine(sorterb.to_global(sorterb.y_sort_point),line1,line2)
		if is_first and ret["lesser"]:
			return ret["above"]== -1
		if is_last and ret["greater"]:
			return ret["above"]== -1
		if not ret["greater"] and not ret["lesser"]:
			return ret["above"] == -1
		
static func calculateLineSlopeAndYIntercept(point1: Vector2, point2: Vector2):
	var slope = (point2.y - point1.y) / (point2.x - point1.x)
	var y_intercept = point1.y - slope * point1.x
	return [slope, y_intercept]
	
func organizePoints():
	var p:Array = points
	p.sort_custom(func(a,b):
		if a.x < b.x:
			return true
		else:
			return false
			)
	set_points(p)

static func isPointAboveOrBelowLine(point: Vector2, line1:Vector2,line2:Vector2):
	var ret = calculateLineSlopeAndYIntercept(line1,line2)
	var x = point.x
	var value = {
	}
	x = clamp(x,line1.x,line2.x)
	value["greater"]= x >= line2.x
	value["lesser"]= x <= line1.x
	var expectedY = ret[0] * x + ret[1]
	if abs(point.y - expectedY) < 0.1:
		value["above"] = -1
	elif point.y > expectedY:
		value["above"] = 1
	elif point.y < expectedY:
		value["above"] = -1
	return value
