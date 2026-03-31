/* Requiem - the Erlking's finisher.
7 hits, doesn't spawn mobs.

Requires 7 momentum, overcharge does nothing.*/

/obj/effect/proc_holder/spell/invoked/requiem
	name = "Requiem"
	desc = "Tear someone apart, targetting a single person. \
		Upon calling, perform a seven-hit combo on your victim. \
		Requires 7 momentum, overcharging does nothing. \
		Has an extreme delay. \
		Cannot be blocked."
	clothes_req = FALSE
	range = 7
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "requiem"
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	invocations = list()
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	glow_color = GLOW_COLOR_ERLKING
	glow_intensity = GLOW_INTENSITY_VERY_HIGH
	var/momentum_cost = 7
	var/empowered_momentum = 10
	var/telegraph_delay = TELEGRAPH_HIGH_IMPACT
	var/beam_color = COLOR_VIOLET_DARK
	var/combo_sounds = list ('sound/combat/hits/bladed/fusedthrust (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedthrust (3).ogg')
	var/damage = 40
	var/empowered_mult = 1

/obj/effect/proc_holder/spell/invoked/requiem/proc/requiem_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	destination = get_step(target.loc, pick(GLOB.cardinals))
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/obj/effect/proc_holder/spell/invoked/requiem/can_cast(mob/user = usr, feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/H = user
	var/datum/status_effect/buff/arcyne_momentum/M = H.has_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(!M || M.stacks < momentum_cost)
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/requiem/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

	var/obj/item/held_weapon = arcyne_get_weapon(H)
	if(!held_weapon)
		to_chat(H, span_warning("I need my bound weapon in hand!"))
		revert_cast()
		return

	if(!HAS_TRAIT(H, TRAIT_AFFECTION_AND_HATRED))
		to_chat(H, span_warning("My body tires - I can't fight like this..."))
		revert_cast()
		return

	var/datum/status_effect/buff/arcyne_momentum/M = H.has_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(!M || M.stacks < momentum_cost)
		to_chat(H, span_warning("Not enough momentum! I need at least [momentum_cost] stacks!"))
		revert_cast()
		return

	var/def_zone = H.zone_selected || BODY_ZONE_CHEST

	playsound(H, 'sound/foley/requiemstart.ogg', 80, TRUE)
	H.emote("attackgrunt", forced = TRUE)
	H.say("DISAPPEAR WITH THE STORM!!!")
	sleep(telegraph_delay)

//a lot of the stuff below is the same, with small variations for sounds
//ik this could've been done with another for() however - again. sounds
	for(var/mob/living/carbon/human/victim in targets)
		if(!victim || !user) //first hit
			return
		var/turf/dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		H.emote("attack", forced = TRUE)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Requiem")
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //second hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Requiem")
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //third hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Requiem")
		playsound(H, pick(combo_sounds), 80, FALSE)
		playsound(H, 'sound/foley/requiemhit.ogg', 80, TRUE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //fourth hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Requiem")
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //fifth hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Requiem")
		playsound(H, pick(combo_sounds), 80, FALSE)
		playsound(H, 'sound/foley/requiemhit.ogg', 80, TRUE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //sixth hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Requiem")
		H.emote("attack", forced = TRUE)
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //seventh hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		requiem_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_SMASH, spell_name = "Requiem")
		playsound(H, pick(combo_sounds), 80, FALSE)
		playsound(H, 'sound/foley/requiemfinisher.ogg', 80, TRUE)
		sleep(0.5 SECONDS)
		playsound(H, 'sound/foley/requiemlightning.ogg', 80, TRUE)
