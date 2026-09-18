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

/datum/action/cooldown/spell/callofthedragon/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
	var/mob/living/victim
	var/divisor = 1
	var/turf/anchorturf

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
		dings.playsound_local(dings, 'sound/foley/ironmeihua/roar.ogg', 120, FALSE)
	victim.Immobilize(10.1 SECONDS)

	H.say("..Tianya Star! Descend upon the World and burn all +THAT STANDS BEFORE YOU!+")
	playsound(H, 'sound/foley/ironmeihua/linespecial6.ogg', 100, FALSE)
	H.visible_message(span_userdanger("[H] is about to hit [victim] with an insanely powerful attack!!"))
	H.visible_message(span_suicide("At least +FIVE+ players must surround [victim] to divide the damage or they will DIE."))

	new /obj/effect/temp_visual/meihua/dragon(T)

	sleep(6 SECONDS)

	for(var/mob/living/targets in range(3, T))
		divisor += 1
	base_damage /= divisor

	if(divisor == 0)
		return

	for(var/mob/living/targets in range(3, T))
		animate(targets.client, pixel_y = 3, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
		arcyne_strike(H, targets, null, base_damage, def_zone, BCLASS_CUT, spell_name = "Call of The Dragon", skip_animation = TRUE, skip_message = TRUE)
		new /obj/effect/temp_visual/crim_dragon/large/tanglecleaver(get_turf(target))

	var/vfx_amount = 7
	var/vfx_loc = spiral_range_turfs(3, get_turf(T))
	for(var/i in 1 to vfx_amount)
		var/vfx = pick(/obj/effect/temp_visual/crim_dragon/large/upright_boom, /obj/effect/temp_visual/crim_dragon/large/second_boom, /obj/effect/temp_visual/meihua/big/scarslash, /obj/effect/temp_visual/meihua/big/flurry)
		var/turf/vfxturf = pick_n_take(vfx_loc)
		new vfx(vfxturf)

	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
