//A Baothan-exclusive wretch slot.
//Arcane momentum user - locked to spells specific to that class.
//Focused on overwhelming opponents with nigh-endless revenants.
//Also, heavy armor. And they have a unique sword that's defined here.
//oh and also the finishers are defined here as well, they're tied to the sword
/datum/advclass/wretch/erlking
	name = "Erlking"
	tutorial = "The wrath within me burns. This heart of vengeance, of heartbreak - it will only learn to rest once I march 'pon that wretched manor. I am the ripping and tearing tempest that will bring about their ruin."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = /datum/patron/inhumen/baotha
	outfit = /datum/outfit/job/roguetown/wretch/erlking
	maximum_possible_slots = 1 //one must be alone in this pitiful bout of revenge
	class_select_category = CLASS_CAT_BATTLEMAGE
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_ARCYNE_T2, TRAIT_HEART_OF_VENGEANCE, TRAIT_WILDHUNT, TRAIT_SELFLOATHING)
	subclass_stats = list(
		STATKEY_STR = 1,
		STATKEY_INT = 1, // same as spellblade
		STATKEY_PER = 1, 
		STATKEY_CON = 1,
		STATKEY_WIL = 2,
	)
	subclass_skills = list(
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/magic/arcane = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/wretch/erlking/pre_equip(mob/living/carbon/human/H) // fill this out later
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	gloves = /obj/item/clothing/gloves/roguetown/chain
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
	r_hand = /obj/item/rogueweapon/sword/sabre/longing
	backpack_contents = list(/obj/item/flashlight/flare/torch = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	
		/obj/item/chalk = 1
	)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/beheading)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/memorialprocession)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/requiem)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/recall_weapon)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/empower_weapon)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/bind_weapon)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mending)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)

	var/subclass_selected = "blade"
	var/stack_fluff = "erlking"
	var/datum/status_effect/buff/arcyne_momentum/momentum = H.apply_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(momentum)
		momentum.chant = subclass_selected
		momentum.stack_effect = stack_fluff
	to_chat(H, span_warning("You start with Bind Weapon. Remember to Bind your weapon so you can use your abilities and build up Arcyne Momentum."))

/datum/intent/sword/cut/longing
	hitsound = list('sound/combat/hits/bladed/fusedcut (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedcut (3).ogg')

/datum/intent/sword/thrust/longing
	hitsound = list('sound/combat/hits/bladed/fusedthrust (1).ogg', 'sound/combat/hits/bladed/fusedthrust (2).ogg', 'sound/combat/hits/bladed/fusedthrust (3).ogg')

/datum/intent/sword/cut/zwei/longing
	hitsound = list('sound/combat/hits/bladed/fusedcut (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedcut (3).ogg')

/obj/item/rogueweapon/sword/sabre/longing
	name = "Fused Blade of Ruined Possibilities"
	desc = "A manifestation of an Erlking's self-loathing."
	possible_item_intents = list(/datum/intent/sword/cut/longing, /datum/intent/sword/thrust/longing, /datum/intent/sword/cut/zwei/longing, /datum/intent/sword/cut/zwei/sweep)
	//design intent - uhhhh. one handed greatsword is cool? and it allows 4 the user to have the coffin in the other hand
	force = 30
	parrysound = list(
		'sound/combat/parry/bladed/fused (1).ogg',
		'sound/combat/parry/bladed/fused (2).ogg',
		'sound/combat/parry/bladed/fused (3).ogg',
		)
	icon = 'icons/roguetown/weapons/swords64.dmi'
	icon_state = "ruinedblade"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	swingsound = BLADEWOOSH_HUGE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 300
	wdefense = 5
	var/behead = FALSE
	var/memorialprocession = FALSE
	var/requiem = FALSE
	var/beam_color = "#33096e"
	var/combo_sounds = list('sound/combat/hits/bladed/fusedcut (1).ogg', 'sound/combat/hits/bladed/fusedcut (2).ogg', 'sound/combat/hits/bladed/fusedcut (3).ogg')
	var/hits = 1 // how many hits the combo has
	var/obj/item/held_weapon = /obj/item/rogueweapon/sword/sabre/longing
/*below code is structured as the following:
first check to see if spells have been enabled
then try_[spellname] 
then the actual combo 
//basic proc flow is the following
/../afterattack -> try_[spellname] -> [spellname]_start + [spellname]_pick_target -> [spellname] -> [spellname]_end

the spells always attack one target, but its possible to chain a bunch of attacks together thats multi-hit and multi-target.
i'm not doing it here because i actually want this pr to be merged */

/obj/item/rogueweapon/sword/sabre/longing/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(behead)
		INVOKE_ASYNC(src, PROC_REF(try_behead), user, target)
	else if(memorialprocession)
		INVOKE_ASYNC(src, PROC_REF(try_memorialprocession), user, target)
	else if(requiem)
		INVOKE_ASYNC(src, PROC_REF(try_requiem), user, target)
	. = ..()

/// Shared dash helper: afterimage at origin, forceMove, colored beam trail, face target
/obj/item/rogueweapon/sword/sabre/longing/proc/combo_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/// Shared hit helper: sound, visual effect
/obj/item/rogueweapon/sword/sabre/longing/proc/combohit(mob/living/user, mob/living/target, effect_type)
	if(QDELETED(user) || QDELETED(target))
		return
	playsound(user, combo_sounds, 40, TRUE)
	user.do_attack_animation(target)
	if(effect_type)
		new effect_type(get_turf(target))

/obj/item/rogueweapon/sword/sabre/longing/proc/try_behead(mob/living/user, mob/living/target) //get targets 4 behead
	var/list/targets = list()
	for(var/mob/living/L in range(4, user))
		if(L == user)
			continue
		if(L.status_flags & GODMODE)
			continue
		if(L.stat == DEAD)
			continue
		targets += L

	if(!LAZYLEN(targets))
		to_chat(user, span_warning("There are no enemies nearby!"))
		return

	behead_start(user, targets)

	var/list/all_targets = targets.Copy()

	for(var/i in 1 to hits)
		target = behead_pick_target(targets)
		if(!target)
			break
		behead(user, targets)

	behead_end(user, all_targets)

/obj/item/rogueweapon/sword/sabre/longing/proc/behead_start(mob/living/user, list/targets) // it just stuns the targets for the cutscene
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	user.status_flags |= GODMODE
	user.Stun(60 SECONDS, ignore_canstun = TRUE)
	user.anchored = TRUE
	for(var/mob/living/L in targets)
		L.Stun(60 SECONDS, ignore_canstun = TRUE)
		walk(L, 0)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(AI_OFF)

/// Picks a valid living target from the list, removing dead/deleted ones. Returns null if none remain.
/obj/item/rogueweapon/sword/sabre/longing/proc/behead_pick_target(list/targets)
	var/mob/living/target = pick(targets)
	if(QDELETED(target) || target.stat == DEAD)
		targets -= target
		if(!LAZYLEN(targets))
			return null
		target = pick(targets)
		if(QDELETED(target))
			return null
	return target

/obj/item/rogueweapon/sword/sabre/longing/proc/behead(mob/living/user, mob/living/target, def_zone, heavy) //two strikes. summons 1 mob
	var/victim = target
	var/damage = 45
	var/effect_type = heavy ? /obj/effect/temp_visual/smash_effect/violetdark : /obj/effect/temp_visual/dir_setting/slash/violetdark
	hits = 2
	for(var/i in 1 to hits)
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Dash through target to the other side
		var/turf/dest = get_ranged_target_turf_direct(user, target, get_dist(user, target) + 2)
		if(!dest)
			dest = get_turf(target)
		combo_dash_to(user, dest, target, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CHOP, spell_name = "Behead")
		combohit(user, target, effect_type)
		if(heavy)
			shake_camera(target, 1, 2)
		sleep(0.3 SECONDS)

/obj/item/rogueweapon/sword/sabre/longing/proc/behead_end(mob/living/user, list/targets)
	user.status_flags &= ~GODMODE
	user.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
	user.anchored = FALSE
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

	for(var/mob/living/L in targets)
		L.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
		REMOVE_TRAIT(L, TRAIT_MUTE, TIMESTOP_TRAIT)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(initial(S.AIStatus))
	behead = FALSE

// memorial shit below

/obj/item/rogueweapon/sword/sabre/longing/proc/try_memorialprocession(mob/living/user, mob/living/target) //get targets 4 memorial
	var/list/targets = list()
	for(var/mob/living/L in range(4, user))
		if(L == user)
			continue
		if(L.status_flags & GODMODE)
			continue
		if(L.stat == DEAD)
			continue
		targets += L

	if(!LAZYLEN(targets))
		to_chat(user, span_warning("There are no enemies nearby!"))
		return

	memorialprocession_start(user, targets)

	var/list/all_targets = targets.Copy()

	for(var/i in 1 to hits)
		target = memorialprocession_pick_target(targets)
		if(!target)
			break
		memorialprocession(user, targets)

	memorialprocession_end(user, all_targets)

/obj/item/rogueweapon/sword/sabre/longing/proc/memorialprocession_start(mob/living/user, list/targets) // it just stuns the targets for the cutscene
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	user.status_flags |= GODMODE
	user.Stun(60 SECONDS, ignore_canstun = TRUE)
	user.anchored = TRUE
	for(var/mob/living/L in targets)
		L.Stun(60 SECONDS, ignore_canstun = TRUE)
		walk(L, 0)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(AI_OFF)

/// Picks a valid living target from the list, removing dead/deleted ones. Returns null if none remain.
/obj/item/rogueweapon/sword/sabre/longing/proc/memorialprocession_pick_target(list/targets)
	var/mob/living/target = pick(targets)
	if(QDELETED(target) || target.stat == DEAD)
		targets -= target
		if(!LAZYLEN(targets))
			return null
		target = pick(targets)
		if(QDELETED(target))
			return null
	return target

/obj/item/rogueweapon/sword/sabre/longing/proc/memorialprocession(mob/living/user, mob/living/target, def_zone) //3 strikes, 1 target. summons 3 mobs
	var/victim = target
	var/damage = 60
	var/turf/range_pos = get_ranged_target_turf_direct(target, user, 3)
	hits = 3
	if(range_pos && get_dist(user, target) != 3)
		combo_dash_to(user, range_pos, target, beam_color)
	playsound(user, 'sound/foley/memorialstart.ogg', 40)
	for(var/i in 1 to hits)
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		var/turf/dest = get_ranged_target_turf_direct(user, target, get_dist(user, target) + 2)
		if(!dest)
			dest = get_turf(target)
		combo_dash_to(user, dest, target, beam_color)
		combohit(user, target, /obj/effect/temp_visual/slice/violetdark)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CHOP, spell_name = "Memorial Precession")
		sleep(0.4 SECONDS)

/obj/item/rogueweapon/sword/sabre/longing/proc/memorialprocession_end(mob/living/user, list/targets)
	user.status_flags &= ~GODMODE
	user.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
	user.anchored = FALSE
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

	for(var/mob/living/L in targets)
		L.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
		REMOVE_TRAIT(L, TRAIT_MUTE, TIMESTOP_TRAIT)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(initial(S.AIStatus))
	memorialprocession = FALSE

//defines for objects that requiem uses

/obj/effect/temp_visual/coffin
	name = "coffin"
	icon_state = "coffin"
	duration = INFINITY

/obj/effect/decal/cleanable/blood/gibs/up/coffin
	color = "#33096e"

//finally, requiem time

/obj/item/rogueweapon/sword/sabre/longing/proc/try_requiem(mob/living/user, mob/living/target) //get targets 4 memorial
	var/list/targets = list()
	for(var/mob/living/L in range(4, user))
		if(L == user)
			continue
		if(L.status_flags & GODMODE)
			continue
		if(L.stat == DEAD)
			continue
		targets += L

	if(!LAZYLEN(targets))
		to_chat(user, span_warning("There are no enemies nearby!"))
		return

	requiem_start(user, targets)

	var/list/all_targets = targets.Copy()

	for(var/i in 1 to hits)
		target = requiem_pick_target(targets)
		if(!target)
			break
		requiem(user, targets)

	requiem_end(user, all_targets)

/obj/item/rogueweapon/sword/sabre/longing/proc/requiem_start(mob/living/user, list/targets) // it just stuns the targets for the cutscene
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	user.status_flags |= GODMODE
	user.Stun(60 SECONDS, ignore_canstun = TRUE)
	user.anchored = TRUE
	for(var/mob/living/L in targets)
		L.Stun(60 SECONDS, ignore_canstun = TRUE)
		walk(L, 0)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(AI_OFF)

/// Picks a valid living target from the list, removing dead/deleted ones. Returns null if none remain.
/obj/item/rogueweapon/sword/sabre/longing/proc/requiem_pick_target(list/targets)
	var/mob/living/target = pick(targets)
	if(QDELETED(target) || target.stat == DEAD)
		targets -= target
		if(!LAZYLEN(targets))
			return null
		target = pick(targets)
		if(QDELETED(target))
			return null
	return target

/obj/item/rogueweapon/sword/sabre/longing/proc/requiem(mob/living/user, mob/living/target, def_zone, heavy) //lets kill this guy bruh
	var/area/rogue/indoors/coffin/thecoffin = GLOB.areas_by_type[/area/rogue/indoors/coffin]
	var/victim = target
	var/damage = 60
	var/turf/victimspawnpoint
	var/turf/storedvictimturf = get_turf(victim)
	var/obj/effect/temp_visual/coffin/coffin_target
	var/pull_distance = 5
	hits = 7

	for(var/obj/effect/decal/cleanable/blood/gibs/up/coffin/body in thecoffin)
		victimspawnpoint = get_turf(body)

	if(ishuman(target))
		var/mob/living/carbon/human/H = target

	playsound(user, 'sound/foley/requiemstart.ogg', 40)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.throw_at(user, pull_distance, 1, H, FALSE)
		coffin_target = new /obj/effect/temp_visual/coffin(storedvictimturf)
		var/datum/beam/chain = user.Beam(coffin_target,icon_state="chain")
		playsound(user, 'sound/foley/requiemhit.ogg', 40)
		do_teleport(victim, victimspawnpoint)
		qdel(chain)
	for(var/i in 1 to hits)
		if(QDELETED(src) || QDELETED(user) || QDELETED(coffin_target))
			return
		var/turf/dest = get_step(coffin_target.loc, pick(GLOB.cardinals))
		if(!dest)
			dest = get_turf(coffin_target)
		combo_dash_to(user, dest, coffin_target, beam_color)
		combohit(user, coffin_target, /obj/effect/temp_visual/slice/violetdark)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CHOP, spell_name = "Requiem")
		sleep(0.15 SECONDS)
	sleep(0.2 SECONDS)
	do_teleport(victim, storedvictimturf)

/obj/item/rogueweapon/sword/sabre/longing/proc/requiem_end(mob/living/user, list/targets) //holy fuck are we done?
	user.status_flags &= ~GODMODE
	user.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
	user.anchored = FALSE
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

	for(var/mob/living/L in targets)
		L.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
		REMOVE_TRAIT(L, TRAIT_MUTE, TIMESTOP_TRAIT)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(initial(S.AIStatus))
	requiem = FALSE
