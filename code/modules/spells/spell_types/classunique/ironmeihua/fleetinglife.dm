//deal raw burn damage to self to gain stamina/energy

/datum/action/cooldown/spell/fleetinglife
	button_icon = 'icons/mob/actions/classuniquespells/ironmeihua.dmi'
	name = "Fleeting Life"
	desc = "deal raw burn damage to self to gain stamina/energy"
	button_icon_state = "fleeting"
	spell_color = GLOW_COLOR_CRIMSON

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/magic/charging_fire.ogg'
	cooldown_time = 30 SECONDS


	associated_skill = /datum/skill/combat/unarmed
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

	click_to_activate = TRUE
	self_cast_possible = TRUE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = FALSE
	cooldown_time = 1 HOURS

	associated_skill = /datum/skill/combat/unarmed
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW

	spell_requirements =  SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	sound = 'sound/silence.ogg'

/datum/action/cooldown/spell/fleetinglife/cast(atom/cast_on)
	. = ..()
	var/mob/living/user = owner
	if(!istype(user))
		return FALSE

	user.visible_message(span_danger("[user] reaches out &clenches her fist - flames sparking across her body."))
	user.visible_message(span_danger("[user] looks to be in pain, yet her eyes light up with vigor!"))
	user.take_overall_damage(0, 60)
	playsound(user, 'sound/foley/ironmeihua/attack2.ogg', 80, FALSE)
	user.say("GHKH--!!")
	user.stamina = 0
	user.energy = user.max_energy
