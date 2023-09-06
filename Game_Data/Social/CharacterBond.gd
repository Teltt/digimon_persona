extends Resource
class_name CharacterBond
@export var character_name = "Default"
@export var max_level:int = 7
@export var crest_name: String
@export_group("Arrays")
@export var requirements :Array[int]
@export var rankup_events :Array[PackedScene]
@export var hangout_events :Array[PackedScene]
var level:Array[int] = [0,0]
var affinity:int =0
var broken = false
var reversed = false
func raise_affinity(multi_plier = 1.0):
	affinity += 2* multi_plier
func check():
	var i_level = level[0]+level[1]
	if i_level >= 0 and i_level <requirements.size():
		if affinity >=requirements[i_level]:
			return  "and you will grow closer soon."
		else:
			return  "and you won't grow closer yet."
	if i_level ==requirements.size():
		return "and you are best friends."
	if broken:
		return "is done with you."
	if reversed:
		return "is angry with you."
func hang_out():
	var i_level = level[0]+level[1]
	if i_level >=0  and i_level <requirements.size():
		if check() == "and you will grow closer soon.":
			if i_level >= 0 and i_level <rankup_events.size():
				var event =rankup_events[i_level]
				if is_instance_valid(event):
					Game.main.load_new_event(event)
					return
				else:
					print("Null rankup event")
		else:
			print("invalid rankup event level")
	if i_level >= 0 and i_level <hangout_events.size():
		if check() != "is done with you.":
			var event =hangout_events[i_level]
			if is_instance_valid(event):
				Game.main.load_new_event(event)
			else:
				print("Null hangout event")
	else:
		print("invalid hangout event level")
func rank_up(pair:CharacterBond = null):
	
	var rank = 0
	var rankup_crest = crest_name
	if is_instance_valid(pair):
		# if the crest name can split, this person has 2
		var crests = crest_name.split(":")
		var pair_crests = pair.crest_name.split(":")
		if crests.size() > 1:
			# find the crest that equals the pair
			var pair_found = false
			for crest_i in crests.size():
				var crest = crests[crest_i]
				for pair_crest_i in pair_crests.size():
					var pair_crest = pair_crests[pair_crest_i]
					if crest == pair_crest:
						rankup_crest = crest
						rank = level[crest_i] +pair.level[crest_i]+1
						level[crest_i]+= 1
						level[crest_i] = clampi(level[crest_i],0,max_level)
						pair_found = true
				if pair_found:
					break
			if not pair_found:
				print("error crest pair not found")
	else:
		rank = level[0]+1
		level[0]+= 1
		level[0] = clampi(level[0],0,max_level)
	Game.main.rank_up.fade_in(rank,rankup_crest,character_name)
	affinity = 0
