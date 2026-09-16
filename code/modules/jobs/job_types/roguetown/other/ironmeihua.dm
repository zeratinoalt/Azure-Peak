/datum/job/roguetown/ironmeihua
	title = "Iron Meihua"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/roguetown/adventurer/ironmeihua
	allowed_sexes = list(FEMALE)
	forbidden_races = list(RACES_SMALL, RACES_CONSTRUCT, RACES_DESPISED)
	tutorial = "boss fight :)."

	cmode_music = 'sound/music/combat_yourturn.ogg'


/datum/outfit/job/roguetown/adventurer/ironmeihua/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/shirt/ironmeihua
	shoes = /obj/item/clothing/shoes/roguetown/boots/ironmeihua
	backr = /obj/item/storage/backpack/rogue/satchel
	l_hand = /obj/item/rogueweapon/sword/sabre/yourturn

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

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INFINITE_ENERGY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHARDCRIT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSOFTCRIT, TRAIT_GENERIC)


	if(H.mind)
		H.mind.AddSpell(new /datum/action/cooldown/spell/emotionalturbulence)
		H.mind.AddSpell(new /datum/action/cooldown/spell/fleetinglife)
		H.mind.AddSpell(new /datum/action/cooldown/spell/ragingstorm)
		H.mind.AddSpell(new /datum/action/cooldown/spell/callofthedragon)

/obj/item/clothing/suit/roguetown/shirt/ironmeihua
	name = "crimson cheongsam"
	desc = "A dress with gold detailing, long red sleeves, and a slit across the side."
	body_parts_covered = COVERAGE_FULL_BODY_ACTUAL
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = 3000
	slot_flags = ITEM_SLOT_ARMOR
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/sleeves_bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'

/obj/item/clothing/shoes/roguetown/boots/ironmeihua
	name = "black shoes"
	desc = "Simple shoes. Cut down to expose the joints."
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'
	icon_state = "meihua_shoes"
