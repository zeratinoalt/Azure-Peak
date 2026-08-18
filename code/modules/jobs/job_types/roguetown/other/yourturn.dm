/datum/job/roguetown/yourturn
	title = "???"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/roguetown/adventurer/yourturn
	allowed_sexes = list(MALE, FEMALE)
	forbidden_races = list(RACES_SMALL, RACES_CONSTRUCT, RACES_DESPISED)
	tutorial = "boss fight :)."

	cmode_music = 'sound/music/combat_yourturn.ogg'


/datum/outfit/job/roguetown/adventurer/yourturn/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = gloves = /obj/item/clothing/gloves/roguetown/eastgloves2/yourturn
	pants = /obj/item/clothing/under/roguetown/skirt/courtphysician/yourturn
	armor = /obj/item/clothing/suit/roguetown/shirt/courtphysician/female/yourturn
	shoes = /obj/item/clothing/shoes/courtphysician/female
	mask = /obj/item/clothing/mask/rogue/spectacles/inq_lesser_summoned/yourturn
	beltr = /obj/item/rogueweapon/scabbard/sword/strap
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel
	l_hand = /obj/item/rogueweapon/sword/sabre/yourturn
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpotnew = 2,
	)

	H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/blood, 5, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 7)
	H.change_stat(STATKEY_INT, 8)
	H.change_stat(STATKEY_CON, 5)
	H.change_stat(STATKEY_WIL, 5) 
	H.change_stat(STATKEY_SPD, 8)

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VENGEANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bind)
		H.mind.AddSpell(new /datum/action/cooldown/spell/blood_lance)
		H.mind.AddSpell(new /datum/action/cooldown/spell/strangler)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/bloodcrawl)
		H.mind.AddSpell(new /datum/action/cooldown/spell/companionship)

/obj/item/clothing/gloves/roguetown/eastgloves2/yourturn
	name = "sanguine gloves"
	desc = "..I'll wring the life out of her neck."

/obj/item/clothing/under/roguetown/skirt/courtphysician/yourturn
	desc = "Why does she have to be the shining moon, for everyone else? I-.. I don't want to be left behind."
	armor = ARMOR_LEATHER
	max_integrity = 3000

/obj/item/clothing/suit/roguetown/shirt/courtphysician/female/yourturn
	desc = "..Maybe then, I'll find peace."
	body_parts_covered = COVERAGE_FULL_BODY_ACTUAL
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = 3000
	slot_flags = ITEM_SLOT_ARMOR

/obj/item/clothing/mask/rogue/spectacles/inq_lesser_summoned/yourturn
	name = "red-stained glasses"
	desc = "It's your turn, now."

/datum/intent/sword/cut/sabre/yourturn
	hitsound = list('sound/foley/yourturn/goodbye_attack.ogg', 'sound/foley/yourturn/attack2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/cut/sabre/heavy/yourturn
	hitsound = list('sound/foley/yourturn/goodbye_attack.ogg', 'sound/foley/yourturn/attack2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/thrust/sabre/yourturn
	hitsound = list('sound/foley/yourturn/goodbye_attack.ogg', 'sound/foley/yourturn/attack2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/strike/yourturn
	hitsound = list('sound/foley/yourturn/goodbye_attack.ogg', 'sound/foley/yourturn/attack2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')



/obj/item/rogueweapon/sword/sabre/yourturn
	name = "Your Turn"
	desc = "It's too late to take things back."
	icon = 'icons/roguetown/weapons/swords64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	icon_state = "yourturn"
	sheathe_icon = "yourturn"
	force = 40
	wdefense = 15
	possible_item_intents = list(/datum/intent/sword/cut/sabre/yourturn, /datum/intent/sword/cut/sabre/heavy/yourturn, /datum/intent/sword/thrust/sabre/yourturn, /datum/intent/sword/strike/yourturn)
	gripped_intents = null
	parrysound = list('sound/foley/yourturn/spiral_mark.ogg', 'sound/foley/yourturn/special_start.ogg', 'sound/foley/yourturn/spiral_hit.ogg')
	swingsound = BLADEWOOSH_SMALL
	max_blade_int = 700
	max_integrity = 700
	wbalance = WBALANCE_SWIFT
	special = /datum/special_intent/dagger_dash

