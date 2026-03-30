//its just a reflavored conjure_armor that lets you summon a ring that acts like steel mask every 15 minutes
//cuz the bereaved doesn't spawn with a mask, nor can they get one


/obj/effect/proc_holder/spell/self/withstand
	name = "Withstand"
	desc = "But one of the many gifts imparted to you by the woman who whispered in your mind.\n\
	Upon use, summon a reminder of what could've been, empowering yourself with much-needed protection around the head."
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "withstand"
	sound = list('sound/foley/beheadstart.ogg')

	releasedrain = SPELLCOST_CONJURE
	chargedrain = 1
	chargetime = 3 SECONDS
	no_early_release = TRUE
	recharge_time = 15 MINUTES
	gesture_required = FALSE
	hide_charge_effect = TRUE
	chargedloop = /datum/looping_sound/invokegen

	warnie = "spellwarning"
	no_early_release = TRUE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	spell_tier = 2

	invocations = list("..No repose shall await us.")
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ERLKING
	glow_intensity = GLOW_INTENSITY_MEDIUM


	var/objtoequip = /obj/item/clothing/ring/fate_weaver/erlking
	var/slottoequip = SLOT_RING
	var/obj/item/clothing/conjured_armor = null
	var/checkspot = "ring"
	var/cooldown_on_dissipate = TRUE
	var/summondelay = 0


/obj/effect/proc_holder/spell/self/withstand/proc/start_delayed_recharge()
	if(charge_counter < recharge_time)
		return
	charge_counter = 0
	last_process_time = world.time
	START_PROCESSING(SSfastprocess, src)
	if(action)
		action.build_all_button_icons()


/obj/effect/proc_holder/spell/self/withstand/cast(list/targets, mob/living/user = usr)
	var/mob/living/carbon/human/H = user
	var/targetac = H.highest_ac_worn()
	if(targetac > 1)
		to_chat(user, span_warning("I must be wearing lighter armor!"))
		revert_cast()
		return FALSE
	if(user.get_num_arms() <= 0)
		to_chat(user, span_warning("I don't have any usable hands!"))
		revert_cast()
		return FALSE
	switch(checkspot)
		if("ring")
			if(user.get_num_arms() <= 0)
				to_chat(user, span_warning("I don't have any usable hands!"))
				revert_cast()
				return FALSE
			if(H.wear_ring)
				to_chat(user, span_warning("My ring finger must be free!"))
				revert_cast()
				return FALSE

	if(summondelay)
		if(!do_after(user, summondelay, target = user))
			revert_cast()
			return FALSE

	user.visible_message("[user] becomes emboldened, faint flickers of violet wrapping around their face!")
	var/item = objtoequip
	conjured_armor = new item(user)
	user.equip_to_slot_or_del(conjured_armor, slottoequip)
	if(!QDELETED(conjured_armor))
		if(cooldown_on_dissipate)
			if(istype(conjured_armor, /obj/item/clothing/ring/fate_weaver/erlking))
				var/obj/item/clothing/ring/fate_weaver/erlking/ring = conjured_armor
				ring.linked_withstand = src
			charge_counter = recharge_time
			STOP_PROCESSING(SSfastprocess, src)
			if(action)
				action.build_all_button_icons()
	return TRUE

/obj/effect/proc_holder/spell/self/withstand/Destroy()
	if(src.conjured_armor)
		conjured_armor.visible_message(span_warning("The ring crumbles apart, turning into ash."))
		qdel(conjured_armor)
	return ..()

/obj/item/clothing/ring/fate_weaver/erlking
	name = "broken promises"
	var/obj/effect/proc_holder/spell/self/withstand/linked_withstand
	desc = "This ring was a gift from my beloved. They wrapped it in this wonderful, violet flower that never lost it colour even as it withered away. How foolish was I - everything you've ever said to me.. Was an expression of love."
	icon_state = "s_ring_wedding"
	max_integrity = 200
	body_parts_covered =  HEAD | HAIR | EARS | NOSE | NECK


/obj/item/clothing/ring/fate_weaver/erlking/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_RESENTMENT)
