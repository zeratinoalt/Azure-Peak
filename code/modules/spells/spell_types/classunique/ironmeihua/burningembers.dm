//multi-slash attack 1, mass debuff

/datum/action/cooldown/spell/burningembers
	name = "Blasting Scatterslash"
	desc = "tankbuster lol"
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
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = null
	cooldown_time = 15 SECONDS
	spell_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_VERY_HIGH

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW
	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 80
	var/deflected = FALSE

/datum/action/cooldown/spell/burningembers/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)
	origin.Beam(owner, "meihua", time = 2)
	playsound(owner, 'sound/foley/ironmeihua/dash.ogg', 100, FALSE)

/datum/action/cooldown/spell/burningembers/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()

	var/mob/living/victim
	if(isliving(cast_on))
		victim = cast_on
	if(victim == owner)
		return FALSE

	if(!istype(H))
		return FALSE

	if(!istype(held_weapon, /obj/item/rogueweapon/sword/sabre/meihua))
		to_chat(H, span_warning("I need my sword for this move."))
		return FALSE

	var/throwtarget = get_edge_target_turf(H, get_dir(H, get_step_away(victim, H)))
	var/turf/lei_turf = get_turf(H)


	H.visible_message(span_userdanger("[H] is about to use a TANKBUSTER on [victim], BUFF THE TANK!!!"))

	new /obj/effect/temp_visual/crim_dragon/warning/scatterslash(get_turf(victim))
