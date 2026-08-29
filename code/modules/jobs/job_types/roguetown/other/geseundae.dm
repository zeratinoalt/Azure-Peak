/datum/job/roguetown/geseundae
	title = "Geseundae"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/roguetown/adventurer/geseundae
	allowed_sexes = list(MALE)
	forbidden_races = list(RACES_SMALL, RACES_CONSTRUCT, RACES_DESPISED)
	tutorial = "boss fight :)."

	cmode_music = 'sound/music/combat_geseundae.ogg'


/datum/outfit/job/roguetown/adventurer/geseundae/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/shadowpants/geseundae
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/geseundae
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1/geseundae
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/short/geseundae
	beltr = /obj/item/rogueweapon/scabbard/sword/strap
	belt = /obj/item/storage/belt/rogue/leather/black/geseundae
	mouth = /obj/item/clothing/neck/roguetown/collar/geseundae
	l_hand = /obj/item/rogueweapon/sword/sabre/geseundae

	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	H.change_stat(STATKEY_STR, 5)
	H.change_stat(STATKEY_PER, 5)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_CON, 8)
	H.change_stat(STATKEY_WIL, 8)
	H.change_stat(STATKEY_SPD, 3)

	H.dna.species.soundpack_m = new /datum/voicepack/male/geseundae()

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bind)
		H.mind.AddSpell(new /datum/action/cooldown/spell/slashseries)
		H.mind.AddSpell(new /datum/action/cooldown/spell/rendingarts)
		H.mind.AddSpell(new /datum/action/cooldown/spell/ripplingcuts)
		H.mind.AddSpell(new /datum/action/cooldown/spell/falloftheblade)

/obj/item/clothing/under/roguetown/heavy_leather_pants/shadowpants/geseundae
	name = "???"
	desc = "The shadows claw at my body."

/obj/item/clothing/suit/roguetown/armor/leather/studded/geseundae

	name = "shadow-vested form"
	desc = "A black dobo robe that opens up to reveal several, pale eyes."
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/sleeves_bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'
	icon_state = "geseundae"
	allowed_race = NON_DWARVEN_RACE_TYPES
	body_parts_covered = COVERAGE_FULL_BODY_ACTUAL
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = 3000

/obj/item/clothing/suit/roguetown/armor/leather/studded/geseundae/Initialize(mapload)
	..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/leather/studded/geseundae/dropped(mob/living/carbon/human/user)
	..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1/geseundae
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "???"
	desc = "There's nothing underneath."
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "geseundaeshirt"
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/sleeves_bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'

/obj/item/clothing/shoes/roguetown/boots/leather/reinforced/short/geseundae
	name = "???"
	desc = "They're just normal shoes."

/obj/item/storage/belt/rogue/leather/black/geseundae
	name = "???"
	desc = "There's nothing here - yet the regret still clings to you."
	icon_state = ""

/obj/item/clothing/neck/roguetown/collar/geseundae
	name = "flaming eye"
	desc = "A blue, flaming eye."
	icon_state = "geseundaeeye"
	item_state = "geseundaeeye"
	slot_flags = ITEM_SLOT_MOUTH
	salvage_result = /obj/item/natural/cloth
	salvage_amount = 1
	muteinmouth = FALSE
	spitoutmouth = FALSE
	sewrepair = TRUE
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'
	layer = HALO_LAYER

/obj/item/clothing/mask/rogue/geseundae
	name = "???"
	desc = "It's your face."
	icon_state = "geseundaeface"
	blocksound = SOFTHIT
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	max_integrity = 200
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDEFACE|HIDESNOUT|HIDEHAIR|HIDEEARS
	body_parts_covered = FACE|HEAD
	icon = 'icons/roguetown/clothing/special/bosses.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/bosses.dmi'

/datum/intent/sword/cut/sabre/geseundae
	hitsound = list('sound/foley/geseundae/hit1.ogg', 'sound/foley/geseundae/hit2.ogg', 'sound/foley/geseundae/hit3.ogg', 'sound/foley/geseundae/hit4.ogg', 'sound/foley/geseundae/hit5.ogg',)

/datum/intent/sword/cut/sabre/heavy/geseundae
	hitsound = list('sound/foley/geseundae/hit1.ogg', 'sound/foley/geseundae/hit2.ogg', 'sound/foley/geseundae/hit3.ogg', 'sound/foley/geseundae/hit4.ogg', 'sound/foley/geseundae/hit5.ogg',)

/datum/intent/sword/thrust/sabre/geseundae
	hitsound = list('sound/foley/geseundae/hit1.ogg', 'sound/foley/geseundae/hit2.ogg', 'sound/foley/geseundae/hit3.ogg', 'sound/foley/geseundae/hit4.ogg', 'sound/foley/geseundae/hit5.ogg',)

/datum/intent/sword/strike/geseundae
	hitsound = list('sound/foley/geseundae/hit1.ogg', 'sound/foley/geseundae/hit2.ogg', 'sound/foley/geseundae/hit3.ogg', 'sound/foley/geseundae/hit4.ogg', 'sound/foley/geseundae/hit5.ogg',)


/obj/item/rogueweapon/sword/sabre/geseundae
	name = "참수당함"
	desc = "Small, black hands continue to wrap around the blade."
	icon = 'icons/roguetown/weapons/special/bosses.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	icon_state = "geseundae"
	force = 40
	wdefense = 15
	possible_item_intents = list(/datum/intent/sword/cut/sabre/geseundae, /datum/intent/sword/cut/sabre/heavy/geseundae, /datum/intent/sword/thrust/sabre/geseundae, /datum/intent/sword/strike/geseundae)
	gripped_intents = null
	parrysound = list('sound/foley/geseundae/parry1.ogg', 'sound/foley/geseundae/parry2.ogg', 'sound/foley/geseundae/parry3.ogg')
	swingsound = list('sound/foley/geseundae/swing1.ogg', 'sound/foley/geseundae/swing2.ogg', 'sound/foley/geseundae/swing3.ogg')
	max_blade_int = 700
	max_integrity = 700
	wbalance = WBALANCE_SWIFT
	special = /datum/special_intent/limbguard
