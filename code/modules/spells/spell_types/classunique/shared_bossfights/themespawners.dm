//structure first, then proc, then status effects
/obj/structure/theme_spawner
	name = ""
	desc = ""
	icon = null
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	var/status_effect_theme = /datum/status_effect/buff/combat_theme
	var/aura_range = 14
	var/list/mob/living/affected_mobs = list()

/obj/structure/theme_spawner/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/theme_spawner/process(delta_time)

	var/list/current_mobs = list()
	var/atom/A = src
	var/list/mobs_in_range
	mobs_in_range = view(aura_range, A)

	for(var/mob/living/L in mobs_in_range)
		current_mobs += L
		if(!affected_mobs[L])
			apply_effects(L)
			affected_mobs[L] = TRUE

	// Remove effects from mobs that left range
	for(var/mob/living/L in affected_mobs - current_mobs)
		remove_effects(L)
		affected_mobs -= L

/obj/structure/theme_spawner/proc/apply_effects(mob/living/target)
	target.apply_status_effect(status_effect_theme, src)

/obj/structure/theme_spawner/proc/remove_effects(mob/living/target)
	target.remove_status_effect(status_effect_theme)

/atom/movable/screen/alert/status_effect/buff/combat_theme
	name = "Ready for Battle"
	desc = "My body is linked to the Ledger, meaning that the song in my head is attuned to my opponent's subconscious mind."
	icon_state = "call_to_arms"

/datum/status_effect/buff/combat_theme
	id = "combat_theme"
	alert_type = /atom/movable/screen/alert/status_effect/buff/combat_theme
	duration = -1
	var/originalcmode = ""
	var/combat_theme = 'sound/music/combat_crimsondragon.ogg'

/datum/status_effect/buff/combat_theme/on_apply()
	. = ..()
	originalcmode = owner.cmode_music
	owner.cmode_music = combat_theme

/datum/status_effect/buff/combat_theme/on_remove()
	owner.cmode_music = originalcmode
	. = ..()

/obj/structure/theme_spawner/yourturn
	status_effect_theme = /datum/status_effect/buff/combat_theme/yourturn

/datum/status_effect/buff/combat_theme/yourturn
	combat_theme = 'sound/music/combat_yourturn.ogg'
