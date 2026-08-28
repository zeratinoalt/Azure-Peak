/datum/action/cooldown/spell/companionship
	button_icon = 'icons/mob/actions/classuniquespells/yourturn.dmi'
	name = "Companionship"
	desc = "Create a crude imitation of companionship, which regularly spawns tendrils around it."
	button_icon_state = "companionship"
	sound = 'sound/foley/bleed_apply.ogg'
	spell_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	invocations = list("|..Comfort me, please.|")
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

/datum/action/cooldown/spell/companionship/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner

	var/turf/companionspawn = get_turf(cast_on)
	if(!companionspawn)
		return FALSE

	H.visible_message(span_boldwarning("[H] constructs a large, humanoid mass!"))
	sleep(0.7 SECONDS)
	new /mob/living/simple_animal/hostile/rogue/companion(companionspawn)



/mob/living/simple_animal/hostile/rogue/companion
	name = "???"
	desc = "...Don't leave me behind, please. I don't want to be lonely."
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "bloodbath"
	icon_living = "bloodbath"
	gender = "neuter"
	mob_biotypes = MOB_HUMANOID
	robust_searching = 1
	turns_per_move = 1
	move_to_delay = 3
	STACON = 9
	STASTR = 9
	STASPD = 14
	maxHealth = 300
	health = 50
	harm_intent_damage = 5
	melee_damage_lower = 5
	melee_damage_upper = 7
	vision_range = 7
	aggro_vision_range = 9
	retreat_distance = 0
	minimum_distance = 0
	limb_destroyer = 1
	base_intents = list(/datum/intent/simple/bite)
	attack_verb_continuous = "hacks"
	attack_verb_simple = "hack"
	attack_sound = 'sound/blank.ogg'
	canparry = TRUE
	d_intent = INTENT_PARRY
	defprob = 20
	speak_emote = list("growls")
	footstep_type = null
	del_on_death = TRUE
	can_have_ai = FALSE //disable native ai
	AIStatus = AI_OFF
	melee_cooldown = SKELETON_ATTACK_SPEED
	var/list/cached_tentacle_turfs
	var/turf/last_location
	var/tentacle_recheck_cooldown = 100

/mob/living/simple_animal/hostile/rogue/companion/Life()
	. = ..()
	if(!.) // dead
		return
	if(isturf(loc))
		if(!LAZYLEN(cached_tentacle_turfs) || loc != last_location || tentacle_recheck_cooldown <= world.time)
			LAZYCLEARLIST(cached_tentacle_turfs)
			last_location = loc
			tentacle_recheck_cooldown = world.time + initial(tentacle_recheck_cooldown)
			for(var/turf/open/T in orange(4, loc))
				LAZYADD(cached_tentacle_turfs, T)
		for(var/t in cached_tentacle_turfs)
			if(isopenturf(t))
				if(prob(10))
					new /obj/effect/temp_visual/blood_tentacle(t, src)
			else
				cached_tentacle_turfs -= t
