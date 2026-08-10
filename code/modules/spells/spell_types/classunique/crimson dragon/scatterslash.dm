/datum/action/cooldown/spell/scatterslash
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
	var/base_damage = 80
	var/deflected = FALSE

/datum/action/cooldown/spell/scatterslash/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)


/datum/action/cooldown/spell/scatterslash/cast(atom/cast_on)
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

	if(!istype(held_weapon, /obj/item/rogueweapon/sword/sabre/podao))
		return FALSE

	var/throwtarget = get_edge_target_turf(H, get_dir(H, get_step_away(victim, H)))

	H.visible_message(span_userdanger("[H] is about to use a TANKBUSTER on [victim], BUFF THE TANK!!!"))

	new /obj/effect/temp_visual/crim_dragon/warning/scatterslash(get_turf(victim))

//line and then delay for a bit
	H.say("Eyes up here, BOYS! DON'TCHA GO LOSIN' YER HEADS, NOW!!!")
	playsound(H, 'sound/foley/crimsondragon/eyesuphereboys.ogg', 80, FALSE)


	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

	sleep(2.7 SECONDS)

	victim.Immobilize(4.8 SECONDS)

	playsound(H, 'sound/foley/crimsondragon/draw3.ogg', 80, FALSE)
	H.visible_message(span_danger("[H] draws his sword, gripping it two hands!"))
	sleep(1 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)

	if(spell_guard_check(victim, FALSE, deflected ? null : owner))
		if(!deflected)
			deflected = TRUE
			H.OffBalance(30)
			base_damage = 40

	sleep(0.6 SECONDS)

	if(isliving(cast_on))
		if(!victim || !owner) //first hit
			return
		var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
		var/turf/dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		if(held_weapon.shells >= 2)
			held_weapon.spent += 2
			held_weapon.shells -= 2
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
			sleep(0.8 SECONDS)
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
			H.visible_message(span_danger("[H] detonates two shells, [held_weapon.shells] left!"))
			held_weapon.overheat += 16
		else
			base_damage = 20
			if(deflected)
				base_damage = 10
		dash_to(owner, get_turf(victim), victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Blasting Scatterslash", skip_animation = TRUE, skip_message = TRUE)
		H.visible_message(span_warning("[H] slams down the podao onto [victim]'s shoulder!"))
		playsound(H, 'sound/vo/male/crimsondragon/attack3.ogg', 100, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 100, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/right_to_left(get_turf(victim))
		shake_camera(victim, 5, 3)

		sleep(0.6 SECONDS) // ! test !
		if(held_weapon.shells >= 1) //second hit
			held_weapon.spent += 1
			held_weapon.shells -= 1
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
			held_weapon.overheat += 8
		else
			base_damage = 20
			if(deflected)
				base_damage = 10
		sleep(0.3 SECONDS)


		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		dash_to(owner, dest, victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Blasting Scatterslash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/attack6.ogg', 100, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 100, FALSE)
		new /obj/effect/temp_visual/crim_dragon/large/left_to_right(get_turf(victim))
		H.visible_message(span_warning("[H] slams down the podao onto [victim]'s shoulder - missing the neck!"))
		victim.safe_throw_at(throwtarget, CLAMP(1, 2, 3), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
		shake_camera(victim, 5, 3)

		//end second

		sleep(0.5 SECONDS)

		playsound(H, 'sound/foley/crimsondragon/prep.ogg', 100, FALSE)
		sleep(0.2 SECONDS)

		if(held_weapon.shells >= 1) //third
			held_weapon.spent += 1
			held_weapon.shells -= 1
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 100, FALSE)
			held_weapon.overheat += 8
		else
			base_damage = 20
			if(deflected)
				base_damage = 10
		sleep(0.8 SECONDS)
		dash_to(owner, get_turf(victim), victim)
		owner.face_atom(victim) 
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Blasting Scatterslash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/special2.ogg', 120, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)
		playsound(H, 'sound/foley/crimsondragon/tremorburst.ogg', 100, FALSE)
		playsound(H, 'sound/foley/crimsondragon/gibs.ogg', 100, FALSE)
		shake_camera(victim, 5, 3)
		new /obj/effect/temp_visual/crim_dragon/large/right_to_left(get_turf(victim))
		new /obj/effect/temp_visual/crim_dragon/large/upright_boom(get_turf(victim))
		H.visible_message(span_warning("[H] crushes the podao into [victim]'s shoulder, sending them flying!"))
		victim.safe_throw_at(throwtarget, CLAMP(1, 2, 5), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
		victim.Knockdown(2 SECONDS)

	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

