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

	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 300
	var/deflected = FALSE

/datum/action/cooldown/spell/slashseries/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)


/datum/action/cooldown/spell/slashseries/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()
	var/turf/anchorturf
	var/area/rogue/outdoors/woods/north/thearena = GLOB.areas_by_type[/area/rogue/outdoors/woods/north]
	for(var/obj/structure/tangleanchor/anchor in thearena)
		anchorturf = get_turf(anchor)



	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST

	var/mob/living/victim


	if(isliving(cast_on))
		victim = cast_on

	var/turf/dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 1)

	if(!dest)
		dest = get_turf(victim)
	if(victim == owner)
		return FALSE

	if(!istype(H))
		return FALSE

	if(!istype(held_weapon, /obj/item/rogueweapon/sword/sabre/podao))
		return FALSE

	if(held_weapon.shells < 6)
		to_chat(H, span_warning("Out of shells, reload!"))
		return FALSE

	var/turf/T = get_turf(victim)
	var/turf/lei_turf = get_turf(H)
	if(!T)
		return FALSE

	if(!anchorturf)
		return FALSE

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
