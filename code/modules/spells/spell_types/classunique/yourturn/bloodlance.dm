/datum/action/cooldown/spell/blood_lance
	button_icon = 'icons/mob/actions/classuniquespells/yourturn.dmi'
	name = "Blood Lance"
	desc = "Summon three lances made out of blood that track a target, before hurling it at them."
	button_icon_state = "spears"
	sound = 'sound/foley/bleed_apply.ogg'
	spell_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	invocations = list("|..Try and dodge this, Constance.|")
	invocation_type = INVOCATION_SHOUT

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/magic/chargingblood.ogg'
	cooldown_time = 5.5 SECONDS

	associated_skill = /datum/skill/magic/blood
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

/datum/action/cooldown/spell/blood_lance/proc/DeferProjectile(projectile_type, mob/living/target_shoot, turf/T, projectile_telegraph_delay = 3, mob/living/owner)
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

/datum/action/cooldown/spell/blood_lance/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner

	var/mob/living/victim

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

	var/our_projectile_path = /obj/projectile/magic/blood_lance
	var/dir_to_target = get_cardinal_dir(owner, victim)

	var/list/origin_turfs = list()
	//Give me all the  turfs that are 2 tiles away
	//Default is EAST
	var/invert = 1
	//Ill figure out a way to write this shorter someday
	if(dir_to_target == WEST || dir_to_target == SOUTH)
		invert = -1
	var/positionx = owner.x+(1*invert)
	var/positiony = 0
	if(dir_to_target == NORTH || dir_to_target == SOUTH)
		positionx = 0
		positiony = owner.y+(1*invert)

	for(var/turf/T in orange(get_turf(owner),2))
		if(!isopenturf(T))
			continue
		if(positionx && positionx != T.x)
			continue
		if(positiony && positiony != T.y)
			continue
		if(owner.z != T.z)
			//Just in case
			continue
		origin_turfs += T

	if(!length(origin_turfs))
		return

	var/turf_dir
	var/delay = 3
	for(var/turf/bullet_turfs in origin_turfs)
		if(!turf_dir)
			turf_dir = dir_to_target
		DeferProjectile(our_projectile_path, get_step(bullet_turfs, turf_dir), bullet_turfs, delay)
		delay++

/obj/projectile/magic/blood_lance
	name = "bloody spear"
	icon = 'icons/roguetown/weapons/lalalaBLOODSPEAR.dmi'
	icon_state = "bloodspear"
	guard_deflectable = TRUE
	damage = 80
	damage_type = BRUTE
	woundclass = BCLASS_PIERCE
	npc_simple_damage_mult = 1.5
	nodamage = FALSE
	speed = MAGE_PROJ_FAST
	armor_penetration = PEN_HEAVY
	movement_type = UNSTOPPABLE
	range = SPELL_RANGE_PROJECTILE
	flag = "stab"
	hitsound = 'sound/combat/hits/bladed/genthrust (1).ogg'
	pixel_x = -16
	pixel_y = -16
	ignore_source_check = TRUE

/obj/projectile/magic/blood_lance/on_hit(target)
	if(ismob(target))
		var/mob/M = target
		if(M == firer)
			return BULLET_ACT_FORCE_PIERCE
		playsound(get_turf(target), 'sound/foley/bleed.ogg', 80, TRUE)
	. = ..()
	// Pierce through mobs, stop on solids
	if(!ismob(target))
		qdel(src)
		return . || BULLET_ACT_HIT
	return BULLET_ACT_FORCE_PIERCE
