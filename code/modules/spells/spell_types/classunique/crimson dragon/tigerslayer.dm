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
	charge_drain = 0
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
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)

/datum/action/cooldown/spell/tigerslayer/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()

//	var/turf/tangleanchor

	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST

	var/mob/living/victim
	var/turf/T = get_turf(victim)
	var/turf/lei_turf = get_turf(H)
	var/divisor = 1

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

	if(!T)
		return FALSE

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

	//warning
	new /obj/effect/temp_visual/crim_dragon/warning/biggest(T)

	H.visible_message(span_userdanger("[H] stops for a moment, preparing a stance..."))
	victim.Immobilize(10.1 SECONDS)

	H.say("I'm 'bouta drop somethin' big on y'all! Don't let it kill y'all now and SPOIL THE FUN!!!")
	playsound(H, 'sound/foley/crimsondragon/dropsumbigonyall.ogg', 80, FALSE)
	H.visible_message(span_userdanger("[H] is about to hit [victim] with an insanely powerful attack!!"))
	H.visible_message(span_userdanger("Stack within the boundary surrounding [victim], to divide the damage!!!"))

	sleep(4.8 SECONDS)

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
		if(held_weapon.shells >= 1)
		held_weapon.spent += 1
		held_weapon.shells -= 1
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		held_weapon.overheat += 8
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		owner.face_atom(victim)
		owner.update_icon()
		dash_to(owner, get_turf(victim), victim)
		for(var/mob/living/target in range(3, T))
			arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 80, FALSE)
		sleep(1 SECONDS)

// ! second hit !

		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		owner.face_atom(victim)
		owner.update_icon()
		dash_to(owner, dest, victim)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 80, FALSE)
		owner.face_atom(victim)
		owner.update_icon()
		for(var/mob/living/target in range(3, T))
			arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))

		sleep(1 SECONDS)

// ! third hit !

		H.visible_message(span_danger("[H] draws his sword, gripping it two hands!"))
		sleep(0.6 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)

		sleep(0.4 SECONDS)
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim))
		if(!dest)
			dest = get_turf(victim)
		if(held_weapon.shells >= 2)
			held_weapon.spent += 2
			held_weapon.shells -= 2
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
			animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			for(var/mob/living/target in in_view_range(H, lei_turf))
				animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			sleep(0.4 SECONDS)
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
			animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			for(var/mob/living/target in in_view_range(H, lei_turf))
				animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			H.visible_message(span_danger("[H] detonates two shells, [held_weapon.shells] left!"))
			held_weapon.overheat += 16
		else
			base_damage = 20
			if(deflected)
				base_damage = 10
		owner.face_atom(victim)
		owner.update_icon()
		dash_to(owner, get_turf(victim), victim)
		for(var/mob/living/target in range(3, T))
			arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
		H.visible_message(span_warning("[H] slams down the podao onto [victim]'s shoulder!"))
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 100, FALSE)
		playsound(H, 'sound/foley/crimsondragon/gibs.ogg', 80, FALSE)
		shake_camera(victim, 5, 3)

// ! fourth hit !

		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		owner.face_atom(victim)
		owner.update_icon()
		dash_to(owner, get_turf(victim), victim)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
		sleep (0.5 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		sleep (0.2 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		playsound(H, 'sound/foley/crimsondragon/gibs.ogg', 80, FALSE)
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim))
		dash_to(owner, get_turf(victim), victim)
		for(var/mob/living/target in range(3, T))
			if(target == owner)
				continue
			new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
			shake_camera(target, 5, 3)

// ! fifth hit

		playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)

		sleep(0.3 SECONDS)

		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)
		sleep(0.5 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		for(var/mob/living/target in in_view_range(H, lei_turf))
			animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
			arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)

