// anything that's related 2 crimson dragon & not a dmi is here (e.g. clothing defines, shell & podao code)
// obvs doesn't include trait defines (traits.dm) or thrill code (bodypart_wounds.dm)

#define CTAG_CD_DRAGON "CTAG_CD_DRAGON"

/datum/migrant_role/crimson_dragon
	name = "Crimson Dragon"
	advclass_cat_rolls = list(CTAG_CD_DRAGON = 20)

//
// CHANGE BELOW STUFF LATER!!
//
/datum/advclass/crimson_dragon
	name = "Knight"
	tutorial = "You are a knight from a distant land, a scion of a noble house visiting Azuria for one reason or another."
	allowed_sexes = list(MALE, FEMALE)
	forbidden_races = list(RACES_CONSTRUCT RACES_DESPISED)
	outfit = /datum/outfit/job/roguetown/adventurer/knighte_expert
	traits_applied = list(TRAIT_NOBLE, TRAIT_HEAVYARMOR, TRAIT_STEELHEARTED)
	category_tags = list(CTAG_CD_DRAGON)
	townie_contract_gate_exempt = TRUE
	townie_contract_gate_hide_in_list = TRUE
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_INT = 1,
		STATKEY_CON = 1,
		STATKEY_WIL = 1,
		STATKEY_PER = 2,
	)
	subclass_skills = list(
		/datum/skill/misc/riding= SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/polearms= SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces= SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords= SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives= SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/shields= SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/whipsflails= SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling= SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming= SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed= SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics= SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing= SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading= SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/adventurer/knighte_expert/pre_equip(mob/living/carbon/human/H)
	..()
	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"			= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Armet"				= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
		"Hounskull Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"Slitted Kettle"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle,
		"None"
		)
	var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine,
		"Coat of Plates"	= /obj/item/clothing/suit/roguetown/armor/brigandine/heavy,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/cuirass,
		"Fluted Cuirass"	= /obj/item/clothing/suit/roguetown/armor/plate/cuirass/fluted,
		"Scalemail"		= /obj/item/clothing/suit/roguetown/armor/plate/scale,
		)
	var/armorchoice = input(H, "Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/tabard/stabard
	neck = /obj/item/clothing/neck/roguetown/bevor
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/steel/tasset
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/recipe_book/survival = 1,
		)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.set_blindness(0)
	var/weapons = list("Longsword + Shield","Mace + Shield","Flail + Shield","Billhook","Lance + Kite Shield","Battle Axe","Greataxe")
	var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Longsword + Shield")
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_MASTER, TRUE)
			beltr = /obj/item/rogueweapon/sword/long
			r_hand = /obj/item/rogueweapon/scabbard/sword
			backr = /obj/item/rogueweapon/shield/tower/metal
		if("Mace + Shield")
			H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_MASTER, TRUE)
			beltr = /obj/item/rogueweapon/mace
			backr = /obj/item/rogueweapon/shield/tower/metal
		if("Flail + Shield")
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_MASTER, TRUE)
			beltr = /obj/item/rogueweapon/flail
			backr = /obj/item/rogueweapon/shield/tower/metal
		if("Billhook")
			H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_EXPERT, TRUE)
			r_hand = /obj/item/rogueweapon/spear/billhook
			backr = /obj/item/rogueweapon/scabbard/gwstrap
		if("Lance + Kite Shield")
			H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_MASTER, TRUE)
			r_hand = /obj/item/rogueweapon/spear/lance
			backr = /obj/item/rogueweapon/shield/tower/metal
		if("Battle Axe")
			H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
			r_hand = /obj/item/rogueweapon/stoneaxe/battle
		if("Greataxe")
			H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
			r_hand = /obj/item/rogueweapon/greataxe
			backr = /obj/item/rogueweapon/scabbard/gwstrap

// unique items defined below, clothing first then shellcode, then vfx/dash helper, then weapon

/obj/item/clothing/suit/roguetown/armor/leather/studded/crimdragon
	name = "blood red silk"
	desc = "A silky, thin jacket ontop of an equally thin black shirt. Small, golden studs act as buttons. Pretty absorbant to blunting and slashing, on account of Lingyuanese silk being rather tough."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonshirt"

/obj/item/clothing/under/roguetown/heavy_leather_pants/crimdragon
	name = "stained silk pants"
	desc = "They say that pants like these are intentionally stained red in order to give off the appearance of blood."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonpants"

/obj/item/clothing/gloves/roguetown/angle/crimdragon
	name = "maroon gloves"
	desc = "Lingyuanese silk. Almost magic in how durabile it is, for how thin-and-stretchy the material actually is. Notoriously hard to source and work with, however."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragongloves"

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


/////////////////////////////
// ! Shell Code Start ! //
/////////////////////////////


/obj/item/dragonmark
	name = "dragonmark shell"
	desc = "Powerful propellant shells. These aren't fired at targets, but are instead detonated to provide additional propulsion to swings and stabs of Lingyuanese weaponry. Rather expensive to purchase and keep in storage, hence their rarity outside of Lingyuan."
	icon_state = "dragon1"
	w_class = WEIGHT_CLASS_NORMAL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	/// what item does this turn into when it gets spent?
	var/spent_type = /obj/item/dragonmark/spent
	// controls how much overheat is generated when spending this shell. it's a decaying flat force increase on non-combo hits that gets cleared on reload
	// comes in the form of added burn damage
	// please never make this negative
	var/heat_generation = 2
	sellprice = 40

/obj/item/dragonmark/savage
	name = "savage dragonmark shell"
	desc = "Extremely powerful propellant shells. Each detonation sounds like the roar of a dragon."
	icon_state = "dragonslay1"
	w_class = WEIGHT_CLASS_NORMAL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	spent_type = /obj/item/dragonmark/savage/spent
	heat_generation = 7
	sellprice = 60

/obj/item/natural/bundle/dragonmark
	name = "slew of dragonmark shells"
	icon_state = "dragon2"
	possible_item_intents = list(/datum/intent/use)
	desc = "Life Hanging on a Blade, a Single Life."
	force = 0
	throwforce = 0
	maxamount = 6
	obj_flags = null
	color = null
	firefuel = null
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	experimental_inhand = TRUE
	stacktype = /obj/item/dragonmark
	stackname = "dragonmark shells"
	icon1 = "dragon2"
	icon1step = 2
	icon2 = "dragon4"
	icon2step = 4
	icon3 = "dragon6"

/obj/item/natural/bundle/dragonmark/full
	amount = 6

/obj/item/natural/bundle/dragonmarksavage
	name = "slew of savage dragonmark shells"
	icon_state = "dragonslay2"
	possible_item_intents = list(/datum/intent/use)
	desc = "Roar of the Dragon."
	force = 0
	throwforce = 0
	maxamount = 6
	obj_flags = null
	color = null
	firefuel = null
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	experimental_inhand = TRUE
	stacktype = /obj/item/dragonmark/savage
	stackname = "dragonmark shells"
	icon1 = "dragon2"
	icon1step = 2
	icon2 = "dragon4"
	icon2step = 4
	icon3 = "dragon6"

/obj/item/natural/bundle/dragonmarksavage/full
	amount = 6
/////////////////////////////
// ! Spent Ammo Below ! //
// ! Don't put this in the accepted ammo table pls ! //
/////////////////////////////

/obj/item/dragonmark/spent
	name = "spent dragonmark shell"
	desc = "A spent dragonmark shell. The alloy's still valuable, despite the lack of propellant."
	icon_state = "e_dragon1"
	w_class = WEIGHT_CLASS_TINY
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	sell_price = 5
	sellprice = 20
	heat_generation = 0

/obj/item/dragonmark/savage/spent
	name = "spent savage dragonmark shell"
	desc = "An empty savage dragonmark shell. The propellant's all spent, but both the alloy used to withstand such a forceful blast & its craftsmanship is still worth some coin."
	icon_state = "e_dragonslay1"
	w_class = WEIGHT_CLASS_TINY
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	sellprice = 30
	heat_generation = 0

/obj/item/natural/bundle/spentdragonmark
	name = "slew of spent dragonmark shells"
	icon_state = "e_dragonslay2"
	possible_item_intents = list(/datum/intent/use)
	desc = "Scattered Ardor, Smothered Sentiment."
	force = 0
	throwforce = 0
	maxamount = 6
	obj_flags = null
	color = null
	firefuel = null
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	experimental_inhand = TRUE
	stacktype = /obj/item/dragonmark/spent
	stackname = "spentdragonmark shells"
	icon1 = "dragon2"
	icon1step = 2
	icon2 = "dragon4"
	icon2step = 4
	icon3 = "dragon6"

/obj/item/natural/bundle/spentdragonmark/full
	amount = 6

/obj/item/natural/bundle/spentsavagedragonmark
	name = "slew of spent savage dragonmark shells"
	icon_state = "e_dragon2"
	possible_item_intents = list(/datum/intent/use)
	desc = "Levinfall - 龍淚成濤."
	force = 0
	throwforce = 0
	maxamount = 6
	obj_flags = null
	color = null
	firefuel = null
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	experimental_inhand = TRUE
	stacktype = /obj/item/dragonmark/spent
	stackname = "spentdragonmark shells"
	icon1 = "dragon2"
	icon1step = 2
	icon2 = "dragon4"
	icon2step = 4
	icon3 = "dragon6"

/////////////////////////////
// ! Shell Code End ! //
/////////////////////////////

/////////////////////////////
// ! VFX Code Start ! //
/////////////////////////////

/obj/effect/temp_visual/crimdragon_impact
	name = "scorched earth"
	desc = "It smells like gunpowder."
	duration = 1 SECONDS
	icon = 'icons/effects/fire.dmi'
	icon_state = "flames"
	color = "#6e162c"
	alpha = 100
	layer = MASSIVE_OBJ_LAYER

/obj/effect/temp_visual/crimdragon_warning
	duration = 3
	icon_state = "warning"
	layer = MASSIVE_OBJ_LAYER

/////////////////////////////
// ! VFX Code End ! //
/////////////////////////////

/////////////////////////////
// ! Podao Code Start ! //
/////////////////////////////

/datum/intent/sword/cut/podao
	hitsound = list('sound/combat/hits/bladed/crimsontiger/slash1.ogg', 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/cut/zwei/cleave/podao
	hitsound = list('sound/combat/hits/bladed/crimsontiger/slash1.ogg', 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/datum/intent/sword/cut/zwei/sweep/podao
	hitsound = list('sound/combat/hits/bladed/crimsontiger/slash1.ogg', 'sound/combat/hits/bladed/crimsontiger/slash2.ogg', 'sound/combat/hits/bladed/crimsontiger/slash3.ogg', 'sound/combat/hits/bladed/crimsontiger/slash4.ogg')

/obj/item/rogueweapon/sword/sabre/longing
	name = "Fused Blade of Ruined Possibilities"
	desc = "..My life ended the day my dear beloved departed the world."
	possible_item_intents = list(/datum/intent/sword/cut/podao, /datum/intent/sword/cut/zwei/cleave/podao, /datum/intent/sword/cut/zwei/sweep/podao)
	//design intent - uhhhh. one handed greatsword is cool? its the same range as a normal sword
	force = 30
	parrysound = list(
		'sound/combat/parry/bladed/fused (1).ogg',
		'sound/combat/parry/bladed/fused (2).ogg',
		'sound/combat/parry/bladed/fused (3).ogg',
		)
	icon = 'icons/roguetown/weapons/special/erlking.dmi'
	icon_state = "ruinedblade"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	swingsound = BLADEWOOSH_HUGE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 300
	wdefense = 7
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	wbalance = WBALANCE_NORMAL
