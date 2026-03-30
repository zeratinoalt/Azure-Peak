//a 1 minute CD spell that makes the user teleport to a highlighted area, performing an aoe and saddling them onto a dullahan
//costs 2 momentum

/obj/effect/proc_holder/spell/invoked/summondullahan
	name = "Call Dullahan"
	desc = "Call upon your Dullahan, mounting them. \
		Dash, perform a small, weak AOE, and then mount. \
		The spell simply brings your Dullahan to you if one already exists. \
		Costs two momentum to activate. \
		The Dullahan is not actual undead, merely a being twisted and molded by your subconscious will.\
		Can be deflected by Defend stance."
	clothes_req = FALSE
	range = 4
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "dullahan"
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
	var/base_damage = 15
	var/empowered_mult = 2
	var/momentum_cost = 2
	var/area_of_effect = 1 // 1-tile radius = 3x3
	var/beam_color = COLOR_VIOLET_DARK
	var/combo_sounds = list ('sound/combat/hits/bladed/fusedthrust (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedthrust (3).ogg')
	var/telegraph_delay = TELEGRAPH_SKILLSHOT

///dash helper - uses forcemove but i think it should be fine
/obj/effect/proc_holder/spell/invoked/summondullahan/proc/summon_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/obj/effect/proc_holder/spell/invoked/summondullahan/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

	if(!HAS_TRAIT(H, TRAIT_SELFLOATHING))
		to_chat(H, span_warning("I call, yet I am met with naught but silence.."))
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

	H.say("HEED MY CALL, O' DULLAHAN!")
	summon_dash_to(user, T)
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
			arcyne_strike(H, victim, null, damage, def_zone, BCLASS_SMASH, spell_name = "Call Dullahan")
			hit_count++

	H.emote("attack", forced = TRUE)

	if(hit_count)
		H.visible_message(span_danger("[H] slams [H.p_their()] their blade down, summoning their Dullahan!"))

	log_combat(H, null, "used Call Dullahan[empowered ? " (empowered)" : ""]")

// horse time
//if no mountsummoned then we summon a dullahan and attach 
	var/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/tame/saddled/mount
	var/mountsummoned
	if(!mountsummoned || mount.stat == DEAD)
		mount = new(user.loc)
		var/mob/living/simple_animal/hostile/friendly_horse = mount
		friendly_horse.friends += user
		if(!user.buckled)
			mount.buckle_mob(user, TRUE)
		mountsummoned = TRUE
	else
		mount.forceMove(user.loc)
		if(!user.buckled)
			mount.buckle_mob(user, TRUE)

	return TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/dullahan
	name = "dullahan"
	desc = "The blood from this wolfish monster's neck evaporates as it drips along."
	icon = 'icons/roguetown/mob/monster/saiga.dmi'
	icon_state = "dullahan"
	icon_living = "dullahan"
	icon_dead = "dullahan_dead"
	icon_gib = "saiga_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	emote_see = list("turns the bleeding neck.", "kicks a leg.", "stands eerily still.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	move_to_delay = 8
	butcher_results = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
		/obj/item/reagent_containers/food/snacks/fat = 2,
		/obj/item/natural/hide = 4,
		/obj/item/natural/bundle/bone/full = 1
	)
	base_intents = list(/datum/intent/simple/fogbeast)
	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/dullahan
	health = 430
	maxHealth = 430
	footstep_type = FOOTSTEP_MOB_SHOE
	faction = list("wildhunt")
	attack_verb_continuous = "tramples"
	attack_verb_simple = "kicks"
	melee_damage_lower = 50
	melee_damage_upper = 70
	retreat_distance = 0
	minimum_distance = 10
	milkies = FALSE
	STASPD = 15
	STACON = 8
	STASTR = 12
	STAWIL = 15
	pixel_x = -8
	attack_sound = 'sound/silence.ogg'
	can_buckle = TRUE
	buckle_lying = 0
	can_saddle = TRUE
	max_buckled_mobs = 2
	aggressive = TRUE
	remains_type = /obj/effect/decal/remains/saiga

/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/tame
	tame = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/tame/saddled/Initialize()
	. = ..()
	var/obj/item/natural/saddle/S = new(src)
	ssaddle = S
	update_icon()

// BEHAVIORS
/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-above", 4.3)
			saddlet.appearance_flags = RESET_ALPHA|RESET_COLOR
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle")
			saddlet.appearance_flags = RESET_ALPHA|RESET_COLOR
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "[icon_state]_mounted", 4.3)
			add_overlay(mounted)


/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/get_sound(input) //it has no head bro
	switch(input)
		if("aggro")
			return pick('sound/silence.ogg')
		if("pain")
			return pick('sound/silence.ogg')
		if("death")
			return pick('sound/silence.ogg')
		if("idle")
			return pick('sound/silence.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/tamed()
	..()
	deaggroprob = 30
	setup_mount_riding()

/mob/living/simple_animal/hostile/retaliate/rogue/dullahan/death()
	unbuckle_all_mobs()
	. = ..()
	if(!QDELETED(src))
		src.AddComponent(/datum/component/deadite_animal_reanimation)
