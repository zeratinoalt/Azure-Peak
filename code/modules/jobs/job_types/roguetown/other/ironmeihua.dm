/datum/job/roguetown/ironmeihua
	title = "Iron Meihua"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/roguetown/adventurer/ironmeihua
	allowed_sexes = list(FEMALE)
	forbidden_races = list(RACES_SMALL, RACES_CONSTRUCT, RACES_DESPISED)
	tutorial = "boss fight :)."

	cmode_music = 'sound/music/combat_zhiren.ogg'


/datum/outfit/job/roguetown/adventurer/ironmeihua/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/ironmeihua
	shoes = /obj/item/clothing/shoes/roguetown/boots/ironmeihua
// 	backr = /obj/item/storage/backpack/rogue/satchel
//	l_hand = /obj/item/rogueweapon/sword/sabre/yourturn
	mask = /obj/item/clothing/mask/rogue/blindfold/fake/meihua

	H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 7)
	H.change_stat(STATKEY_INT, 8)
	H.change_stat(STATKEY_CON, 5)
	H.change_stat(STATKEY_WIL, 5)
	H.change_stat(STATKEY_SPD, 8)


	H.dna.species.soundpack_f = new /datum/voicepack/female/ironmeihua()
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INFINITE_ENERGY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHARDCRIT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSOFTCRIT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)


	if(H.mind)
		H.mind.AddSpell(new /datum/action/cooldown/spell/emotionalturbulence)
		H.mind.AddSpell(new /datum/action/cooldown/spell/fleetinglife)
		H.mind.AddSpell(new /datum/action/cooldown/spell/ragingstorm)
		H.mind.AddSpell(new /datum/action/cooldown/spell/callofthedragon)
		H.mind.AddSpell(new /datum/action/cooldown/spell/burningembers)

/obj/item/clothing/suit/roguetown/armor/leather/studded/ironmeihua
	name = "HuàLóngLèiGǒu"
	desc = "A dress with gold detailing, long red sleeves, and a slit across the side."
	body_parts_covered = COVERAGE_FULL_BODY_ACTUAL
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = 3000
	slot_flags = ITEM_SLOT_ARMOR
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/sleeves_bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'
	icon_state = "meihua"
	sleevetype = "shirt"

/obj/item/clothing/shoes/roguetown/boots/ironmeihua
	name = "black shoes"
	desc = "Simple shoes. Cut down to expose the joints."
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'
	icon_state = "meihua_shoes"

/obj/item/clothing/mask/rogue/blindfold/fake/meihua
	name = "blind rage"
	desc = "A sheet of cloth that covers the heart."
	color = CLOTHING_DARK_GREY


/datum/intent/sword/cut/sabre/meihua
	hitsound = list('sound/foley/ironmeihua/whit1.ogg', 'sound/foley/ironmeihua/whit2.ogg', 'sound/foley/ironmeihua/whit3.ogg', 'sound/foley/ironmeihua/whit4.ogg', 'sound/foley/ironmeihua/whit5.ogg', 'sound/foley/ironmeihua/whit6.ogg')

/datum/intent/sword/cut/sabre/heavy/meihua
	hitsound = list('sound/foley/ironmeihua/whit1.ogg', 'sound/foley/ironmeihua/whit2.ogg', 'sound/foley/ironmeihua/whit3.ogg', 'sound/foley/ironmeihua/whit4.ogg', 'sound/foley/ironmeihua/whit5.ogg', 'sound/foley/ironmeihua/whit6.ogg')

/datum/intent/sword/thrust/sabre/meihua
	hitsound = list('sound/foley/ironmeihua/whit1.ogg', 'sound/foley/ironmeihua/whit2.ogg', 'sound/foley/ironmeihua/whit3.ogg', 'sound/foley/ironmeihua/whit4.ogg', 'sound/foley/ironmeihua/whit5.ogg', 'sound/foley/ironmeihua/whit6.ogg')

/datum/intent/sword/strike/meihua
	hitsound = list('sound/foley/ironmeihua/whit1.ogg', 'sound/foley/ironmeihua/whit2.ogg', 'sound/foley/ironmeihua/whit3.ogg', 'sound/foley/ironmeihua/whit4.ogg', 'sound/foley/ironmeihua/whit5.ogg', 'sound/foley/ironmeihua/whit6.ogg')

/obj/item/rogueweapon/sword/sabre/meihua
	name = "画虎类狗"
	desc = "To paint a tiger, only to end with a mere mutt."
	icon = 'icons/roguetown/weapons/special/bosses.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	icon_state = "meihua_sword"
	force = 40
	wdefense = 15
	possible_item_intents = list(/datum/intent/sword/cut/sabre/meihua, /datum/intent/sword/cut/sabre/heavy/meihua, /datum/intent/sword/thrust/sabre/meihua, /datum/intent/sword/strike/meihua)
	gripped_intents = null
	parrysound = list('sound/foley/ironmeihua/parry1.ogg', 'sound/foley/ironmeihua/parry2.ogg', 'sound/foley/ironmeihua/parry3.ogg')
	swingsound = BLADEWOOSH_SMALL
	max_blade_int = 700
	max_integrity = 700
	wbalance = WBALANCE_SWIFT
	special = /datum/special_intent/dagger_dash

/datum/intent/spear/thrust/meihua
	hitsound = list('sound/foley/ironmeihua/hit1.ogg', 'sound/foley/ironmeihua/hitblunt.ogg', 'sound/foley/ironmeihua/hitslash.ogg', 'sound/foley/ironmeihua/hitslashstrong.ogg')
	effective_range = null
	effective_range_type = EFF_RANGE_NONE

/datum/intent/spear/cut/meihua
	hitsound = list('sound/foley/ironmeihua/hit1.ogg', 'sound/foley/ironmeihua/hitblunt.ogg', 'sound/foley/ironmeihua/hitslash.ogg', 'sound/foley/ironmeihua/hitslashstrong.ogg')
	effective_range = null
	effective_range_type = EFF_RANGE_NONE

/datum/intent/rend/reach/partizan/meihua
	hitsound = list('sound/foley/ironmeihua/hit1.ogg', 'sound/foley/ironmeihua/hitblunt.ogg', 'sound/foley/ironmeihua/hitslash.ogg', 'sound/foley/ironmeihua/hitslashstrong.ogg')
	effective_range = null
	effective_range_type = EFF_RANGE_NONE

/datum/intent/spear/bash/meihua
	hitsound = list('sound/foley/ironmeihua/hit1.ogg', 'sound/foley/ironmeihua/hitblunt.ogg', 'sound/foley/ironmeihua/hitslash.ogg', 'sound/foley/ironmeihua/hitslashstrong.ogg')
	effective_range = null
	effective_range_type = EFF_RANGE_NONE

/obj/item/rogueweapon/spear/partizan/meihua
	name = "HuàLóngKèHú"
	desc = "It's sad, isn't it? That fire I saw in her eyes slowly died down into embers."
	force = 35
	max_blade_int = 700
	max_integrity = 700
	possible_item_intents = list(/datum/intent/spear/thrust/meihua, /datum/intent/spear/cut/meihua, /datum/intent/rend/reach/partizan/meihua, /datum/intent/spear/bash/meihua)
	gripped_intents = null
	icon_state = "meihua_spear"
	icon = 'icons/roguetown/weapons/special/bosses.dmi'
	icon_state = "meihua_spear"
	parrysound = list('sound/foley/ironmeihua/parry1.ogg', 'sound/foley/ironmeihua/parry2.ogg', 'sound/foley/ironmeihua/parry3.ogg')
	bigboy = 1
	wlength = WLENGTH_LONG
	associated_skill = /datum/skill/combat/polearms
	smeltresult = null
	override_state = null
	special = /datum/special_intent/meihua_spear


/obj/item/rogueweapon/spear/partizan/meihua/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
