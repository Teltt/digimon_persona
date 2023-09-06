extends Control
@onready var day = $Day
@onready var date = $Date
@onready var month = $Month
@onready var time = $TimeOfDay


func set_date(p_month,p_day):
	month.text = "[right]"+Game.get_month_from_number(p_month)
	day.text = "[right]"+Game.get_week_day(p_month,p_day)
	date.text = "[right]"+var_to_str(Game.convert_to_fake_month(p_month))+"/"+var_to_str(p_day)
	pass
func set_time(p_time):
	time.text ="[right]"+Game.TimeOfDay.keys()[p_time]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
