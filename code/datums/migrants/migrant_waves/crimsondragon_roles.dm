// anything that's related 2 crimson dragon & not a dmi is here (e.g. clothing defines, shell & podao code)
// obvs doesn't include trait defines (traits.dm) or thrill code (bodypart_wounds.dm)
// ! be warned - there's a lot here. ive tried my best to document everything using comments & !'s 
// ! sorry lol

#define PODAOWOOSH list('sound/foley/crimsondragon/draw.ogg', 'sound/foley/crimsondragon/draw2.ogg')

/datum/migrant_role/crimson_dragon
	name = "Crimson Dragon"
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
	wretch_select_bounty(H)

// unique items defined below, clothing first then shellcode, then vfx/dash helper, then weapon

/obj/item/clothing/suit/roguetown/armor/leather/studded/crimdragon
	name = "blood red silk"
	desc = "A silky, thin jacket ontop of an equally thin black shirt. Small, golden studs act as buttons. Pretty absorbant to blunting and slashing, on account of Lingyuese silk being rather tough."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonshirt"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/under/roguetown/heavy_leather_pants/crimdragon
	name = "stained silk pants"
	desc = "They say that pants like these are intentionally stained red in order to give off the appearance of blood."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonpants"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/gloves/roguetown/angle/crimdragon
	name = "maroon gloves"
	desc = "Lingyuese silk. Almost magic in how durabile it is, for how thin-and-stretchy the material actually is. Notoriously hard to source and work with, however."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragongloves"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/storage/belt/rogue/leather/plaquesilver/crimdragon
	name = "shell belt"
	desc = "Ignoring the golden buckle - this belt's lined with individual pouches made for holding propellant shells."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonbelt"
	populate_contents = list(
		/obj/item/dragonmark,
		/obj/item/dragonmark,
		/obj/item/dragonmark,
		/obj/item/dragonmark,
		/obj/item/dragonmark/savage,
		/obj/item/dragonmark/savage,
	)
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/shoes/roguetown/boots/leather/reinforced/crimdragon
	name = "leather shoes"
	desc = "Short, leather píxié. Usually associated with nobility."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonshoes"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/cloak/crimdragon
	name = "silk overcoat"
	desc = "A silky coat worn on the back. The wraps around the cuffs isn't real gold - it's simply made out of dyed silk."
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	icon_state = "crimsondragoncloak"
	item_state = "crimsondragoncloak"
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
	icon-state = "e_dragonslay"
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
	// this variable holds a flat force increase that is only applied on basic hits. it increases when ammo is spent, and gets reset on reload or unload
	// it decays on each hit that isn't part of a combo
	//! ..aaalso bypasses dodge/parry !
	var/overheat = 0
	var/overheat_decay = 1
	var/busy = FALSE // used to prevent certain actions while reloading or leaping
	// how long does the reload phase last?
	var/reload_windup = 0.6 SECONDS
	// we use this variable to hold the type of the current ammo
	var/current_ammo_type = null
	// we use this variable to hold the plural name of the current ammo. we shouldn't need a var for this, but dreamchecker is giving me a warning so I have to do it
	var/current_ammo_name = ""

