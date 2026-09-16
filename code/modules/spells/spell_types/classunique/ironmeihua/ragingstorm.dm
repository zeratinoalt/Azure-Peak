/datum/action/cooldown/spell/ragingstorm
	button_icon = 'icons/mob/actions/classuniquespells/ironmeihua.dmi'
	name = "Raging Storm"
	desc = "light tiles on fire bruh."
	button_icon_state = "ragingstorm"
	spell_color = GLOW_COLOR_CRIMSON

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/magic/charging_fire.ogg'
	cooldown_time = 30 SECONDS


	associated_skill = /datum/skill/combat/unarmed
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

/datum/action/cooldown/spell/ragingstorm/proc/spawnfire(mob/living/owner)
	var/fire_amount = 15
	var/fire_loc = spiral_range_turfs(5, get_turf(owner))
	owner.visible_message(span_danger("Flames spark around the arena!"))
	playsound(owner, 'sound/foley/ironmeihua/hitslash.ogg', 80, TRUE)
	for(var/i in 1 to fire_amount)
		var/turf/t = pick_n_take(fire_loc)
		new /obj/effect/hotspot(t)

/datum/action/cooldown/spell/ragingstorm/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.visible_message(span_danger("[H] blinks just once, and the arena is set ablaze!"))
	H.say("You think you can get away with this?! Answer me - you cheap IMITAITON!")
	playsound(H, 'sound/foley/ironmeihua/linespecial4.ogg', 80, FALSE)
	var/old_time = world.time
	while(world.time < old_time + 6 SECONDS)
		spawnfire(H)
		sleep(3 SECONDS)
		spawnfire(H)
