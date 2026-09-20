//arena time!
GLOBAL_LIST_EMPTY(meiwall)

/datum/action/cooldown/spell/emotionalturbulence
	button_icon = 'icons/mob/actions/classuniquespells/ironmeihua.dmi'
	name = "Emotional Turbulence"
	desc = "teleport u and one unlucky dude to a sectioned off part of the arena, duelling until they die or when their teammates break the tulpa"
	button_icon_state = "emotional"
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
	spell_requirements = SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z
	sound = 'sound/silence.ogg'

/datum/action/cooldown/spell/emotionalturbulence/proc/dash_to(mob/living/owner, turf/destination)
	var/turf/origin = get_turf(owner)
	var/list/first_hit = getline(origin, destination)
	for(var/turf/path_turf in first_hit)
		new /obj/effect/temp_visual/decoy/fading/halfsecond(path_turf)
		sleep(0.25 DECISECONDS)
	owner.forceMove(destination)
	owner.setDir(SOUTH)
	origin.Beam(owner, "meihua", time = 2)


/datum/action/cooldown/spell/emotionalturbulence/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/turf/anchorturf
	var/turf/anchorturf_challenged
	var/turf/wallturf
	var/turf/tulpaturf
	if(!istype(H))
		return FALSE

	H.say("..How long will you last?")
	playsound(H, 'sound/foley/ironmeihua/linespecial2.ogg', 80, FALSE)
	sleep(3 SECONDS)

	for(var/obj/structure/meihua_arena_anchor/anchor in GLOB.meianchor1)
		anchorturf = get_turf(anchor)

	for(var/obj/structure/meihua_arena_anchor_challenged/anchor2 in GLOB.meianchor2)
		anchorturf_challenged = get_turf(anchor2)

	var/mob/living/victim

	if(isliving(cast_on))
		victim = cast_on

	if(victim == H)
		return FALSE

	if(!anchorturf)
		return FALSE

	for(var/obj/structure/meihua_arena_wall_anchor/wallanchor in GLOB.meiarenawallanchor)
		wallturf = get_turf(wallanchor)
		new /obj/structure/meihuaarenawall(wallturf)

	for(var/obj/structure/meihua_anchor_tulpa/tulpa_anchor in GLOB.meianchor4)
		tulpaturf = get_turf(tulpa_anchor)
		new /obj/structure/meitulpa(tulpaturf)


	playsound(H, 'sound/foley/ironmeihua/prep.ogg', 80, TRUE)
	H.visible_message(span_userdanger("[H] blinks. Wait - where did she go?"))
	to_chat(victim, span_suicide("Wait - what the fuck?!"))
	dash_to(H, anchorturf)

	victim.forceMove(anchorturf_challenged)
	victim.setDir(NORTH)



/obj/structure/meitulpa
	name = "tulpa"
	desc = "A disgusting mass of writhing, burnt flesh."
	icon = 'icons/effects/64x64.dmi'
	icon_state = "tulpa"
	break_sound = 'sound/foley/crimsondragon/gibs.ogg'
	attacked_sound = list('sound/gore/flesh_eat_02.ogg', 'sound/gore/flesh_eat_05.ogg', 'sound/gore/flesh_eat_06.ogg')
	opacity = 0
	density = TRUE
	max_integrity = 400
	climbable = FALSE
	climb_time = 0
	pixel_x = -16
	pixel_y = -16

/obj/structure/meitulpa/Destroy()
	for(var/obj/structure/meihuaarenawall/arenawall in GLOB.meiwall)
		arenawall.Destroy()
	..()

/obj/structure/meihuaarenawall
	name = "flame wall"
	desc = "..It's too hot to pass through - and the flames threaten to melt anything that strikes it."
	icon = 'icons/effects/32x48.dmi'
	icon_state = "wall"
	density = TRUE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/meihuaarenawall/Initialize()
	. = ..()
	GLOB.meiwall += src

/obj/structure/meihuaarenawall/Destroy()
	GLOB.meiwall -= src
	..()
