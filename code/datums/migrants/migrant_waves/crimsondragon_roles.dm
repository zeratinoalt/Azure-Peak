// anything that's related 2 crimson dragon & not a dmi is here (e.g. clothing defines, shell & podao code)
// obvs doesn't include trait defines (traits.dm) or thrill code (bodypart_wounds.dm)
// ! be warned - there's a lot here. ive tried my best to document everything using comments & !'s 
// ! sorry lol

#define PODAOWOOSH list('sound/foley/crimsondragon/draw.ogg', 'sound/foley/crimsondragon/draw2.ogg')

// used 4 stack comparison
#define CTYPE_DRAGONMARK "dragon"
#define CTYPE_SAVAGEMARK "dragonslay"
#define CTYPE_DRAGONSPENT "e_dragon"
#define CTYPE_SAVAGESPENT "e_dragonslay"
#define MAX_SHELL_STACK 6

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

/obj/item/clothing/under/roguetown/heavy_leather_pants/crimdragon
	name = "stained silk pants"
	desc = "They say that pants like these are intentionally stained red in order to give off the appearance of blood."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragonpants"

/obj/item/clothing/gloves/roguetown/angle/crimdragon
	name = "maroon gloves"
	desc = "Lingyuese silk. Almost magic in how durabile it is, for how thin-and-stretchy the material actually is. Notoriously hard to source and work with, however."
	icon = 'icons/roguetown/clothing/special/dragon.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/dragon.dmi'
	icon_state = "crimsondragongloves"

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
	desc = "Powerful propellant shells. These aren't fired at targets, but are instead detonated to provide additional propulsion to swings and stabs of Lingyuese weaponry. Rather expensive to purchase and keep in storage, hence their rarity outside of Lingyue."
	icon_state = "dragon1"
	w_class = WEIGHT_CLASS_SMALL
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

	var/quantity = 6
	var/plural_name = "spent dragonmark shells"
	var/base_type

/obj/item/dragonmark/Initialize(mapload, quantity)
	. = ..()
	if(quantity >= 1)
		set_quantity(floor(quantity))

/obj/item/dragonmark/proc/set_quantity(new_quantity)
	quantity = new_quantity
	update_icon()
	update_transform()

/obj/item/dragonmark/proc/merge(obj/item/dragonmark/G, mob/user)
	if(!G)
		return
	if(G.base_type != base_type)
		return

	var/amt_to_merge = min(G.quantity, MAX_SHELL_STACK - quantity)
	if(amt_to_merge <= 0)
		return
	set_quantity(quantity + amt_to_merge)

	G.set_quantity(G.quantity - amt_to_merge)
	if(user && G.quantity <= 0)
		user.doUnEquip(G)
		user.update_inv_hands()
	if(G.quantity <= 0)
		qdel(G)
	playsound(loc, 'sound/foley/crimsondragon/ammomanipulation.ogg', 100, TRUE, -2)

/obj/item/dragonmark/examine(mob/user)
	. = ..()
	if(quantity > 1)
		. += span_info("[quantity] shells.")

/obj/item/dragonmark/attack_right(mob/user)
	if(user.get_active_held_item())
		return ..()
	var/obj/item/dragonmark/new_shell = new type()
	new_shell.set_quantity(1)
	set_quantity(quantity - 1)
	playsound(loc, 'sound/foley/crimsondragon/ammograb.ogg', 100, TRUE, -2)

/obj/item/dragonmark/attack_hand(mob/user)
	if(user.get_inactive_held_item() == src && quantity > 1)
		var/amt_text = " (1 to [quantity])"
		if(quantity == 1)
			amt_text = ""
		var/amount = input(user, "How many [plural_name] to split?[amt_text]", null, round(quantity/2, 1)) as null|num
		if(QDELETED(user) || QDELETED(src) || !user.Adjacent(src)) // if shells were consumed/user was deleted/moved away, don't split
			return
		amount = clamp(amount, 0, quantity)
		amount = round(amount, 1) // no taking non-integer shells
		if(!amount)
			return
		if(amount >= quantity)
			return ..()
		var/obj/item/dragonmark/new_shells = new type()
		set_quantity(quantity - amount)

		user.put_in_hands(new_shells)
		playsound(loc, 'sound/foley/crimsondragon/ammograb.ogg', 100, TRUE, -2)
		return
	..()

/obj/item/dragonmark/update_icon()
	..()
	if(quantity > 1)
		drop_sound = 'sound/foley/crimsondragon/ammodrop.ogg'

	if(quantity == 1)
		name = initial(name)
		desc = initial(desc)
		slot_flags = ITEM_SLOT_MOUTH
		return

	name = plural_name
	desc = ""
	dropshrink = 1
	slot_flags = null
	switch(quantity)
		if(2)
			icon_state = "[base_type]2"
		if(3)
			icon_state = "[base_type]3"
		if(4 to 5)
			icon_state = "[base_type]4"
		if(5 to 10)
			icon_state = "[base_type]5"
		if(6 to INFINITY)
			icon_state = "[base_type]6"

/obj/item/dragonmark/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/dragonmark))
		var/obj/item/dragonmark/G = I
		if(item_flags & IN_STORAGE)
			merge(G, user)
		else
			G.merge(src, user)
		return
	return ..()

//genuinely only used 4 reloading
/obj/item/dragonmark/proc/split_stack(mob/user, amount)
	if(!use(amount, TRUE, FALSE))
		return null
	var/obj/item/dragonmark/F = new type(user? user : drop_location(), amount, FALSE)
	if(user)
		F.forceMove(user.drop_location())


/obj/item/dragonmark/savage
	name = "savage dragonmark shell"
	desc = "Extremely powerful propellant shells. Each detonation sounds like the roar of a dragon."
	icon_state = "dragonslay1"
	w_class = WEIGHT_CLASS_SMALL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	grid_width = 32
	grid_height = 32
	spent_type = /obj/item/dragonmark/savage/spent
	heat_generation = 7
	sellprice = 60

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
	//current ammo, duh
	var/list/obj/item/dragonmark/current_ammo = list()
	//how much ammo u can have max
	var/max_ammo = 6
	// this variable holds a flat force increase that is only applied on basic hits. it increases when ammo is spent, and gets reset on reload or unload
	// it decays on each hit that isn't part of a combo
	//! ..aaalso bypasses dodge/parry !
	var/overheat = 0
	var/overheat_decay = 1
	// this list holds a reference of every spent cartridge
	var/list/obj/item/dragonmark/spent_cartridges = list()
	// what types of ammo this thing can hold
	var/list/accepted_ammo_table = list(
		/obj/item/dragonmark,
		/obj/item/dragonmark/savage,
	)
	var/busy = FALSE // used to prevent certain actions while reloading or leaping
	// how long does the reload start phase last?
	var/reload_start_windup = 0.6 SECONDS
	// how long does it take to load each individual round?
	var/reload_load_windup = 0.4 SECONDS
	// we use this variable to hold the type of the current ammo, so we can reject different types
	var/current_ammo_type = null
	// we use this variable to hold the plural name of the current ammo. we shouldn't need a var for this, but dreamchecker is giving me a warning so I have to do it
	var/current_ammo_name = ""


////////////////////////////////////////////////////////////
// ! OVERRIDES !
// all of the code that overrides procs from parent types

/obj/item/rogueweapon/sword/sabre/podao/examine(mob/user)
	. = ..()
	. += span_danger("There are [length(current_ammo)]/[max_ammo] shells of [length(current_ammo) > 0 ? current_ammo_name : "propellant shells"] currently loaded.")
	if(overheat > 0)
		. += span_danger("This weapon has [overheat] stored heat, raising base damage by [overheat * 0.75] on a non-combo hit due to the heat generated by spent shells.")
	. += span_danger("This weapon's AoE is indiscriminate. <b>Watch out for friendly fire</b>.")

/obj/item/rogueweapon/sword/sabre/podao/attackby(obj/item/dragonmark/I, mob/living/user, params)
	. = ..()
	if(!istype(I))
		return
	// you cant reload while reloading/leaping
	if(busy)
		return
	// rejecting shells that arent compatible
	if(!(I.type in accepted_ammo_table))
		to_chat(user, span_warning("The [I.name] are incompatible with the [src.name]."))
		return
	// if we already have a type of ammunition loaded, and we try to load a different type, reject the round
	if(I.type != current_ammo_type && current_ammo_type)
		to_chat(user, span_warning("There is a different type of ammunition currently loaded. Spend or unload the ammunition first to load this round."))
		return

	var/bullets_in_hand = I.quantity
	// making sure
	if(bullets_in_hand < 1)
		return
	INVOKE_ASYNC(src, PROC_REF(Reload), bullets_in_hand, I, user)
	return

/// clean up if destroyed - should drop any ammo inside
/obj/item/rogueweapon/sword/sabre/podao/Destroy(force)
	for(var/obj/item/dragonmark/leftover in current_ammo)
		leftover.forceMove(get_turf(src))
	for(var/obj/item/dragonmark/spent_leftover in spent_cartridges)
		spent_leftover.forceMove(get_turf(src))
	current_ammo = null
	spent_cartridges = null
	return ..()

/obj/item/rogueweapon/sword/sabre/podao/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(isliving(target))
		var/mob/living/M = target
		M.adjustFireLoss(overheat)
		to_chat(M, span_warning("The overwhelming heat from the podao burns you!"))
		overheat = max(0, overheat - overheat_decay)

////////////////////////////////////////////////////////////
// ! Ammo Management Procs !
// stuff that handles loading & usage of shells (includes applying overheat)


// Returns TRUE if we're out of ammo. Also resets our current ammo type and name.
/obj/item/rogueweapon/sword/sabre/podao/proc/AmmoDepletedCheck()
	if(length(current_ammo) <= 0)
		current_ammo_type = null
		current_ammo_name = ""
		return TRUE
	return FALSE


// this procs ejects EVERY round in the weapon, spraying them all over the place
/obj/item/rogueweapon/sword/sabre/podao/proc/EjectRound(obj/item/dragonmark/cartridge, mob/living/user)
	if(cartridge in current_ammo)
		current_ammo -= cartridge
	else if(cartridge in spent_cartridges)
		spent_cartridges -= cartridge

	AmmoDepletedCheck()

	// This block is adapted code from actual bullet casings for SS13 guns. We just slightly randomize its pixel offsets and throw it somewhere nearby.
	cartridge.forceMove(user.drop_location())
	cartridge.pixel_x = cartridge.base_pixel_x + rand(-7, 7)
	cartridge.pixel_y = cartridge.base_pixel_y + rand (-7, 7)
	var/turf/destination = get_ranged_target_turf(user, pick(GLOB.alldirs), 1)
	cartridge.throw_at(destination, rand(1, 2), 6, spin = TRUE)
	cartridge.setDir(pick(GLOB.alldirs))

// process 4 loading the podao, can be interrupted 
/obj/item/rogueweapon/sword/sabre/podao/proc/Reload(amount_to_load, obj/item/dragonmark/ammo_item, mob/living/carbon/user)
	// This first section is the reload start. You can cancel it, with the only consequence at this point being that you lose your overheat bonus.
	playsound(src, 'sound/foley/crimsondragon/loadstart.ogg', 90, FALSE, 10)
	icon_state = "podao_open"
	to_chat(user, span_info("You begin loading your [src.name]..."))
	VentHeat(user)
	busy = TRUE

	if(do_after(user, reload_start_windup, src, progress = TRUE))
		// If we reached this line, we've started the reload properly now. Being interrupted at this point causes a ReloadFailure(), you will spill the ammo you're loading.
		// This first block will eject all our spent and unspent ammo if we're using a weapon with SPENT_RELOADEJECT behaviour (the podao).
		var/list/all_cartridges = list()
		all_cartridges |= spent_cartridges
		all_cartridges |= current_ammo
		for(var/obj/item/dragonmark/round in all_cartridges)
			INVOKE_ASYNC(src, PROC_REF(EjectRound), round, user)

		// This is the actual reload. Each round takes 0.4 seconds to load, so this will at most last 2.4~ seconds if you're fully reloading the podao
		for(var/i in 1 to amount_to_load)
			if(do_after(user, (reload_load_windup), src, progress = TRUE))
				var/obj/item/dragonmark/new_bullet = ammo_item.split_stack(user, 1)
				if(new_bullet)
					// we actually store the round INSIDE the weapon. If the weapon is destroyed we'll drop them
					new_bullet.forceMove(src)
					current_ammo += new_bullet
					current_ammo_type = ammo_item.type
					current_ammo_name = ammo_item.name
					playsound(src, 'sound/foley/crimsondragon/loading.ogg', 90, FALSE, 8)
					to_chat(user, span_info("You load a shell into the [src.name]."))
			// if we reach this else block, it means our reload got interrupted in some way, so we drop the ammo we're trying to load into the weapon and scatter it
			else
				INVOKE_ASYNC(src, PROC_REF(ReloadFailure), ammo_item, user)
				icon_state = "podao_closed"
				busy = FALSE
				return FALSE
		icon_state = "podao_closed"
		busy = FALSE
	else
		busy = FALSE
		to_chat(user, span_danger("You abort your reload!"))
		icon_state = "podao_closed"
		return FALSE

	// we only reach this part if we successfully loaded the rounds we wanted to load. play the reload_end_sound with a small delay so it sounds nicer
	sleep(0.2 SECONDS)
	playsound(src, 'sound/foley/crimsondragon/loadclose.ogg', 90, FALSE, 8)
	sleep(0.1 SECONDS)
	playsound(src, 'sound/foley/crimsondragon/loaddraw.ogg', 90, FALSE, 8)
	return TRUE

// this proc happens if your reloading gets interrupted after you've started loading rounds into the weapon. you spill the ammo you were trying to load on the floor
/obj/item/rogueweapon/sword/sabre/podao/proc/ReloadFailure(obj/item/dragonmark/ammo_item, mob/living/carbon/user)
	playsound(src, 'sound/foley/crimsondragon/ammodrop.ogg', 100, FALSE, 6)
	user.visible_message(span_danger("[user] fumbles while reloading, spilling shells on the floor!"), span_danger("You fumble while reloading, spilling shells on the floor!"))
	for(var/i in 1 to ammo_item.quantity)
		var/obj/item/dragonmark/spilled_bullet = ammo_item.split_stack(user, 1)
		if(spilled_bullet)
			spilled_bullet.forceMove(user.drop_location())
			spilled_bullet.throw_at(get_ranged_target_turf(user, pick(GLOB.alldirs), 1), 1, 5, spin = TRUE)
			spilled_bullet.setDir(pick(GLOB.alldirs))
			sleep(1)

// this proc tries to spend a round, and if it is able to, calls CreateSpentCartridge() with that round, then returns TRUE. if it can't, returns FALSE
// called by spells, not the obj itself
// ! important: this proc doesn't delete the fired round, but removes it from our reference list. if it is not deleted later, then it will remain in the weapon's contents
// that being said it shouldn't cause any issues because of that
/obj/item/rogueweapon/sword/sabre/podao/proc/SpendAmmo(mob/living/user)
	// if we try to spend ammo but don't have any, we reset our combo
	if(AmmoDepletedCheck())
		playsound(src, 'sound/foley/crimsondragon/ammomanipulation.ogg', 65)
		return FALSE
	// we need to delete this round that was fired later btw
	var/obj/item/dragonmark/fired_round = pick_n_take(current_ammo)
	// did we run out of ammo *after* firing that last round? we just call this to clear our ammo type if we're dry
	AmmoDepletedCheck()
	// just in case some jank happens with our list
	removeNullsFromList(current_ammo)

	if(fired_round)
		shake_camera(user, 1.5, 3)
		CreateSpentCartridge(fired_round, user)
		return TRUE
	return FALSE

// creates a spent cartridge, then ejects it if the weapon is SPENT_INSTANTEJECT or stores it if the weapon is SPENT_RELOADEJECT
/obj/item/rogueweapon/sword/sabre/podao/proc/CreateSpentCartridge(obj/item/dragonmark/round, mob/living/user)
	var/obj/item/dragonmark/spent/new_spent_cartridge = null
	new_spent_cartridge = new round.spent_type(src)
	// do I really need to null check here?
	if(new_spent_cartridge)
		spent_cartridges |= new_spent_cartridge

/obj/item/rogueweapon/sword/sabre/podao/proc/VentHeat(mob/living/carbon/human/user)
	if(overheat > 0)
		playsound(src, 'sound/foley/crimsondragon/whrrr2.ogg', 75, FALSE, 4)
		to_chat(user, span_danger("You vent [src]'s remaining heat to access its ammo storage!"))
	overheat = 0

////////////////////////////////////////////////////////////
// ! misc procs

// this proc is just for a visual effect that creates a "shockwave" or some smoke at the user's location
/obj/item/rogueweapon/sword/sabre/podao/proc/PropulsionVisual(turf/origin, radius)
	var/list/already_rendered = list()
	// There may be a less expensive way to do this. I'm open to ideas.
	for(var/i in 1 to radius)
		var/list/turfs_to_spawn_visual_at = list()
		for(var/turf/T in orange(i, origin))
			turfs_to_spawn_visual_at |= T
		turfs_to_spawn_visual_at -= already_rendered
		for(var/turf/T2 in turfs_to_spawn_visual_at)
			new /obj/effect/temp_visual/small_smoke/halfsecond(T2)
			already_rendered |= T2
		sleep(1)

#undef CTYPE_DRAGONMARK
#undef CTYPE_SAVAGEMARK
#undef CTYPE_DRAGONSPENT
#undef CTYPE_SAVAGESPENT
#undef MAX_SHELL_STACK
