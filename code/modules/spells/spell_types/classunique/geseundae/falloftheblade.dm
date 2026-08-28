
/datum/action/cooldown/spell/falloftheblade
	name = "Fall of the Blade"
	desc = "tankbuster aoe lol"
	button_icon = 'icons/mob/actions/classuniquespells/geseundae.dmi'
	button_icon_state = "falloftheblade"
	sound = 'sound/foley/geseundae/drawspecial.ogg'

	cast_range = 15

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_SB_MOBILITY

	invocations = list()
	invocation_type = INVOCATION_SHOUT

	charge_required = TRUE
	weapon_cast_penalized = FALSE
	charge_time = CHARGETIME_POKE
	charge_drain = 0
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = null
	cooldown_time = 15 SECONDS
	spell_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_VERY_HIGH

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW
	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 300
	var/deflected = FALSE
