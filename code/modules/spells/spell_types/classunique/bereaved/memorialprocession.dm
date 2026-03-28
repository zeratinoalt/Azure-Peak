/* Memorial Procession - moderately expensive attack.
dash towards a target before dealing a 3x3 aoe slam.
basically just fist of psydon but better

Requires 4 momentum, overcharge doubles damage.*/

/obj/effect/proc_holder/spell/invoked/memorialprocession
	name = "Memorial Procession"
	desc = "Ignite your wrath, targetting a single person and dashing towards them. \
		Dash, and then strike with an AOE. \
		Requires 4 momentum, Empowering doubles damage dealt. \
		Simply cast on a target to begin the Procession. \
		Can be deflected by Defend stance."
	clothes_req = FALSE
	range = 7
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "memorial"
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	invocations = list("")
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	glow_color = GLOW_COLOR_ERLKING
	glow_intensity = GLOW_INTENSITY_MEDIUM
	var/base_damage = 40
	var/empowered_mult = 2
	var/momentum_cost = 4
	var/area_of_effect = 1 // 1-tile radius = 3x3
	var/beam_color = COLOR_VIOLET_DARK
	var/combo_sounds = list ('sound/combat/hits/bladed/fusedthrust (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedthrust (3).ogg')
	var/telegraph_delay = TELEGRAPH_SKILLSHOT

///dash helper - uses forcemove but i think it should be fine
/obj/effect/proc_holder/spell/invoked/memorialprocession/proc/memorial_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/obj/effect/proc_holder/spell/invoked/memorialprocession/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

	if(!HAS_TRAIT(H, TRAIT_AFFECTION_AND_HATRED))
		to_chat(H, span_warning("My will to bring ruin falters..!"))
		revert_cast()
		return

	var/obj/item/held_weapon = arcyne_get_weapon(H)
	if(!held_weapon)
		to_chat(H, span_warning("I need my bound weapon in hand!"))
		revert_cast()
		return

	// Check and consume momentum for empowerment
	var/empowered = FALSE
	var/datum/status_effect/buff/arcyne_momentum/M = H.has_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(M && M.stacks >= momentum_cost)
		M.consume_stacks(momentum_cost)
		empowered = TRUE
		to_chat(H, span_notice("[momentum_cost] momentum released — empowered strike!"))

	var/damage = empowered ? (base_damage * empowered_mult) : base_damage
	var/def_zone = H.zone_selected || BODY_ZONE_CHEST

	var/turf/T = get_turf(targets[1])
	if(!T)
		revert_cast()
		return

	H.say("I'LL RIP YOU APART!")
	memorial_dash_to(user, T)
	for(var/turf/affected_turf in get_hear(area_of_effect, T)) //telegraph
		new /obj/effect/temp_visual/memorialprocession_telegraph(affected_turf)
	playsound(T, 'sound/foley/memorialstart.ogg', 60, TRUE)
	H.emote("attackgrunt", forced = TRUE)
	sleep(telegraph_delay)

	if(QDELETED(H) || H.stat == DEAD)
		return

	var/hit_count = 0
	var/deflected = FALSE
	for(var/turf/affected_turf in get_hear(area_of_effect, T))
		new /obj/effect/temp_visual/kinetic_blast(affected_turf)
		for(var/mob/living/victim in affected_turf)
			if(victim == H || victim.stat == DEAD)
				continue
			if(spell_guard_check(victim, FALSE, deflected ? null : H))
				deflected = TRUE
				continue
			arcyne_strike(H, victim, null, damage, def_zone, BCLASS_SMASH, spell_name = "Memorial Procession")
			hit_count++

	H.emote("attack", forced = TRUE)

	if(hit_count)
		H.visible_message(span_danger("[H] slams [H.p_their()] their blade down, sending a shockwave crashing into the ground!"))
	else
		H.visible_message(span_notice("[H] slams [H.p_their()] their blade down, sending a shockwave into empty ground!"))

	log_combat(H, null, "used Memorial Procession[empowered ? " (empowered)" : ""]")
	return TRUE

/obj/effect/temp_visual/memorialprocession_telegraph
	icon = 'icons/effects/effects.dmi'
	icon_state = "curse"
	light_outer_range = 1
	duration = 3
	layer = MASSIVE_OBJ_LAYER
