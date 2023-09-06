extends Node
var battle
static func get_damage(atk:Digimon,def:Digimon,attack:Attack):
	var atk_stats:Stats= atk.res.stats
	var def_stats:Stats = def.res.stats
	var damage = 0
	var atk_has_stat_sheild = false
	var atk_has_power_charge = false
	var atk_has_mind_charge = false
	var atk_has_status_charge = false
	var atk_has_all_charge = false
	for eff in atk.effects:
		var effect = eff.attack
		if effect.assigns_status_sheild or effect.assigns_all_sheild:
			atk_has_stat_sheild = true
		if effect.assigns_power_charge or effect.assigns_all_charge:
			atk_has_power_charge = true
		if effect.assigns_mind_charge or effect.assigns_all_charge:
			atk_has_mind_charge= true
		if effect.assigns_status_charge or effect.assigns_all_charge:
			atk_has_status_charge= true
		if effect.assigns_all_charge:
			atk_has_all_charge= true
	var def_has_stat_sheild = false
	var def_has_power_charge = false
	var def_has_mind_charge = false
	var def_has_status_charge = false
	var def_has_all_charge = false
	for eff in def.effects:
		var effect = eff.attack
		if effect.assigns_status_sheild or effect.assigns_all_sheild:
			def_has_stat_sheild = true
		if effect.assigns_power_charge or effect.assigns_all_charge:
			def_has_power_charge= true
		if effect.assigns_mind_charge or effect.assigns_all_charge:
			def_has_mind_charge= true
		if effect.assigns_status_charge or effect.assigns_all_charge:
			def_has_status_charge= true
		if effect.assigns_all_charge:
			def_has_all_charge= true
	## Stat Calculations
	var a_ATK = atk_stats.ATK + (
	(atk.res.level-1)*str_to_var(atk_stats.growth_ATK)
	)
	var a_INT = atk_stats.INT + (
	(atk.res.level-1)*str_to_var(atk_stats.growth_INT)
	)
	var a_DEF = atk_stats.DEF + (
	(atk.res.level-1)*str_to_var(atk_stats.growth_DEF)
	)
	for effect in atk.effects:
		if effect.cast_by_ally:
			var multiplier = 2.0 if atk_has_status_charge else 1.0
			a_ATK += effect.attack.ally_atk*multiplier
			a_INT += effect.attack.ally_int*multiplier
			a_DEF += effect.attack.ally_def*multiplier
		if not effect.cast_by_ally and not atk_has_stat_sheild:
			var multiplier = 2.0 if atk_has_status_charge else 1.0
			a_ATK += effect.attack.enemy_atk*multiplier
			a_INT += effect.attack.enemy_int*multiplier
			a_DEF += effect.attack.enemy_def*multiplier
	var d_ATK = def_stats.ATK + (
	(atk.res.level-1)*str_to_var(atk_stats.growth_ATK)
	)
	var d_INT = def_stats.INT + (
	(def.res.level-1)*str_to_var(def_stats.growth_INT)
	)
	var d_DEF = def_stats.DEF + (
	(def.res.level-1)*str_to_var(def_stats.growth_DEF)
	)
	for effect in def.effects:
		if effect.cast_by_ally:
			var multiplier = 2.0 if def_has_status_charge else 1.0
			d_ATK += effect.attack.ally_atk*multiplier
			d_INT += effect.attack.ally_int*multiplier
			d_DEF += effect.attack.ally_def*multiplier
		if not effect.cast_by_ally and not def_has_stat_sheild:
			var multiplier = 2.0 if def_has_status_charge else 1.0
			d_INT += effect.attack.enemy_int*multiplier
			d_ATK += effect.attack.enemy_atk*multiplier
			d_DEF += effect.attack.enemy_def*multiplier
	## Physical_damage
	var power_charge_multiplier = 2.0 if atk_has_power_charge else 1.0
	var phys_damage:int = ((a_ATK * attack.physical_power/d_DEF)+attack.physical_penetration_power)*power_charge_multiplier
	## Magic damage
	var mind_charge_multiplier = 2.0 if atk_has_mind_charge else 1.0
	var mag_damage:int = ((a_INT * attack.magic_power *1.5/d_INT)+attack.magic_penetration_power)*mind_charge_multiplier
	for eff in def.effects:
		var effect = eff.attack
		if effect.assigns_phys_sheild or effect.assigns_all_sheild:
			phys_damage = clamp(phys_damage,0,30*power_charge_multiplier)
		if effect.assigns_magic_sheild or effect.assigns_all_sheild:
			mag_damage = clamp(mag_damage,0,30*mind_charge_multiplier)
	damage = phys_damage +mag_damage
	if atk.res.type == Attack.Type.Fire and def.res.type == Attack.Type.Grass:
		damage *= 1.5
	if def.res.type == Attack.Type.Fire and atk.res.type == Attack.Type.Grass:
		damage = 0.75
	if atk.res.type == Attack.Type.Grass and def.res.type == Attack.Type.Water:
		damage *= 1.5
	if def.res.type == Attack.Type.Grass and atk.res.type == Attack.Type.Water:
		damage = 0.75
	if atk.res.type == Attack.Type.Water and def.res.type == Attack.Type.Fire:
		damage *= 1.5
	if def.res.type == Attack.Type.Water and atk.res.type == Attack.Type.Fire:
		damage = 0.75
		
	if atk.res.type == Attack.Type.Earth and def.res.type == Attack.Type.Lightning:
		damage *= 1.5
	if def.res.type == Attack.Type.Earth and atk.res.type == Attack.Type.Lightning:
		damage = 0.75
	if atk.res.type == Attack.Type.Lightning and def.res.type == Attack.Type.Wind:
		damage *= 1.5
	if def.res.type == Attack.Type.Lightning and atk.res.type == Attack.Type.Wind:
		damage = 0.75
	if atk.res.type == Attack.Type.Wind and def.res.type == Attack.Type.Earth:
		damage *= 1.5
	if def.res.type == Attack.Type.Wind and atk.res.type == Attack.Type.Earth:
		damage = 0.75
	if def.res.type == Attack.Type.Light and atk.res.type == Attack.Type.Dark:
		damage *= 1.5
	if atk.res.type == Attack.Type.Light and def.res.type == Attack.Type.Dark:
		damage *= 1.5
	return damage
static func apply_attack_from_ally(me_digi,attack):
	var battle = Game.main.get_node("Battle")
	var targetted_self = false
	var targetted_target = false
	if battle.target == me_digi and attack.can_target_self:
		attack.apply(me_digi,me_digi)
		targetted_self = true
	if battle.targetting_ally and attack.can_target_allies:
		attack.apply(me_digi,battle.target)
		targetted_target = true
	if not battle.targetting_ally and attack.can_target_enemies:
		attack.apply(me_digi,battle.target)
		targetted_target = true
	if attack.hits_all_enemies:
		for i in min(battle.enemy_digimon.size(),2):
			var targ = battle.enemy_digimon[i]
			if not battle.targetting_ally and targetted_target and targ == battle.target:
				continue
			if targ == me_digi and attack.hits_self == false:
				continue
			if targ == me_digi and targetted_self:
				continue
			attack.apply(me_digi,targ)	
	if attack.hits_all_allies:
		for i in min(battle.ally_digimon.size(),2):
			var targ = battle.ally_digimon[i]
			if battle.targetting_ally and targetted_target and targ == battle.target:
				continue
			if targ == me_digi and attack.hits_self == false:
				continue
			if targ == me_digi and targetted_self:
				continue
			attack.apply(me_digi,targ)	
static func apply_attack_from_enemy(me_digi,attack,target,targetting_ally):
	var battle = Game.main.get_node("Battle")
	var targetted_self = false
	var targetted_target = false
	if target == me_digi and attack.can_target_self:
		attack.apply(me_digi,me_digi)
		targetted_self = true
	if targetting_ally and attack.can_target_allies:
		attack.apply(me_digi,target)
		targetted_target = true
	if not targetting_ally and attack.can_target_enemies:
		attack.apply(me_digi,target)
		targetted_target = true
	if attack.hits_all_enemies:
		for i in min(battle.ally_digimon.size(),2):
			var targ = battle.ally_digimon[i]
			if not targetting_ally and targetted_target and targ == target:
				continue
			if targ == me_digi and attack.hits_self == false:
				continue
			if targ == me_digi and targetted_self:
				continue
			attack.apply(me_digi,targ)	
	if attack.hits_all_allies:
		for i in min(battle.enemy_digimon.size(),2):
			var targ = battle.enemy_digimon[i]
			if targetting_ally and targetted_target and targ == target:
				continue
			if targ == me_digi and attack.hits_self == false:
				continue
			if targ == me_digi and targetted_self:
				continue
			attack.apply(me_digi,targ)	
