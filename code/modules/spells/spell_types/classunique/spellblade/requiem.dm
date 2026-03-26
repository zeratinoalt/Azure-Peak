/* Requiem - the Erlking's finisher.
7 hits, doesn't spawn mobs.

Requires 7 momentum, overcharge does nothing.
Always FFs.*/

/obj/effect/proc_holder/spell/invoked/requiem
	name = "Memorial Precession"
	desc = "Tear someone apart, targetting a single person and trapping them within your coffin. \
		Upon calling, you chain your victim, shoving them inside the coffin before delivering multiple, deadly blows. \
		Requires 7 momentum, overcharging does nothing. \
		To begin your Requiem, attack after activating this spell. \
		Cannot be blocked."
	clothes_req = FALSE
	range = 7
	action_icon = 'icons/mob/actions/classuniquespells/erlking.dmi'
	overlay_state = "requiem"
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	invocations = list("Disappear with the storm!")
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	var/delay = 10
	var/damage = 100
	var/bonus_damage = 80
	var/area_of_effect = 2
	var/min_momentum = 4
	var/empowered_momentum = 10

/obj/effect/proc_holder/spell/invoked/requiem/can_cast(mob/user = usr, feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/H = user
	var/datum/status_effect/buff/arcyne_momentum/M = H.has_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(!M || M.stacks < min_momentum)
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/requiem/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

	var/obj/item/rogueweapon/sword/sabre/longing/held_weapon = arcyne_get_weapon(H)
	if(!istype(held_weapon))
		to_chat(H, span_warning("I need my fused blade."))
		revert_cast()
	else
		held_weapon.requiem = TRUE

//look at the erlking wretch file for everything that happens after this check succeeds
