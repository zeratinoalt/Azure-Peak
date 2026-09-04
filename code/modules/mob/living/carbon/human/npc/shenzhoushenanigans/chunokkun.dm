GLOBAL_LIST_INIT(chunokkun_aggro, world.file2list("strings/rt/chunokkunlines.txt"))

/mob/living/carbon/human/species/human/northern/chunokkun
	ai_controller = /datum/ai_controller/human_npc
	d_intent = INTENT_PARRY
	faction = list(FACTION_CHUNOKKUN, FACTION_STATION)
	ambushable = FALSE
	dodgetime = 30
	blood_toll_bucket = STATS_KILLED_GRONNMEN


/mob/living/carbon/human/species/human/northern/chunokkun/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)


/mob/living/carbon/human/species/human/northern/chunokkun/after_creation()
	..()
	AddComponent(/datum/component/ai_aggro_system)
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.chunokkun_aggro, TRUE)
	job = "Ch'unokkun"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NPC_EXAMINE, TRAIT_GENERIC)
	AddComponent(/datum/component/npc_death_line, GLOB.npc_death_lines_chunokkun, 100)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/chunokkun)
	src.grant_language(/datum/language/kazengunese)
	gender = pick(MALE, FEMALE)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/himecut,
						/datum/sprite_accessory/hair/head/countryponytailalt,
						/datum/sprite_accessory/hair/head/stacy,
						/datum/sprite_accessory/hair/head/kusanagi_alt))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytailwitcher,
						/datum/sprite_accessory/hair/head/dave,
						/datum/sprite_accessory/hair/head/emo,
						/datum/sprite_accessory/hair/head/sabitsuki,
						/datum/sprite_accessory/hair/head/sabitsuki_ponytail))
	var/beard = /datum/sprite_accessory/hair/facial/croppedfullbeard
	//Random voices, this can probably be more random-ish but it'll do for now
	var/voice_choice = rand(1, 4)
	switch(voice_choice)
		if(1)
			src.voice_color = "79251f"
		if(2)
			src.voice_color = "be3c32"
		if(3)
			src.voice_color = "743e3a"
		if(4)
			src.voice_color = "a7160c"
	//Next up, we add hair
	var/datum/bodypart_feature/hair/head/new_hair = new()
	var/datum/bodypart_feature/hair/facial/new_facial = new()

	if(gender == MALE)
		new_hair.set_accessory_type(hairm, null, src)
		new_facial.set_accessory_type(beard, null, src)
	else
		new_hair.set_accessory_type(hairf, null, src)

	var/haircolor_choice = rand(1, 4)
	switch(haircolor_choice)
		if(1)
			new_hair.accessory_colors = "#201e1c"
			new_hair.hair_color = "#1d1d1d"
			new_facial.accessory_colors = "#181717"
			new_facial.hair_color = "#242323"
			hair_color = "#1b1b1b"
		if(2)
			new_hair.accessory_colors = "#1d1d1d"
			new_hair.hair_color = "#1d1d1d"
			new_facial.accessory_colors = "#1d1d1d"
			new_facial.hair_color = "#1d1d1d"
			hair_color = "#1d1d1d"
		if(3)
			new_hair.accessory_colors = "#181717"
			new_hair.hair_color = "#181717"
			new_facial.accessory_colors = "#181717"
			new_facial.hair_color = "#181717"
			hair_color = "#181717"
		if(4)
			new_hair.accessory_colors = "#242323"
			new_hair.hair_color = "#242323"
			new_facial.accessory_colors = "#242323"
			new_facial.hair_color = "#242323"
			hair_color = "#242323"
	//Now we take skin-tone picks
	var/skintone_choice = rand(1, 3) //Heavily simplified
	switch(skintone_choice)
		if(1)
			skin_tone = SKIN_COLOR_OTAVA
		if(2)
			skin_tone = SKIN_COLOR_AVAR
		if(3)
			skin_tone = SKIN_COLOR_ETRUSCA
	//Add our hair bodypart features
	head.add_bodypart_feature(new_hair)
	head.add_bodypart_feature(new_facial)

	dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	dna.species.handle_body(src)
	if(organ_eyes)
		organ_eyes.eye_color = "#131313" //Souless greytider look
		organ_eyes.accessory_colors = "#131313#131313"
	real_name = pick(world.file2list("strings/rt/names/human/chunokkun.txt"))
	update_hair()
	update_body()
	src.regenerate_icons() //Fixes the weird body but lets check performance first

//ok we need to fix allathis
/datum/outfit/job/roguetown/human/species/human/northern/chunokkun/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/basiceast/chunokkun
	pants = /obj/item/clothing/under/roguetown/tights/formalfancy
	head = /obj/item/clothing/head/roguetown/roguehood/hierophant/chunokkun
	mask = /obj/item/clothing/mask/rogue/blindfold/fake/chunokkun
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
	r_hand = /obj/item/rogueweapon/sword/sabre/mulyeog
	l_hand = /obj/item/rogueweapon/scabbard/sword/kazengun
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.STASPD = 12
	H.STACON = 10
	H.STAWIL = 12
	H.STAPER = 12
	H.STAINT = 8
	H.STASTR = 10
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)


/obj/item/clothing/suit/roguetown/armor/basiceast/chunokkun
	color = "#2b292e"

/obj/item/clothing/head/roguetown/roguehood/hierophant/chunokkun
	name = "padded headscarf"
	desc = "A scarf that's actually made out of the binding rope Ch'unokkun use to restrain their hunts."
	naledicolor = FALSE
	color = GLOW_COLOR_CRIMSON
	icon_state = "hijab_t"
	adjustable = CANT_CADJUST
	toggle_icon_state = FALSE
	flags_inv = null

/obj/item/clothing/mask/rogue/blindfold/fake/chunokkun
	color = GLOW_COLOR_CRIMSON
