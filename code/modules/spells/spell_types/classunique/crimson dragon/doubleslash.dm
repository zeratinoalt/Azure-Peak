/datum/action/cooldown/spell/doubleslash
	name = "Double Slash - Blast"
	desc = "Dash towards a target, cutting two times. \
		The second strike detonates a shell. \
		Strikes your aimed bodypart. Can be deflected by Defend stance. \
		Click after casting to start the combo."
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	button_icon_state = "doubleslash"
	sound = 'sound/foley/crimsondragon/draw.ogg'

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

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC | SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z

/datum/action/cooldown/spell/doubleslash/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon


	var/mob/living/victim
	if(isliving(cast_on))
		victim = cast_on
	if(victim == owner)
		return FALSE

	if(!istype(H))
		return FALSE

	if(H.is_holding(/obj/item/rogueweapon/sword/sabre/podao))
		if(length(held_weapon.current_ammo) >= 1)
			to_chat(H, span_warning("Out of shells, reload!"))
			return FALSE
	else 
		return FALSE
