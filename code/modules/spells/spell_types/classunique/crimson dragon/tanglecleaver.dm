#define TANGLECLEAVER_BASE_DAMAGE 160

/datum/action/cooldown/spell/tanglecleaver
	name = "Tanglecleaver"
	desc = "cast on victim, after check u strike victim lol"
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
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC | SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	var/base_damage = 80
	var/deflected = FALSE

/datum/action/cooldown/spell/tanglecleaver/proc/dash_to(mob/living/owner, turf/destination, mob/living/target)
	var/turf/origin = get_turf(owner)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, owner)
	owner.forceMove(destination)
	owner.dir = get_dir(owner, target)
	origin.Beam(owner, "flame", time = 50)


/datum/action/cooldown/spell/tanglecleaver/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/rogueweapon/sword/sabre/podao/held_weapon = H.get_active_held_item()

//	var/turf/tangleanchor

	var/slashdir = list(/obj/effect/temp_visual/crim_dragon/large/right_to_left, /obj/effect/temp_visual/crim_dragon/large/left_to_right, /obj/effect/temp_visual/crim_dragon/large/low_left_to_right, /obj/effect/temp_visual/crim_dragon/large/low_right_to_left)


	var/mob/living/victim


	if(isliving(cast_on))

		if(!victim || !owner)
			return
		victim = cast_on
	var/def_zone = owner.zone_selected || BODY_ZONE_CHEST
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



	//	for(var/obj/structure/fluff/tanglecleaver/anchor in thearena)
	//		tangleanchor = get_turf(anchor)


	H.visible_message(span_userdanger("[H] stops for a moment, dashing towards the top of the arena..."))

	//	dash_to(owner, tangleanchor, tangleanchor)



	H.say("I'maboutta drop somethin' big on y'all! Don't let it kill y'all now and spoil the fun~!!")
	playsound(H, 'sound/foley/crimsondragon/dropsumbigonyall.ogg', 80, FALSE)
	sleep(4.8 SECONDS)

	H.visible_message(span_userdanger("[H] stands still, a shit-eating grin on his face. Who dares to stop him?"))
	H.visible_message(span_warningbig("Send your STRONGEST and STURDIEST party member to strike him with a weapon!"))

	H.apply_status_effect(/datum/status_effect/buff/tanglecheck)

	sleep (6 SECONDS)

	base_damage = TANGLECLEAVER_BASE_DAMAGE

	new /obj/effect/temp_visual/crim_dragon/warning/tanglecleaver(get_turf(victim))

	playsound(H, 'sound/foley/crimsondragon/prep.ogg', 80, FALSE)
	sleep (0.3 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/tanglewhrr.ogg', 80, FALSE)
	sleep (0.5 SECONDS)
	playsound(H, 'sound/foley/crimsondragon/detonation.ogg', 80, FALSE)
	playsound(H, 'sound/vo/male/crimsondragon/special1.ogg', 120, FALSE)
	sleep (1 SECONDS)

	dash_to(owner, dest, victim)


	var/turf/T = get_turf(victim)
	if(!T)
		return FALSE
	var/pickslash = pick(slashdir)
	playsound(H, 'sound/foley/crimsondragon/slam.ogg', 120, FALSE)
	for(var/mob/living/target in range(4, T))
		if(target == owner)
			continue
		var/throwtarget = get_edge_target_turf(H, get_dir(H, get_step_away(target, H)))
		new pickslash(get_turf(target))
		arcyne_strike(owner, target, held_weapon, base_damage, def_zone, BCLASS_CUT, spell_name = "Tanglecleaver", skip_animation = TRUE, skip_message = TRUE)
		target.safe_throw_at(throwtarget, CLAMP(1, 2, 5), 1, owner, force = MOVE_FORCE_EXTREMELY_STRONG)




/obj/structure/fluff/tanglecleaver
	icon = 'icons/roguetown/rav/obj/flags.dmi'
	icon_state = "nothinglol"
	density = FALSE
	anchored = TRUE
	blade_dulling = DULLING_BASHCHOP
	layer = BELOW_MOB_LAYER
	max_integrity = 0


/datum/status_effect/buff/tanglecheck
	id = "tanglecheck"
	duration = 6 SECONDS
	var/dur
	var/sfx_on_apply = 'sound/foley/ding.ogg'

	alert_type = /atom/movable/screen/alert/status_effect/buff/clash

	mob_effect_icon = 'icons/mob/mob_effects.dmi'
	mob_effect_icon_state = "eff_feint_bait"
	mob_effect_layer = MOB_EFFECT_LAYER_GUARD


/datum/status_effect/buff/tanglecheck/on_creation(mob/living/new_owner, ...)
	//!Danger! Zone!
	//These signals use OVERRIDES and can OVERLAP with anything else using them.
	//At the moment we have no way of prioritising one signal over the other, it's first-come first-serve. Keep this in mind.
	RegisterSignal(new_owner, COMSIG_MOB_ITEM_BEING_ATTACKED, PROC_REF(process_attack))
	RegisterSignal(new_owner, COMSIG_MOB_ITEM_POST_SWINGDELAY_ATTACKED, PROC_REF(process_attack))
	RegisterSignal(new_owner, COMSIG_MOB_KICKED, PROC_REF(process_attack))
	RegisterSignal(new_owner, COMSIG_MOB_ATTACKED_BY_HAND, PROC_REF(process_attack))


/datum/status_effect/buff/tanglecheck/proc/process_attack(mob/living/carbon/human/parent, mob/living/carbon/human/attacker, mob/living/carbon/human/defender)
	var/obj/item/I = defender.get_active_held_item()
	var/checksucceed = defender.tanglecheck(attacker, I, null)
	if(checksucceed == TRUE)
		playsound(defender, 'sound/foley/crimsondragon/yallarefiringmeup.ogg')
		sleep(4.7 SECONDS)
		return TANGLECLEAVER_BASE_DAMAGE / 2
	else
		playsound(defender, 'sound/foley/crimsondragon/tuckeredout.ogg')
		sleep(2 SECONDS)
		return TANGLECLEAVER_BASE_DAMAGE

/mob/living/carbon/human/proc/tanglecheck(mob/user, obj/item/IM, obj/item/IU) //user = attacker 
	if(!ishuman(user))
		return
	var/checksucceed = FALSE
	var/mob/living/carbon/human/H = user
	var/totalnumb = 0
	var/str = H.get_stat(STAT_STRENGTH)
	var/end = H.get_stat(STAT_CONSTITUTION)

	totalnumb = str + end
	if(totalnumb >= 30)
		checksucceed = TRUE
	else
		checksucceed = FALSE
	return checksucceed


