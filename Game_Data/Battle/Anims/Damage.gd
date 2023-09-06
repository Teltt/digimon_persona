extends Task
class_name DamageTask
@export var damage:int =0:
	set(value):
		damage = value
		$Label.text = var_to_str(value)+"!"

func play(me_digi,they_digi):
	they_digi.add_child(self)
	await get_tree().process_frame
	damage = they_digi.health_bar.hp_total_change
	super(me_digi,they_digi)
	await finished
	queue_free()
