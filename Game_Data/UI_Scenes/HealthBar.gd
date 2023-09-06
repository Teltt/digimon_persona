extends ProgressBar
@onready var health_label = $Health
@onready var beat_label = $Beats
@onready var max_health:int = get_parent().res.stats.HP +  str_to_var(get_parent().res.stats.growth_HP)* get_parent().res.level
@onready var health = get_parent().res.starting_health:
	set(valu):
		health = valu
		health_label.text = var_to_str(value)
@onready var STALL = get_parent().res.stats.STALL
@onready var hp_per_stall:float = 0:
	set(valu):
		hp_per_stall = valu
		beat_label.text = str(stalls_left)+":"+str(hp_per_stall) 
@onready var stalls_left = 0:
	set(valu):
		stalls_left = valu
		beat_label.text = str(stalls_left)+":  "+str(hp_per_stall) 
@onready var hp_left = 0
var not_total = false
@onready var hp_total_change:float = 0:
	set(valu):
		hp_total_change = valu
		
		hp_left = valu
		if not not_total:
			hp_per_stall = ((valu+2)/STALL)+1*signi(hp_total_change)
			stalls_left = STALL
# Called when the node enters the scene tree for the first time.
func _ready():
	health = health
	max_value = max_health
	value = health
	EventBus.beat_timeout.connect(on_beat_hit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func on_beat_hit():
	if stalls_left > 0:
		stalls_left -= 1
		health = clamp(health+hp_per_stall,0,max_health)
		not_total = true
		hp_total_change -= hp_per_stall
		not_total = false
		value = health
		if health == 0:
			##got hurt and collapsed msg
			pass
		elif health == max_health:
			stalls_left = 0
			hp_left = 0
			
	pass
