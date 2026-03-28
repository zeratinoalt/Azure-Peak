/obj/effect/proc_holder/spell/invoked/summonwraith
	name = "Summon Revenants"
	desc = "Draw upon your past and summon the revenants bound to your coffin to fight with you. \
	These revenants cannot be commanded and lash out against anyone that isn't you."
	clothes_req = FALSE
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "revenant"
	range = 7
	sound = list('sound/foley/beheadstart.ogg')
	releasedrain = 40
	chargetime = 2 SECONDS //yeah so you can counter the spawns by just having a lamp on you
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	gesture_required = TRUE // Summon spell
	recharge_time = 10 SECONDS
	var/is_summoned = FALSE
	var/to_spawn = 4
	hide_charge_effect = TRUE

/obj/effect/proc_holder/spell/invoked/summonwraith/cast(list/targets, mob/living/user)
	..()

	if(!HAS_TRAIT(user, TRAIT_WILDHUNT))
		to_chat(user, span_userdanger("I call for the storm - yet nothing responds..!"))

	if(istype(get_area(user), /area/rogue/indoors/ravoxarena))
		to_chat(user, span_userdanger("I reach for outer help, but something rebukes me! This challenge is only for me to overcome!"))
		revert_cast()
		return FALSE
	
	var/turf/T = get_turf(targets[1])
	if(!isopenturf(T))
		to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
		return FALSE
	user.say("No repose shall await us.")
	var/spirit_roll

	for(var/i = 1 to to_spawn)
		if(i > to_spawn)
			i = 1

		if(i > 1)
			if(user.dir == NORTH || user.dir == SOUTH)
				if(prob(50))
					T = get_step(T, EAST)
				else
					T = get_step(T, WEST)
			else
				if(prob(50))
					T = get_step(T, NORTH)
				else
					T = get_step(T, SOUTH)

		if(!isopenturf(T))
			continue

		new /obj/effect/temp_visual/memorialprocession_telegraph(T)
		spirit_roll = rand(1,40)
		switch(spirit_roll)
			if(1 to 20)
				new /mob/living/simple_animal/hostile/retaliate/rogue/revenant/wildhunt(T, user)
			if(21 to 40)
				new /mob/living/simple_animal/hostile/retaliate/rogue/revenant/wildhunt/weak(T, user)
	return TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/revenant/wildhunt
	name = "wraith"
	desc = "A burning, hateful spirit linked to the Bereaved's past. They take the form of nobles, butlers - abusers, and past friends."
	health = 150
	maxHealth = 150
	faction = list("wildhunt")
	icon_state = "wildhunt"
	light_system = MOVABLE_LIGHT
	light_outer_range = 2
	light_inner_range = 1
	light_power = 1.5
	light_color = "#AC48B2"
	ai_controller = /datum/ai_controller/haunt

/mob/living/simple_animal/hostile/retaliate/rogue/revenant/wildhunt/weak
	health = 80
	maxHealth = 80
	melee_damage_lower = 15
	melee_damage_upper = 20
