extends Node
func check_yolei_bond(msg:MessageTree):
	var change :String= Game.data.yolei_bond.check()
	Game.replace_in_msg(msg,"<sl_msg>",change)
func yolei_hangout(_msg):
	Game.data.yolei_bond.hang_out()
func yolei_affection_weak(_msg):
	Game.data.yolei_bond.raise_affinity()
func yolei_affection_strong(_msg):
	Game.data.yolei_bond.raise_affinity()
func yolei_rankup_love(_msg):
	Game.data.yolei_bond.rank_up(Game.data.sora_bond)
