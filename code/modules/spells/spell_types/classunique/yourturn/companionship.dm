/datum/action/cooldown/spell/companionship
	button_icon = 'icons/mob/actions/classuniquespells/yourturn.dmi'
	name = "Companionship"
	desc = "Create a crude imitation of companionship, which regularly spawns tendrils around it."
	button_icon_state = "companionship"
	sound = 'sound/foley/bleed_apply.ogg'
	spell_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	invocations = list("|..Comfort me, please.|")
	invocation_type = INVOCATION_SHOUT

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_drain = 1
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/magic/chargingblood.ogg'
	cooldown_time = 5.5 SECONDS

	associated_skill = /datum/skill/magic/blood
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

/datum/action/cooldown/spell/companionship/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
