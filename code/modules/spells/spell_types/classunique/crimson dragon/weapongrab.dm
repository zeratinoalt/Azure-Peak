/obj/effect/proc_holder/spell/invoked/bind
	name = "Bind"
	desc = "Ensure that you'll never lose your weapon."
	chargedrain = 0
	chargetime = 0.5 SECONDS
	recharge_time = 3 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 0
	associated_skill = /datum/skill/magic/arcane
	var/obj/item/rogueweapon/bound_item = null
	overlay_state = "dream_bind"

/obj/effect/proc_holder/spell/invoked/bind/cast(list/targets, mob/user)
	var/atom/target = targets[1]

	// If targeting a dream item, bind it
	if(istype(target, /obj/item/rogueweapon/))
		bound_item = target
		to_chat(user, span_notice("You bind [bound_item] to your hand. You can now summon it at will."))
		return TRUE

	// If not targeting a dream item, try to summon the bound item
	if(!bound_item)
		to_chat(user, span_warning("You don't have a weapon bound!"))
		revert_cast()
		return

	if(bound_item.loc == user) // Already in inventory
		to_chat(user, span_notice("[bound_item] is already in your possession."))
		return

	// Check if the item still exists
	if(QDELETED(bound_item))
		to_chat(user, span_warning("Your bound weapon has been destroyed!"))
		bound_item = null
		revert_cast()
		return

	// Summon the item to the user's hand
	bound_item.forceMove(get_turf(user))
	user.put_in_hands(bound_item)
	to_chat(user, span_notice("You pull [bound_item] to your hand."))
	return TRUE
