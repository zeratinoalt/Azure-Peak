// 8x1 vertical slashes that alternate
//use anchor objs for the attack plotting


/datum/action/cooldown/spell/slashseries
	button_icon = 'icons/mob/actions/classuniquespells/yourturn.dmi'
	name = "Slash Series"
	desc = "Spawn copies of yourself at the top of the arena, which make alternating slashes in an 8x1 tile range."
	button_icon_state = "companionship"
	sound = 'sound/foley/geseundae/drawspecial.ogg'

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_SB_MOBILITY

	invocations = list("...I shall cut them down... 'ere I am devoured.")
	invocation_type = INVOCATION_SHOUT

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_drain = 1
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/foley/geseundae/drawloop.ogg'
	cooldown_time = 5.5 SECONDS

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

