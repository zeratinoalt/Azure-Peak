// ! be warned, ye who seeks to port
// ! for the gates of hell seek to swallow you whole should you ctrl + c & ctrl + v

/datum/action/cooldown/spell/tigerslayer
	name = "Savage Tigerslayer's Perfected Flurry of Blades"
	desc = "https://youtu.be/226xMDTU01U?t=134"
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	button_icon_state = "tigerslayer"
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
	var/base_damage = 146 // 146*6 = 876. divided by 4 = 219 total, by 7 is 142

/datum/action/cooldown/spell/tigerslayer/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.setDir(target)
	origin.Beam(owner, "flame", time = 2)

/datum/action/cooldown/spell/tigerslayer/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()

//	var/turf/tangleanchor

	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST

	var/mob/living/victim
	var/turf/lei_turf = get_turf(H)
	var/divisor = 1

	if(isliving(cast_on))
		victim = cast_on
	else
		return FALSE

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
	if(!T)
		return FALSE

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

	//warning
	new /obj/effect/temp_visual/crim_dragon/warning/biggest(T)

	H.visible_message(span_userdanger("[H] stops for a moment, preparing a stance..."))
	for(var/mob/living/dings in range(7, T))
		dings.playsound_local(dings, 'sound/foley/ding.ogg', 100, FALSE)
	victim.Immobilize(10.1 SECONDS)

	H.say("I'm 'bouta drop somethin' big on y'all! Don't let it kill y'all now and SPOIL THE FUN!!!")
	playsound(H, 'sound/foley/crimsondragon/dropsumbigonyall.ogg', 80, FALSE)
	H.visible_message(span_userdanger("[H] is about to hit [victim] with an insanely powerful attack!!"))
	H.visible_message(span_userdanger("Stack within the boundary surrounding [victim] to divide the damage!!!"))

	sleep(6 SECONDS)

	for(var/mob/living/stuntargets in range(3, T))
		if(victim)
			continue
		stuntargets.Immobilize(10.1 SECONDS)

	H.say("Y'all don't go on huntin' tigers without preparin' yerselves TO GET CHOMPED 'TWEEN ONE OF 'EM JAWS!!!")
	playsound(H, 'sound/foley/crimsondragon/huntingtigerschompedclaws.ogg', 80, FALSE)


	for(var/mob/living/targets in range(3, T))
		divisor += 1
	base_damage /= divisor

	if(divisor == 0)
		return

// ! first hit !

	if(isliving(cast_on))
		if(!victim || !owner)
			return

		if(!dest)
			dest = get_turf(victim)
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
		held_weapon.overheat += 8
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		owner.setDir(victim)
		owner.update_icon()
		dash_to(owner, dest, victim)
		for(var/mob/living/target in range(3, T))
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 80, FALSE)
		H.visible_message(span_warning("[H] slams the podao down with one hand!"))
		owner.setDir(victim)
		sleep(1 SECONDS)

// ! second hit !

		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		owner.setDir(dest)
		owner.update_icon()
		dash_to(owner, dest, victim)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 80, FALSE)
		for(var/mob/living/target in range(3, T))
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		H.visible_message(span_warning("[H] leaps through [victim]'s body!"))

		sleep(1 SECONDS)

// ! third hit !

		H.visible_message(span_danger("[H] draws his sword, gripping it two hands!"))
		owner.setDir(victim)
		sleep(0.6 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)
		sleep(0.4 SECONDS)
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 3)
		if(!dest)
			dest = get_turf(victim)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		sleep(0.4 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		dash_to(owner, dest, victim)
		owner.setDir(victim)
		for(var/mob/living/target in range(3, T))
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		H.visible_message(span_warning("[H] slams down the podao onto [victim]'s shoulder!"))
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 100, FALSE)
		playsound(H, 'sound/foley/crimsondragon/gibs.ogg', 80, FALSE)
		shake_camera(victim, 5, 3)

// ! fourth hit !
		owner.setDir(victim)
		H.visible_message(span_userdanger("[H] crouches down, preparing to LEAP FORWARD!!"))
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
		sleep (0.5 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		sleep (0.2 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		sleep (0.5 SECONDS)
		dash_to(owner, dest, victim)
		owner.setDir(victim)
		for(var/mob/living/target in range(3, T))
			if(target == owner)
				continue
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			shake_camera(target, 5, 3)
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/foley/crimsondragon/gibs.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 100, FALSE)
		H.visible_message(span_warning("[H] slashes past [victim]!!!"))
		sleep(0.2 SECONDS)

// ! fifth hit


		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 1)
		owner.setDir(dest)

		playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)

		sleep(0.3 SECONDS)

		dash_to(owner, dest, victim)
		owner.setDir(victim)
		H.visible_message(span_userdanger("[H] swings his podao into the chest cavity!"))
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)
		sleep(0.5 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		H.visible_message(span_userdanger("[H] detonates a shell inside, RIPPING UPWARDS!!!"))
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 5)
		owner.setDir(dest)
		dash_to(owner, dest, victim)
		owner.setDir(victim)
		owner.update_icon()
		sleep(0.6 SECONDS)

// ! final hit

	owner.setDir(victim)
	owner.update_icon()
	playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)
	sleep (0.3 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/tanglewhrr.ogg', 100, FALSE)
	sleep (0.3 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	for(var/mob/living/target in in_view_range(H, lei_turf))
		animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	sleep (0.3 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/tanglewhrrend.ogg', 80, FALSE)
	sleep (0.5 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	for(var/mob/living/target in in_view_range(H, lei_turf))
		animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	H.visible_message(span_userdanger("[H] leaps into the AIR!!!"))

	var/horizontal_difference = victim.x - owner.x
	var/x_to_offset = 0
	// We figure out in which horizontal direction we should animate the leap.
	switch(horizontal_difference)
		if(0)
			x_to_offset = 0
		if(1 to INFINITY)
			x_to_offset = 32
		if(-INFINITY to -1)
			x_to_offset = -32
	owner.face_atom(dest)
	owner.update_icon()
	animate(owner, 0.4 SECONDS, easing = QUAD_EASING, pixel_y = owner.base_pixel_y + 16, pixel_x = owner.base_pixel_x + x_to_offset, alpha = 0)
	sleep(0.4 SECONDS)
	// It's okay if we're on top of the target or next to them, get_ranged_target_turf_direct will just return our own turf anyways.
	var/turf/landing_zone = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) - 1)
	// Janky way to leap at someone? Yes, I guess it is. It can always be made into a "dash" like the lunge is, but I think this is better.
	if(landing_zone.is_blocked_turf(TRUE))
		landing_zone = get_turf(victim)
	if(get_dist(owner, landing_zone) > 15)
		return
	owner.forceMove(landing_zone)
	// Make us appear as though we're coming in really fast from the direction of our starting point.
	owner.pixel_x *= 2.5
	owner.pixel_x *= -1
	owner.pixel_y += 16
	H.visible_message(span_userdanger("[H] comes CRASHING DOWN!!!"))
	playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 120, FALSE)
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	animate(owner, 0.2 SECONDS, easing = QUAD_EASING, pixel_y = owner.base_pixel_y, pixel_x = owner.base_pixel_x, alpha = 255)
	sleep(0.2 SECONDS)

	playsound(H, 'sound/foley/crimsondragon/slam.ogg', 120, FALSE)
	playsound(H, 'sound/vo/male/crimsondragon/special2.ogg', 120, FALSE)
	playsound(H, 'sound/foley/crimsondragon/tremorburst.ogg', 100, FALSE)
	playsound(H, 'sound/foley/crimsondragon/gibs.ogg', 100, FALSE)
	new /obj/effect/temp_visual/crim_dragon/large/second_boom(get_turf(victim))
	for(var/mob/living/target in range(3, T))
		if(target == owner)
			continue
		var/throwtarget = get_edge_target_turf(H, get_dir(H, get_step_away(target, H)))
		new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
		arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		target.safe_throw_at(throwtarget, CLAMP(1, 2, 5), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
		shake_camera(target, 5, 3)
	arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
	if(base_damage == 146) //i mean you left them for dead
		victim.gib()


	held_weapon.spent += 6
	held_weapon.shells -= 6

	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
