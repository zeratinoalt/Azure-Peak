/datum/action/cooldown/spell/tripleslash
	name = "Triple Slash - Blast"
	desc = "Dash towards a target, cutting three times. \
		Each strike detonates a shell, if possible. \
		Strikes your aimed bodypart. Can be deflected by Defend stance. \
		Click after casting to start the combo."
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	button_icon_state = "tripleslash"
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
	glow_intensity = GLOW_INTENSITY_HIGH

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW
	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 60

/datum/action/cooldown/spell/tripleslash/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)


/datum/action/cooldown/spell/tripleslash/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()
	var/deflected = FALSE

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

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
	victim.Immobilize(5.9 SECONDS)

	H.visible_message(span_danger("[H] draws his blade, prepare to DEFEND!"))
	playsound(H, 'sound/foley/crimsondragon/draw.ogg', 80, FALSE)
	sleep(1 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)

	if(spell_guard_check(victim, FALSE, deflected ? null : owner))
		if(!deflected)
			deflected = TRUE
			H.OffBalance(30)
			base_damage = 20

	sleep(0.6 SECONDS)

	if(isliving(cast_on))
		if(!victim || !owner) //first hit
			return
		var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
		var/turf/dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		if(held_weapon.shells >= 1)
			held_weapon.spent += 1
			held_weapon.shells -= 1
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
			held_weapon.overheat += 8
		else
			base_damage = 40
		dash_to(owner, get_turf(victim), victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Triple Slash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/attack3.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 80, FALSE)

		sleep(1 SECONDS)
		playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)
		sleep(0.3 SECONDS)

		if(held_weapon.shells >= 1) //second
			held_weapon.spent += 1
			held_weapon.shells -= 1
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
			held_weapon.overheat += 8
		else
			base_damage = 40
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		dash_to(owner, dest, victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Triple Slash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/attack6.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)
		victim.safe_throw_at(throwtarget, CLAMP(1, 2, 3), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
		shake_camera(victim, 5, 3)
		sleep(1 SECONDS)

		if(held_weapon.shells >= 1) //third
			held_weapon.spent += 1
			held_weapon.shells -= 1
			playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
			held_weapon.overheat += 8
		else
			base_damage = 40
		dash_to(owner, get_turf(victim), victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Triple Slash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/special1.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash4.ogg', 80, FALSE)
		playsound(H, 'sound/foley/crimsondragon/tremorburst.ogg', 80, FALSE)
		victim.safe_throw_at(throwtarget, CLAMP(1, 2, 3), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
		shake_camera(victim, 5, 3)
		victim.Knockdown(2 SECONDS)

	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

