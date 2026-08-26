/datum/action/cooldown/spell/strangler
	button_icon = 'icons/mob/actions/classuniquespells/yourturn.dmi'
	name = "Strangle"
	desc = "A defensive maneuver that manipulates blood into tendrils. These tendrils spawn every 3 seconds in a spiral surrounding you, \
	and seep through the armor of anyone caught within it, bypassing armor and stunning them for a bit. This effect lasts for 15 seconds."
	button_icon_state = "tendrils"
	spell_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM

	cast_range = SPELL_RANGE_PROJECTILE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = TRUE
	charge_time = CHARGETIME_POKE
	charge_drain = 1
	charge_slowdown = CHARGING_SLOWDOWN_NONE
	charge_sound = 'sound/magic/chargingblood.ogg'
	cooldown_time = 20 SECONDS


	associated_skill = /datum/skill/magic/blood
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_MEDIUM

	spell_requirements = SPELL_REQUIRES_HUMAN

/datum/action/cooldown/spell/strangler/proc/spawntentacles(mob/living/owner)
	var/tentacle_amount = 15
	var/tentacle_loc = spiral_range_turfs(5, get_turf(owner))
	owner.visible_message(span_danger("Tendrils rise from the bloodied floor!"))
	playsound(owner, 'sound/foley/bleed_apply.ogg', 80, TRUE)
	for(var/i in 1 to tentacle_amount)
		var/turf/t = pick_n_take(tentacle_loc)
		new /obj/effect/temp_visual/blood_tentacle(t, owner)


/datum/action/cooldown/spell/strangler/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.visible_message(span_danger("[H] raises her arms up, and blood follows!"))
	H.say("|i honor ser telemachus with this blood...|")
	var/old_time = world.time
	while(world.time < old_time + 15 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)
		spawntentacles(H)
		sleep(3 SECONDS)

/obj/effect/temp_visual/blood_tentacle
	name = "strangler"
	desc = "A tendril made out of blood. Why are you looking at this-- focus on the fight!"
	icon = 'icons/effects/effects.dmi'
	icon_state = "blood_tendril_spawn"
	layer = BELOW_MOB_LAYER
	var/mob/living/spawner
	var/timer_id

/obj/effect/temp_visual/blood_tentacle/Initialize(mapload, mob/living/new_spawner)
	. = ..()
	for(var/obj/effect/temp_visual/blood_tentacle/T in loc)
		if(T != src)
			return INITIALIZE_HINT_QDEL
	if(!QDELETED(new_spawner))
		spawner = new_spawner
	if(ismineralturf(loc))
		var/turf/closed/mineral/M = loc
		M.gets_drilled()
	if(timer_id)
		deltimer(timer_id)
	timer_id = addtimer(CALLBACK(src, PROC_REF(tripanim)), 7, TIMER_STOPPABLE)

/obj/effect/temp_visual/blood_tentacle/original/Initialize(mapload, new_spawner)
	. = ..()
	var/list/directions = GLOB.cardinals.Copy()
	for(var/i in 1 to 3)
		var/spawndir = pick_n_take(directions)
		var/turf/T = get_step(src, spawndir)
		if(T)
			new /obj/effect/temp_visual/blood_tentacle(T, spawner)

/obj/effect/temp_visual/blood_tentacle/proc/tripanim()
	icon_state = "blood_tendril_wiggle"
	if(timer_id)
		deltimer(timer_id)
	timer_id = addtimer(CALLBACK(src, PROC_REF(trip)), 3, TIMER_STOPPABLE)


/obj/effect/temp_visual/blood_tentacle/proc/trip()
	var/hit_something = FALSE

	for(var/mob/living/L in view(0, src))
		if(L == spawner || L.stat == DEAD || HAS_TRAIT(L, TRAIT_VENGEANCE))
			continue
		var/zone = pick(BODY_ZONE_CHEST, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		visible_message(span_danger("[src] grabs hold of [L], blood seeping through the armor!"))
		L.apply_damage(30, BRUTE, zone, 0)
		L.Stun(50)
		playsound(L, 'sound/foley/bleed.ogg', 80, TRUE)
		hit_something = TRUE
	if(!hit_something)
		retract()
	else
		deltimer(timer_id)
		timer_id = addtimer(CALLBACK(src, PROC_REF(retract)), 10, TIMER_STOPPABLE)

/obj/effect/temp_visual/blood_tentacle/proc/retract()
	icon_state = "blood_tendril_retract"
	if(timer_id)
		deltimer(timer_id)
	timer_id = null
	fade_time = 7
	QDEL_IN(src, 7)
