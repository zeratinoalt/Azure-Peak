/datum/status_effect/buff/combat_theme/area1
	combat_theme = 'sound/music/shenzhou/ledger_combat/bladelineage.ogg'

/datum/status_effect/buff/combat_theme/area2
	combat_theme = 'sound/music/shenzhou/ledger_combat/area2.ogg'

/obj/structure/themebook
	name = "BLACK LEDGER"
	desc = "A self-writing book that records whatever Flagroot happens to see."
	icon = 'icons/roguetown/items/books.dmi'
	icon_state = "themebook"
	density = TRUE
	max_integrity = 5000
	anchored = FALSE
	climbable = TRUE
	facepull = FALSE
	throw_range = 1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	var/status_effect_theme = /datum/status_effect/buff/combat_theme
	var/aura_range = 14
	var/list/mob/living/affected_mobs = list()
	var/list/current_mobs = list()
	var/playing = FALSE
	var/list/mobs_in_range

	var/list/static/themes = list(
		"Area 1" = /datum/status_effect/buff/combat_theme/area1,
		"Area 2" = /datum/status_effect/buff/combat_theme/area2
	)

/obj/structure/themebook/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/themebook/process(delta_time)

	var/atom/A = src
	mobs_in_range = view(aura_range, A)

	for(var/mob/living/L in mobs_in_range)
		current_mobs += L
		if(!affected_mobs[L])
			affected_mobs[L] = TRUE

	// Remove effects from mobs that left range
	for(var/mob/living/L in affected_mobs - current_mobs)
		remove_effects(L)
		affected_mobs -= L

/obj/structure/themebook/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/mob/living/L in affected_mobs)
		remove_effects(L)
		affected_mobs -= L
	..()

/obj/structure/themebook/Initialize(mapload)
	. = ..()
	update_icon()
	START_PROCESSING(SSobj, src)

/obj/structure/themebook/attack_right(mob/user)
	. = ..()
	if(.)
		return
	var/button_selection = input(user, "What should I play?", "\The [src]") as null | anything in list("Area 1","Area 2")
	if(!Adjacent(user))
		return
	if(!button_selection)
		to_chat(user, span_info("I change my mind..."))
		return
	if(button_selection=="Area 1")
		status_effect_theme = /datum/status_effect/buff/combat_theme/area1
	if(button_selection=="Area 2")
		status_effect_theme = /datum/status_effect/buff/combat_theme/area2

/obj/structure/themebook/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!playing)
		to_chat(user, span_info("I turn on the book."))
	if(playing)
		to_chat(user, span_info("I turn off the book."))
	toggle_music()


/obj/structure/themebook/proc/toggle_music()
	if(!playing)
		start_playing()
	else
		stop_playing()

/obj/structure/themebook/proc/start_playing()
	playing = TRUE
	for(var/mob/living/L in mobs_in_range)
		if(!affected_mobs[L])
			apply_effects(L)
			affected_mobs[L] = TRUE

/obj/structure/themebook/proc/stop_playing()
	playing = FALSE
	// bleerfghh
	for(var/mob/living/L in affected_mobs)
		remove_effects(L)
		affected_mobs -= L

/obj/structure/themebook/proc/remove_effects(mob/living/target)
	if(target.has_status_effect(status_effect_theme))
		target.remove_status_effect(status_effect_theme)

/obj/structure/themebook/proc/apply_effects(mob/living/target)
	target.apply_status_effect(status_effect_theme, src)
