/datum/action/cooldown/spell/ripplingcuts
	button_icon = 'icons/mob/actions/classuniquespells/geseundae.dmi'
	name = "Rippling Cuts"
	desc = "shadow tendrils bruh."
	button_icon_state = "tendrils"
	spell_color = GLOW_COLOR_GESEUNDAE

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_drain = 1
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/foley/geseundae/gongloop.ogg'
	cooldown_time = 30 SECONDS


	associated_skill = /datum/skill/combat/swords
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

/datum/action/cooldown/spell/ripplingcuts/proc/spawntentacles(mob/living/owner)
	var/tentacle_amount = 15
	var/tentacle_loc = spiral_range_turfs(5, get_turf(owner))
	owner.visible_message(span_danger("Whispers rise from the shadowed floor!"))
	playsound(owner, 'sound/foley/geseundae/swing2.ogg', 80, TRUE)
	for(var/i in 1 to tentacle_amount)
		var/turf/t = pick_n_take(tentacle_loc)
		new /obj/effect/temp_visual/blood_tentacle/black(t, owner)


/datum/action/cooldown/spell/ripplingcuts/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.visible_message(span_danger("[H] sheathes his blade, and shadows crawl across the floor!"))
	H.say("|Not one handspan ahead - does this darkness yield...|")
	var/old_time = world.time
	while(world.time < old_time + 15 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)

/obj/effect/temp_visual/blood_tentacle/black
	name = "whisper"
	desc = "A tendril made out of shadows. Focus on the fight, dumbass."
	icon = 'icons/effects/effects.dmi'
	icon_state = "blood_tendril_spawn"
	layer = BELOW_MOB_LAYER
	color = COLOR_BLACK
	hitsound = 'sound/foley/geseundae/hit5.ogg'
	hittext = "The whisper grabs hold of a victim, shadows seeping through their armor!"
