

/datum/action/cooldown/spell/tanglecleaver
	name = "Tanglecleaver"
	desc = "cast on victim, after a bit u do an aoe on the victim lol"
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	button_icon_state = "tanglecleaver"
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
	var/base_damage = 300
	var/deflected = FALSE

/datum/action/cooldown/spell/tanglecleaver/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)


/datum/action/cooldown/spell/tanglecleaver/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()

//	var/turf/tangleanchor

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

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

	// Stage 1: Center tile
	new /obj/effect/temp_visual/crim_dragon/warning/tanglecleaver(T)
	sleep (0.5 DECISECONDS)

	// Stage 2: First concentric layer (1 tile out)
	for(var/turf/target in range(1, T))
		if(!(target in get_hear(1, T)))
			continue
		if(get_dist(T, target) != 1)
			continue
		new /obj/effect/temp_visual/crim_dragon/warning/tanglecleaver(target)
	sleep (0.5 DECISECONDS)

	// Stage 3: Second concentric layer (2 tiles out)
	for(var/turf/target in range(2, T))
		if(!(target in get_hear(2, T)))
			continue
		if(get_dist(T, target) != 2)
			continue
		new /obj/effect/temp_visual/crim_dragon/warning/tanglecleaver(target)
	sleep (0.5 DECISECONDS)

	// Stage 4: Third concentric layer (3 tiles out)
	for(var/turf/target in range(3, T))
		if(!(target in get_hear(3, T)))
			continue
		if(get_dist(T, target) != 3)
			continue
		new /obj/effect/temp_visual/crim_dragon/warning/tanglecleaver(target)



	H.visible_message(span_userdanger("[H] stops for a moment, preparing a stance..."))
	victim.Immobilize(10.1 SECONDS)

	for(var/mob/living/stuntargets in range(3, T))
		if(victim)
			continue
		stuntargets.Immobilize(5.3 SECONDS)

	H.say("I'm 'bouta drop somethin' big on y'all! Don't let it kill y'all now and SPOIL THE FUN!!!")
	playsound(H, 'sound/foley/crimsondragon/dropsumbigonyall.ogg', 80, FALSE)
	sleep(4.8 SECONDS)

	H.visible_message(span_userdanger("[H] stands still, with a shit-eating grin on his face. Get away from [victim]!!"))

	sleep (1 SECONDS)

	playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)
	sleep (0.3 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/tanglewhrr.ogg', 100, FALSE)
	sleep (0.5 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	for(var/mob/living/target in in_view_range(H, lei_turf))
		animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	sleep (1 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/tanglewhrrend.ogg', 80, FALSE)
	sleep (0.5 SECONDS)
	playsound(H, 'sound/vo/male/crimsondragon/special1.ogg', 120, FALSE)
	playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
	animate(H.client, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	animate(H, pixel_y = 5, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(H))
	for(var/mob/living/target in in_view_range(H, lei_turf))
		animate(target.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)

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
	owner.face_atom(victim)
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
	animate(owner, 0.2 SECONDS, easing = QUAD_EASING, pixel_y = owner.base_pixel_y, pixel_x = owner.base_pixel_x, alpha = 255)
	sleep(0.2 SECONDS)



	dash_to(owner, dest, victim)
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
		arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tanglecleaver", skip_animation = TRUE, skip_message = TRUE)
		target.safe_throw_at(throwtarget, CLAMP(1, 2, 5), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
		shake_camera(target, 5, 3)

	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

/obj/structure/fluff/tanglecleaver
	icon = 'icons/roguetown/rav/obj/flags.dmi'
	icon_state = "nothinglol"
	density = FALSE
	anchored = TRUE
	blade_dulling = DULLING_BASHCHOP
	layer = BELOW_MOB_LAYER
	max_integrity = 0
