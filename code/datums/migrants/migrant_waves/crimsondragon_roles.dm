// anything that's related 2 crimson dragon & not a dmi is here (e.g. clothing defines, shell & podao code)
// obvs doesn't include trait defines (traits.dm) or thrill code (bodypart_wounds.dm)
// ! be warned - there's a lot here. ive tried my best to document everything using comments & !'s 
// ! sorry lol

#define PODAOWOOSH list('sound/foley/crimsondragon/draw.ogg', 'sound/foley/crimsondragon/draw2.ogg')

/datum/migrant_role/crimson_dragon
	name = "Crimson Tiger"
	outfit = /datum/outfit/job/roguetown/adventurer/crimson_dragon
	greet_text = "You are a former officer of Lingyue's military - having long since abandoned your Kazengite overlords. With a bounty on your head placed by the Dynasty, you've now fled to Azure Peak in search of a new life as a mentor. \
	You hold no allegiences except for yourself and your desire for a challenging fight - though note that you are being hunted."
	allowed_sexes = list(MALE, FEMALE)
	forbidden_races = list(RACES_SMALL, RACES_CONSTRUCT, RACES_DESPISED)

/datum/outfit/job/roguetown/adventurer/crimson_dragon/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/angle/crimdragon
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/crimdragon
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/crimdragon
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/crimdragon
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/scabbard/sword/strap
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver/crimdragon
	backr = /obj/item/storage/backpack/rogue/satchel
	cloak = /obj/item/clothing/cloak/crimdragon
	l_hand = /obj/item/rogueweapon/sword/sabre/podao
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpotnew = 2,
	)

	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_WIL, 2) 
	H.change_stat(STATKEY_SPD, -1) // same shit as unknightly journey on account of spawning in w/ a bounty - totally up 4 discussion i just code in cool shit

	H.dna.species.soundpack_m = new /datum/voicepack/male/crimsondragon()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/combat_crimsondragon.ogg'

	if(H.mind)
		H.mind.AddSpell(new /datum/action/cooldown/spell/doubleslash)
		H.mind.AddSpell(new /datum/action/cooldown/spell/tripleslash)
		H.mind.AddSpell(new /datum/action/cooldown/spell/scatterslash)
// unique items defined below, clothing first then shellcode, then vfx/dash helper, then weapon

/obj/item/clothing/suit/roguetown/armor/leather/studded/crimdragon
	name = "blood red silk"
	desc = "A silky, thin jacket ontop of an equally thin black shirt. Small, golden studs act as buttons. Pretty absorbant to blunting and slashing, on account of Lingyuese silk being rather tough."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonshirt"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/under/roguetown/heavy_leather_pants/crimdragon
	name = "stained silk pants"
	desc = "They say that pants like these are intentionally stained red in order to give off the appearance of blood."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonpants"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/gloves/roguetown/angle/crimdragon
	name = "maroon gloves"
	desc = "Lingyuese silk. Almost magic in how durabile it is, for how thin-and-stretchy the material actually is. Notoriously hard to source and work with, however."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragongloves"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/storage/belt/rogue/leather/plaquesilver/crimdragon
	name = "shell belt"
	desc = "Ignoring the golden buckle - this belt's lined with individual pouches made for holding propellant shells."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonbelt"

/obj/item/clothing/shoes/roguetown/boots/leather/reinforced/crimdragon
	name = "leather shoes"
	desc = "Short, leather píxié. Usually associated with nobility."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonshoes"

/obj/item/clothing/cloak/crimdragon
	name = "silk overcoat"
	desc = "A silky coat worn on the back. The wraps around the cuffs isn't real gold - it's simply made out of dyed silk."
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	icon_state = "crimsondragoncoat"
	item_state = "crimsondragoncoat"
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = FALSE
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	allowed_race = NON_DWARVEN_RACE_TYPES

/////////////////////////////
// ! Shell Code Start ! //
/////////////////////////////


/obj/item/dragonmark
	name = "dragonmark shell"
	desc = "Powerful propellant shells. These aren't fired at targets, but are instead detonated to provide additional propulsion to swings and stabs of Lingyuese weaponry. Rather expensive to purchase and keep in storage, hence their rarity outside of Lingyue."
	icon_state = "dragon"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/roguetown/weapons/special/crimdragonshells.dmi'
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	sellprice = 40

/obj/item/dragonmark/savage
	name = "savage dragonmark shell"
	desc = "Each detonation sounds like the roar of a dragon."
	icon_state = "dragonslay"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/roguetown/weapons/special/crimdragonshells.dmi'
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	sellprice = 60

/obj/item/dragonmark/empty
	name = "spent dragonmark shell"
	desc = "Firm as a Great Mountain."
	icon_state = "e_dragon"
	sellprice = 20

/obj/item/dragonmark/savage/empty
	name = "spent savage dragonmark shell"
	desc = "Hugging Fire, Sitting on Brushwood."
	icon_state = "e_dragonslay"
	sellprice = 30


// ! Design Intent Below !
//underpar in terms of DPS w/o ammo - using ammo makes it very scary.
//heat decays with each strike - to encourage loading in more shells for sustained fights

/datum/intent/sword/cut/podao
	hitsound = list('sound/combat/hits/bladed/crimsontiger/slash1.ogg', 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/cut/zwei/cleave/podao
	hitsound = list('sound/combat/hits/bladed/crimsontiger/slash1.ogg', 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/cut/zwei/sweep/podao
	hitsound = list('sound/combat/hits/bladed/crimsontiger/slash1.ogg', 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/obj/item/rogueweapon/sword/sabre/podao
	name = "winged podao"
	desc = "A one-handed sword with large exhaust ports protruding out of blade's spine. This piece is incredibly expensive & complex to forge - akin to the complexity of a Construct."
	possible_item_intents = list(/datum/intent/sword/cut/podao, /datum/intent/sword/cut/zwei/cleave/podao, /datum/intent/sword/cut/zwei/sweep/podao)
	force = 20
	parrysound = list(
		'sound/combat/parry/bladed/crimsontiger/parry1.ogg',
		'sound/combat/parry/bladed/crimsontiger/parry2.ogg',
		'sound/combat/parry/bladed/crimsontiger/parry3.ogg',
		)
	icon = 'icons/roguetown/weapons/special/crimdragonweapon.dmi'
	icon_state = "podao_closed"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	swingsound = PODAOWOOSH
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 300
	wdefense = 7
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	wbalance = WBALANCE_NORMAL
	// number of shells inside
	var/shells = 6
	// number of spent shells
	var/spent = 0
	// whenever or not we're empty - only caused by a reload failure
	var/empty = FALSE
	// whenever or not we're currently using savage dragonmarks
	var/savagemark = FALSE
	// this variable holds a flat force increase that is only applied on basic hits. it increases when ammo is spent, and gets reset on reload or unload
	// it decays on each hit that isn't part of a combo
	//! ..aaalso bypasses dodge/parry !
	var/overheat = 0
	var/overheat_decay = 1
	var/busy = FALSE // used to prevent certain actions while reloading or leaping
	// how long does the reload phase last?
	var/reload_windup = 2 SECONDS
	// we use this variable to hold the type of the current ammo
	var/current_ammo_type = null
	// we use this variable to hold the plural name of the current ammo. we shouldn't need a var for this, but dreamchecker is giving me a warning so I have to do it
	var/current_ammo_name = ""
	special = /datum/special_intent/podao_cleave


/obj/item/rogueweapon/sword/sabre/podao/get_mechanics_examine(mob/user)
	. = ..()
	. += span_info("This weapon has two separate modes, an overheat mechanic, and a reload mechanic.")
	. += span_info("Using the accopmanying skills found in the bottom left of your screen spends shells, which generates Overheat with each spent shell. Overheat deals unavoidable burn damage to the target, equal to the stack, and decays by one every hit.")
	. += span_info("Right-clicking the podao will cause you to swap shell-types (between normal Dragonmark and Savage Dragonmark). This grants you access to enhanced skills at the cost of heavily reduced weapon defense & forces you into a Reload.")
	. += span_info("Using Savage Dragonmark shells comes at the cost of introducing RNG checks into your skills. Failing these checks will massively reduce your damage.")
	. += span_info("Every skill can boosted by detonating a shell, which increases damage.")
	. += span_info("Using the podao in-hand will trigger a reload, which can be interrupted. Reloading also resets your Overheat stack.")

/obj/item/rogueweapon/sword/sabre/podao/attack_self(mob/user)
	// this first section is the reload start. you can cancel it, with the only consequence at this point being that you lose your overheat bonus
	if(busy)
		return
	playsound(src, 'sound/foley/crimsondragon/loadstart.ogg', 90, FALSE, 10)
	to_chat(user, span_info("You begin loading your [src.name]..."))
	VentHeat(user)
	busy = TRUE

	var/og_icon = initial(icon_state)
	var/should_close = FALSE
	if((og_icon == "podao_closed"))
		should_close = TRUE
		icon_state = "podao_open"

	if(do_after(user, reload_windup, src, progress = TRUE))
		// if we reached this line, we've started the reload properly now. being interrupted at this point causes a ReloadFailure(), you will spill the ammo you're loading

		// check how many total shells we have and then eject em all - should always be six but who knows
		if(!empty)
			INVOKE_ASYNC(src, PROC_REF(EjectRound), user)


		// the actual reload. really simply variable manipulation - just play a sound, set shells to 6 and spent to 0, and turn off empty
		playsound(src, 'sound/foley/crimsondragon/loading.ogg')
		spent = 0
		shells = 6
		empty = FALSE
		if(should_close)
			icon_state = og_icon
			should_close = FALSE
		// if we reach this else block - basically our reload got interrupted in some way (either thru being attacked/swapping hands/moving/etc.) so we spawn some shells and scatter it around
		else
			playsound(src, 'sound/foley/crimsondragon/ammodrop.ogg', 100, FALSE, 6)
			user.visible_message(span_danger("[user] fumbles while reloading, spilling shells onto the floor!"), span_danger("You fumble while reloading, spilling the shells onto the floor!"))
			busy = FALSE
			if(should_close)
				icon_state = og_icon
				should_close = FALSE
			return FALSE
	// we only reach this part if we successfully loaded the rounds we wanted to load. play the reload_end_sound with a small delay so it sounds nicer.
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/foley/crimsondragon/loadend.ogg', 90, FALSE, 10), 0.2 SECONDS)
	busy = FALSE


//dogshit code but basically: check if we're using savagemarks, then for every shell/spent shell we spawn in a new one & fling it around
/obj/item/rogueweapon/sword/sabre/podao/proc/EjectRound(mob/living/user)
	var/ejected_shell
	var/spent_shell

	if(savagemark)
		ejected_shell = /obj/item/dragonmark/savage
		spent_shell = /obj/item/dragonmark/savage/empty
	else
		ejected_shell = /obj/item/dragonmark
		spent_shell = /obj/item/dragonmark/empty

	// this block is adapted code from actual bullet casings for SS13 guns. we just slightly randomize its pixel offsets and throw it somewhere nearby
	for(var/i in shells)
		var/obj/item/dragonmark/shell_to_eject = new(ejected_shell, src)
		if(ejected_shell)
			shell_to_eject.pixel_x = shell_to_eject.base_pixel_x + rand(-7, 7)
			shell_to_eject.pixel_y = shell_to_eject.base_pixel_y + rand (-7, 7)
			var/turf/destination = get_ranged_target_turf(user, pick(GLOB.alldirs), 1)
			shell_to_eject.throw_at(destination, rand(1, 2), 6, spin = TRUE)
			shell_to_eject.setDir(pick(GLOB.alldirs))

	for(var/s in spent)
		var/obj/item/dragonmark/spent_shell_to_eject = new(spent_shell, src)
		if(spent_shell)
			spent_shell_to_eject.pixel_x = spent_shell_to_eject.base_pixel_x + rand(-7, 7)
			spent_shell_to_eject.pixel_y = spent_shell_to_eject.base_pixel_y + rand (-7, 7)
			var/turf/destination = get_ranged_target_turf(user, pick(GLOB.alldirs), 1)
			spent_shell_to_eject.throw_at(destination, rand(1, 2), 6, spin = TRUE)
			spent_shell_to_eject.setDir(pick(GLOB.alldirs))

	spent = 0
	shells = 0
	empty = TRUE
	sleep(1)

//resets overheat
/obj/item/rogueweapon/sword/sabre/podao/proc/VentHeat(mob/living/carbon/human/user)
	if(overheat > 0)
		playsound(src, 'sound/items/steamrelease.ogg', 75, FALSE, 4)
		to_chat(user, span_danger("You vent [src]'s remaining heat to access the internal shell storage!"))
	overheat = 0

// simple savagemark check and then copy/pasted attack_self code
/obj/item/rogueweapon/sword/sabre/podao/rmb_self(mob/user)
	if(busy)
		return
	if(!savagemark)
		savagemark = TRUE
		to_chat(user, span_danger("I will now use Savage Dragonmark shells."))
	else
		savagemark = FALSE
		to_chat(user, span_danger("I've decided to use normal Dragonmark shells."))
	playsound(src, 'sound/foley/crimsondragon/loadstart.ogg', 90, FALSE, 10)
	to_chat(user, span_info("You begin loading your [src.name]..."))
	VentHeat(user)
	busy = TRUE

//and now the copy/paste
	var/og_icon = initial(icon_state)
	var/should_close = FALSE
	if((og_icon == "podao_closed"))
		should_close = TRUE
		icon_state = "podao_open"

	if(do_after(user, reload_windup, src, progress = TRUE))
		if(!empty)
			INVOKE_ASYNC(src, PROC_REF(EjectRound), user)
		playsound(src, 'sound/foley/crimsondragon/loading.ogg')
		spent = 0
		shells = 6
		empty = FALSE
		if(should_close)
			icon_state = og_icon
			should_close = FALSE
		else
			playsound(src, 'sound/foley/crimsondragon/ammodrop.ogg', 100, FALSE, 6)
			user.visible_message(span_danger("[user] fumbles while reloading, spilling shells onto the floor!"), span_danger("You fumble while reloading, spilling the shells onto the floor!"))
			busy = FALSE
			if(should_close)
				icon_state = og_icon
				should_close = FALSE
			return FALSE
	busy = FALSE
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/foley/crimsondragon/loadend.ogg', 90, FALSE, 10), 0.2 SECONDS)

