/datum/action/cooldown/spell/doubleslash
	name = "Double Slash - Blast"
	desc = "Dash towards a target, cutting two times. \
		The second strike detonates a shell. \
		Strikes your aimed bodypart. Can be deflected by Defend stance. \
		Click after casting to start the combo."
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
	spell_color = GLOW_INTENSITY_MEDIUM

	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC | SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 40
	var/blast_damage = 60

/datum/action/cooldown/spell/doubleslash/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)


/datum/action/cooldown/spell/doubleslash/cast(atom/cast_on)
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

	if(held_weapon.shells < 1)
		to_chat(H, span_warning("Out of shells, reload!"))
		return FALSE


	H.visible_message(span_danger("[H] draws his blade, prepare to DEFEND!"))
	playsound(H, 'sound/foley/crimsondragon/draw.ogg', 80, FALSE)
	sleep(1.6 SECONDS)

	if(spell_guard_check(victim, FALSE, deflected ? null : owner))
		if(!deflected)
			deflected = TRUE
			H.OffBalance(30)
			base_damage = 20
			blast_damage = 30

	if(isliving(cast_on))
		if(!victim || !owner) //first hit
			return
		var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
		var/turf/dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		dash_to(owner, dest, victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Double Slash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/attack4.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash1.ogg', 80, FALSE)

		playsound(H, 'sound/foley/crimsondragon/draw.ogg', 80, FALSE)
		sleep(1 SECONDS)

		if(!victim|| !owner) //second hit
			return
		dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		dash_to(owner, dest, victim)
		owner.face_atom(victim)
		owner.update_icon()
		arcyne_strike(owner, victim, held_weapon, blast_damage, def_zone, BCLASS_CUT, spell_name = "Double Slash", skip_animation = TRUE, skip_message = TRUE)
		playsound(H, 'sound/vo/male/crimsondragon/attack7.ogg', 80, FALSE)
		playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
		playsound(H, 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 80, FALSE)

		held_weapon.spent += 1
		held_weapon.shells -= 1
		held_weapon.overheat += 8
