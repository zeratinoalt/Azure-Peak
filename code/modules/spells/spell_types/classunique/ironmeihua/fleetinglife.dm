//deal raw burn damage to self to gain stamina/energy

/datum/action/cooldown/spell/fleetinglife
	button_icon = 'icons/mob/actions/classuniquespells/ironmeihua.dmi'
	name = "Raging Storm"
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

	associated_skill = /datum/skill/magic/unarmed
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW

	spell_requirements =  SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z


/datum/action/cooldown/spell/fleetinglife/cast(atom/cast_on)
	. = ..()
	var/mob/living/user = owner
	if(!istype(user))
		return FALSE

	H.visible_message(span_danger("[H] reaches out &clenches her fist - flames sparking across her body."))
	H.visible_message(span_danger("[H] looks to be in pain, but her eyes are alight with vigor!"))
	user.adjust_fire_stacks(2, /datum/status_effect/fire_handler/fire_stacks)
	playsound(H, 'sound/foley/ironmeihua/hurt2.ogg', 80, TRUE)
	user.stamina = 0
	user.energy = user.max_energy
