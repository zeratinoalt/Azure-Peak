//A Baothan-exclusive wretch slot.
//Arcane momentum user - locked to spells specific to that class.
//Focused on overwhelming opponents with nigh-endless revenants & powerful arcyne strikes.
//Light armor, they're locked only to their starting equipment.
/datum/advclass/wretch/bereaved
	name = "Bereaved"
	tutorial = "The wrath within me burns. This heart of vengeance, of heartbreak - it will only learn to rest once I march 'pon that wretched manor. I am the ripping and tearing tempest that will bring about their ruin."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES // sorry, i dont have the sprites for yall
	allowed_patrons = /datum/patron/inhumen/baotha
	outfit = /datum/outfit/job/roguetown/wretch/bereaved
	cmode_music = 'sound/music/combat_bereaved.ogg'
	maximum_possible_slots = 1
	class_select_category = CLASS_CAT_BATTLEMAGE
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_ARCYNE, TRAIT_WILDHUNT, TRAIT_SELFLOATHING, TRAIT_AFFECTION_AND_HATRED, TRAIT_RESENTMENT)
	subclass_stats = list(
		STATKEY_STR = 1,
		STATKEY_PER = 2, //seven cuz like.. yeah.
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

/datum/outfit/job/roguetown/wretch/bereaved/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/erlking
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/erlking
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	mask = /obj/item/clothing/mask/rogue/erlking
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/erlking
	gloves = /obj/item/clothing/gloves/roguetown/angle/erlking
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/backpack/coffin
	backr = /obj/item/rogueweapon/sword/sabre/longing
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/flashlight/flare/torch = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	
	)

	H.mind.AddSpell(new /datum/action/cooldown/spell/recall_weapon)
	H.mind.AddSpell(new /datum/action/cooldown/spell/empower_weapon)
	H.mind.AddSpell(new /datum/action/cooldown/spell/bind_weapon)
	H.mind.AddSpell(new /datum/action/cooldown/spell/mending)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/withstand)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summonwraith)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/beheading)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/memorialprocession)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/requiem)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summondullahan)

	if(should_wear_masc_clothes(H))
		H.dna.species.soundpack_m = new /datum/voicepack/male/erlking()
	if(H)
		H.faction = list("wildhunt") //protection against the spawnedmobs

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


/obj/item/rogueweapon/sword/sabre/longing
	name = "Fused Blade of Ruined Possibilities"
	desc = "..My life ended the day my dear beloved departed the world."
	possible_item_intents = list(/datum/intent/sword/cut/longing, /datum/intent/sword/thrust/longing, /datum/intent/sword/cut/zwei/sweep)
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

/obj/item/rogueweapon/sword/sabre/longing/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("onback")
				return list("shrink" = 0.5,"sx" = 1,"sy" = -1,"nx" = 1,"ny" = -1,"wx" = 4,"wy" = -1,"ex" = -1,"ey" = -1,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("gen")
				return list("shrink" = 0.5,"sx" = -15,"sy" = -13,"nx" = 3,"ny" = -15,"wx" = -8,"wy" = -10,"ex" = 10,"ey" = -11,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/erlking
	name = "shackled duster"
	desc = "Me... A thing lesser than a savage beast... Must I keep pretending to be a human?"
	icon_state = "erlking"
	item_state = "erlking"
	armor = ARMOR_MAILLE
	color = null
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/erlking/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)

/obj/item/clothing/gloves/roguetown/angle/erlking
	name = "muddled gloves"
	desc = "No more must I suffer that wretched manor's dream to suffocate me in grief.."
	icon_state = "erlking"
	item_state = "erlking"
	color = null
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/gloves/roguetown/angle/erlking/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)

/obj/item/clothing/under/roguetown/heavy_leather_pants/erlking
	name = "worn trousers"
	desc = "They have never once invited me to their dinner banquets, yet my dearly beloved would always visit me with food they took from the kitchen. \
	...All meaningless recollections of the bygone days, now."
	icon_state = "erlking"
	item_state = "erlking"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/under/roguetown/heavy_leather_pants/erlking/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)

/obj/item/clothing/shoes/roguetown/boots/leather/reinforced/erlking
	name = "ruined boots"
	desc = "My vulgar, low birth can't change."
	icon_state = "erlking"
	item_state = "erlking"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/shoes/roguetown/boots/leather/reinforced/erlking/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)

/obj/item/storage/backpack/rogue/backpack/coffin
	name = "chained coffin"
	desc = "I shall bring utter ruination to you, who have broken my heart... And that manor - the cradle of our meeting..!"
	icon_state = "coffin"
	item_state = "coffin"
	equip_sound = 'sound/foley/equip/coffingrab.ogg'

/obj/item/storage/backpack/rogue/backpack/coffin/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)

/obj/item/clothing/mask/rogue/erlking
	name = "fettered eyepatch"
	desc = "Ruminations of all kinds have no purpose here; not for you, not for me. All that remains is to settle this once and for all."
	icon_state = "erlking"
	max_integrity = 20
	integrity_failure = 0.5
	body_parts_covered = EYES
	sewrepair = TRUE

/obj/item/clothing/mask/rogue/erlking/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)
