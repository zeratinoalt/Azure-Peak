/datum/action/cooldown/spell/burningembers
	name = "Burning Embers"
	desc = "multi-slash attack 1, mass debuff. uses sword"
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	button_icon_state = "doubleslash"

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
	var/base_damage = 80
	var/deflected = FALSE
	sound = 'sound/silence.ogg'

/datum/action/cooldown/spell/burningembers/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 2)
	origin.Beam(owner, "meihua", time = 2)
	playsound(owner, 'sound/foley/ironmeihua/dash.ogg', 100, FALSE)

/datum/action/cooldown/spell/burningembers/proc/vfx_spawn(turf/T)
	var/vfx_amount = 20
	var/vfx_loc = spiral_range_turfs(3, get_turf(T))
	for(var/i in 1 to vfx_amount)
		var/vfx = pick(/obj/effect/temp_visual/crim_dragon/large/upright_boom, /obj/effect/temp_visual/crim_dragon/large/second_boom, /obj/effect/temp_visual/meihua/big/scarslash, /obj/effect/temp_visual/meihua/big/flurry)
		var/turf/vfxturf = pick_n_take(vfx_loc)
		new vfx(vfxturf)


/datum/action/cooldown/spell/burningembers/cast(atom/cast_on)
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

	if(!istype(held_weapon, /obj/item/rogueweapon/sword/sabre/meihua))
		to_chat(H, span_warning("I need my sword for this one."))
		return FALSE

	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
	var/turf/dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)

	H.visible_message(span_userdanger("[H] is about to use a powerful attack on [victim]!"))

	new /obj/effect/temp_visual/crim_dragon/warning(get_turf(victim))

	H.status_flags |= GODMODE
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)

	sleep(1 SECONDS)

	H.say("I am... Waiting still, even now.")
	playsound(H, 'sound/foley/ironmeihua/ember1.ogg', 80, FALSE)

	dash_to(H, dest, victim)
	arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Burning Embers", skip_animation = TRUE, skip_message = TRUE)
	playsound(H, 'sound/foley/ironmeihua/hitslashstrong.ogg', 100, FALSE)
	vfx_spawn(get_turf(victim))

	sleep(2.4 SECONDS)

	H.say("In this place no one can escape from-..")
	playsound(H, 'sound/foley/ironmeihua/ember2.ogg', 80, FALSE)

	dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
	dash_to(H, dest, victim)
	arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Burning Embers", skip_animation = TRUE, skip_message = TRUE)
	playsound(H, 'sound/foley/ironmeihua/hitbluntstrong.ogg', 100, FALSE)
	vfx_spawn(get_turf(victim))

	sleep(2.8 SECONDS)

	H.say("A place ever suspended, ever barred from touching the sky...")
	playsound(H, 'sound/foley/ironmeihua/ember3.ogg', 80, FALSE)

	dest = get_ranged_target_turf_direct(owner, victim, get_dist(owner, victim) + 2)
	dash_to(H, dest, victim)
	arcyne_strike(owner, victim, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Burning Embers", skip_animation = TRUE, skip_message = TRUE)
	playsound(H, 'sound/foley/ironmeihua/hitslashstrong.ogg', 100, FALSE)
	vfx_spawn(get_turf(victim))


	var/throwtarget = get_edge_target_turf(H, get_dir(H, get_step_away(victim, H)))
	victim.safe_throw_at(throwtarget, CLAMP(1, 2, 5), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)
	victim.Knockdown(2 SECONDS)


	H.status_flags &= ~GODMODE
	REMOVE_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)


	for(var/mob/living/targets in range(7, H))
		targets.apply_status_effect(/datum/status_effect/debuff/burning_embers)

/datum/status_effect/debuff/burning_embers
	id = "coordinated_assault"
	alert_type = /atom/movable/screen/alert/status_effect/buff/burning_embers
	effectedstats = list(STATKEY_LCK = -1, STATKEY_CON = -1, STATKEY_WIL = -1, STATKEY_INT = -2)
	duration = 5 MINUTES


/atom/movable/screen/alert/status_effect/debuff/burning_embers
	name = "Burning Embers"
	desc = "I'm scorched by the flames surrounding me, I need to be careful."
	icon_state = "permadeath"
