// 8x1 vertical slashes that alternate
//use anchor objs for the attack plotting


/datum/action/cooldown/spell/slashseries
	button_icon = 'icons/mob/actions/classuniquespells/geseundae.dmi'
	name = "Slash Series"
	desc = "Spawn copies of yourself at the top of the arena, which make alternating slashes in an 8x1 tile range."
	button_icon_state = "slashseries"
	sound = 'sound/foley/geseundae/drawspecial.ogg'

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_SB_MOBILITY

	invocations = list("...I shall cut them down... 'ere I am devoured.")
	invocation_type = INVOCATION_SHOUT

	click_to_activate = TRUE
	self_cast_possible = TRUE

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_drain = 1
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/foley/geseundae/drawloop.ogg'
	cooldown_time = 1 MINUTES

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 80
	var/hitsounds = list('sound/foley/geseundae/hit1.ogg', 'sound/foley/geseundae/hit2.ogg', 'sound/foley/geseundae/hit3.ogg', 'sound/foley/geseundae/hit4.ogg', 'sound/foley/geseundae/hit5.ogg')

/datum/action/cooldown/spell/slashseries/proc/dash_to(mob/living/owner, turf/destination)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.setDir(SOUTH)
	origin.Beam(owner, "flame", time = 2)

/datum/action/cooldown/spell/slashseries/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/locked_zone = owner.zone_selected || BODY_ZONE_CHEST
	var/obj/item/rogueweapon/sword/sabre/geseundae/held_weapon = owner.get_active_held_item()
	var/turf/anchorturf
	var/list/first_slashing_turfs = list()
	var/list/second_slashing_turfs = list()

	for(var/obj/structure/geseundae_attack_anchor/anchor in GLOB.gesanchor1)
		anchorturf = get_turf(anchor)
		var/turf/dest = get_ranged_target_turf(anchorturf, SOUTH, 12)
		new /obj/effect/temp_visual/geseundaedecoy(anchorturf, H)

		var/list/first_hit = getline(anchorturf, dest)
		first_slashing_turfs += first_hit
		for(var/turf/path_turf in first_hit)
			new /obj/effect/temp_visual/geseundae/warning(path_turf)

	for(var/mob/living/dings in range(13, H))
		dings.playsound_local(dings, 'sound/foley/geseundae/drawspecial2.ogg', 100, FALSE)

	addtimer(CALLBACK(src, PROC_REF(execute_path_strikes), H, held_weapon, locked_zone, first_slashing_turfs), 3 SECONDS)

	sleep(1.5 SECONDS)

	for(var/obj/structure/geseundae_attack_anchor_secondslash/anchor in GLOB.gesanchor2)
		anchorturf = get_turf(anchor)
		var/turf/dest = get_ranged_target_turf(anchorturf, SOUTH, 12)
		new /obj/effect/temp_visual/geseundaedecoy(anchorturf, H)

		var/list/second_hit = getline(anchorturf, dest)
		second_slashing_turfs += second_hit
		for(var/turf/path_turf in second_hit)
			new /obj/effect/temp_visual/geseundae/warning(path_turf)

	for(var/mob/living/dings in range(13, H))
		dings.playsound_local(dings, 'sound/foley/geseundae/drawspecial2.ogg', 100, FALSE)

	second_slashing_turfs -= first_slashing_turfs
	addtimer(CALLBACK(src, PROC_REF(execute_path_strikes), H, held_weapon, locked_zone, second_slashing_turfs), 3 SECONDS)


/datum/action/cooldown/spell/slashseries/proc/execute_path_strikes(mob/living/carbon/human/user, obj/item/weapon, def_zone, list/slashturfs)
	if(!user || QDELETED(user))
		return
	for(var/turf/path_turf in slashturfs)
		for(var/mob/living/target in path_turf)
			if(target == user)
				continue
			arcyne_strike(user, target, weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Slash Series", skip_animation = TRUE, skip_message = TRUE)
			playsound(target, pick(hitsounds), 100, FALSE)
		new /obj/effect/temp_visual/geseundae/large(path_turf)



