/datum/action/cooldown/spell/callofthedragon
	name = "Call of the Dragon"
	desc = "devastating 5-man stack, one attack"
	button_icon = 'icons/mob/actions/classuniquespells/ironmeihua.dmi'
	button_icon_state = "dragoncall"

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

	associated_skill = /datum/skill/combat/unarmed
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW
	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 1875 //lol

/datum/action/cooldown/spell/callofthedragon/proc/dash_to(mob/living/owner, turf/destination)
	var/turf/origin = get_turf(owner)
	var/list/first_hit = getline(origin, destination)
	for(var/turf/path_turf in first_hit)
		new /obj/effect/temp_visual/decoy/fading/halfsecond(path_turf)
		sleep(0.25 DECISECONDS)
	owner.forceMove(destination)
	owner.setDir(SOUTH)
	origin.Beam(owner, "meihua", time = 2)

/datum/action/cooldown/spell/callofthedragon/proc/DeferProjectile(projectile_type, mob/living/target_shoot, turf/T, projectile_telegraph_delay = 3, mob/living/owner)
	if(!target_shoot || !T)
		return
	var/obj/projectile/P = new projectile_type(T)
	P.starting = T
	P.firer = owner
	P.fired_from = T
	P.yo = target_shoot.y - T.y
	P.xo = target_shoot.x - T.x
	P.original = target_shoot
	P.preparePixelProjectile(target_shoot, T)
	addtimer(CALLBACK (P, TYPE_PROC_REF(/obj/projectile, fire)), projectile_telegraph_delay)

/datum/action/cooldown/spell/callofthedragon/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
	var/mob/living/victim
	var/divisor = 1
	var/turf/anchorturf
	var/turf/dragonturf
	var/our_projectile_path = /obj/projectile/magic/dragoncall

	if(isliving(cast_on))
		victim = cast_on

	if(victim == owner)
		return FALSE

	if(!istype(H))
		return FALSE

	var/turf/T = get_turf(victim)
	if(!T)
		return FALSE

	new /obj/effect/temp_visual/meihua/warning/biggest(T)

	for(var/obj/structure/dragonanchor/anchor in GLOB.dragonanchor)
		anchorturf = get_turf(anchor)

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

	H.visible_message(span_userdanger("[H] vanishes in a flurry of flames."))
	dash_to(owner, anchorturf)

	for(var/mob/living/dings in range(7, T))
		dings.playsound_local(dings, 'sound/foley/ding.ogg', 100, FALSE)
	victim.Immobilize(10.1 SECONDS)

	H.say("..Tianya Star! Descend upon the World and burn all +THAT STANDS BEFORE YOU!+")
	playsound(H, 'sound/foley/ironmeihua/linespecial6.ogg', 100, FALSE)
	playsound(victim, 'sound/foley/ironmeihua/roar.ogg', 120, FALSE)
	H.visible_message(span_userdanger("[H] is about to hit [victim] with an insanely powerful attack!!"))
	H.visible_message(span_suicide("At least +FIVE+ players must surround [victim] to divide the damage or they will DIE."))


	dragonturf = get_ranged_target_turf(victim, NORTH, 3)

	DeferProjectile(our_projectile_path, victim, dragonturf, 60)


	sleep(6 SECONDS)

	for(var/mob/living/targets in range(3, T))
		divisor += 1
	base_damage /= divisor

	if(divisor == 0)
		return


	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

// arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tigerslayer", skip_animation = TRUE, skip_message = TRUE)

/obj/projectile/magic/dragoncall
	name = "fierce dragon"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "southdragon"
	guard_deflectable = FALSE
	damage = 1
	damage_type = BURN
	woundclass = BCLASS_PIERCE
	npc_simple_damage_mult = 1.5
	nodamage = FALSE
	speed = 0.625
	armor_penetration = PEN_HEAVY
	movement_type = UNSTOPPABLE
	range = SPELL_RANGE_PROJECTILE
	flag = "stab"
	pixel_x = -32
	pixel_y = -32
