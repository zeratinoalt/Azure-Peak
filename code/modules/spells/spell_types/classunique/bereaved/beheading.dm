/* Beheading - cheap, semi-spammable attack.
Two attacks, and spawns a funny little ghost to help the user.

Requires 2 momentum. Overcharging does nothing.
Always FFs.*/

/obj/effect/proc_holder/spell/invoked/beheading
	name = "Beheading"
	desc = "Harness your bereavement, targetting a single person and delivering two strikes. \
		There is a noticeable delay before attacking. \
		Requires 2 momentum, overcharging doubles damage. \
		Cannot be blocked."
	clothes_req = FALSE
	range = 7
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "behead"
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	invocations = list()
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	var/delay = 10
	var/base_damage = 40
	var/momentum_cost = 2
	var/empowered_mult = 2
	var/beam_color = COLOR_VIOLET_DARK
	var/combo_sounds = list ('sound/combat/hits/bladed/fusedthrust (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedthrust (3).ogg')
	var/telegraph_delay = TELEGRAPH_DODGEABLE

///dash helper - uses forcemove but i think it should be fine
/obj/effect/proc_holder/spell/invoked/beheading/proc/behead_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/obj/effect/proc_holder/spell/invoked/beheading/cast(list/targets, mob/user = usr)
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
		to_chat(H, span_warning("I swing, yet my blade does not respond..!"))
		revert_cast()
		return
	H.say("...I'll gouge out your contemptuous eyes.")
	playsound(H, 'sound/foley/beheadstart.ogg', 80, TRUE)
	H.emote("attackgrunt", forced = TRUE)
	sleep(telegraph_delay)

	// Check and consume momentum for empowerment
	var/empowered = FALSE
	var/datum/status_effect/buff/arcyne_momentum/M = H.has_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(M && M.stacks >= momentum_cost)
		M.consume_stacks(momentum_cost)
		empowered = TRUE
		to_chat(H, span_notice("[momentum_cost] momentum released — empowered strike!"))

	var/damage = empowered ? (base_damage * empowered_mult) : base_damage
	var/def_zone = H.zone_selected || BODY_ZONE_CHEST

	for(var/mob/living/carbon/human/victim in targets)
		if(!victim || !user) //first hit
			return
		var/turf/dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		behead_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Beheading")
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //second hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		behead_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT, spell_name = "Beheading")
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)
