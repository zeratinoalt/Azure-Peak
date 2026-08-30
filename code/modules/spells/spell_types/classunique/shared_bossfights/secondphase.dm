#define AURA_FIRE_ICON 'icons/mob/onfireNEW.dmi'
#define AURA_FIRE_STATE "human_big_fire"
#define AURA_FILTER "black_rot_glow"
#define OUTLINE_COLOUR "#FFD84E"



/datum/action/cooldown/spell/secondphase
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	name = "Second Phase"
	desc = "Click to cast. Instantly and completely heals you, while repairing everything on your person."
	button_icon_state = "tigerslayer"
	sound = 'sound/magic/whiteflame.ogg'
	spell_color = GLOW_COLOR_CRIMSON
	glow_intensity = GLOW_INTENSITY_VERY_HIGH

	click_to_activate = TRUE
	self_cast_possible = TRUE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = FALSE
	cooldown_time = 1 HOURS

	associated_skill = /datum/skill/magic/arcane
	spell_tier = 6
	spell_impact_intensity = SPELL_IMPACT_LOW

	spell_requirements =  SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z

	var/objtoequip = /obj/item/clothing/ring/aura
	var/slottoequip = SLOT_RING
	var/obj/item/clothing/conjured_armor = null
	var/checkspot = "ring"
	var/cooldown_on_dissipate = TRUE
	var/summondelay = 0


/datum/action/cooldown/spell/secondphase/cast(atom/cast_on)
	. = ..()
	var/mob/living/user = owner
	if(!istype(user))
		return FALSE

	user.fully_heal(TRUE, TRUE)

	conjured_armor = new objtoequip(user)
	user.equip_to_slot_or_del(conjured_armor, slottoequip)

	for(var/obj/item/I in user.held_items)
		if(I && I.obj_integrity < I.max_integrity)
			if(I.obj_broken)
				I.obj_fix(null, TRUE)
			else
				I.obj_integrity = I.max_integrity
			I.update_icon()
		// Also restore sharpness
		if(I && I.max_blade_int > 0 && I.blade_int < I.max_blade_int)
			I.blade_int = I.max_blade_int

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		for(var/obj/item/I in H.GetAllContents())
			if(I.obj_integrity < I.max_integrity)
				if(I.obj_broken)
					I.obj_fix(null, TRUE)
				else
					I.obj_integrity = I.max_integrity
				I.update_icon()
			// Also restore sharpness
			if(I.max_blade_int > 0 && I.blade_int < I.max_blade_int)
				I.blade_int = I.max_blade_int

	if(!(user.mobility_flags & MOBILITY_STAND))
		user.set_resting(FALSE)
	user.say("That's more like it... Y'all are firin' me up!!")
	playsound(user, 'sound/foley/crimsondragon/yallarefiringmeup.ogg', 80, FALSE)

/obj/item/clothing/ring/aura
	name = "Xīntòng (心痛)"
	desc = "..Or, to feel heartache."
	icon_state = null
	sellprice = 222

/obj/item/clothing/ring/aura/equipped(mob/living/user, slot)
	. = ..()
	user.AddComponent(/datum/component/aura)

//component start
/datum/component/aura
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/mob/living/parent_mob

/datum/component/aura/Initialize()
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	parent_mob = parent
	apply_visuals()

/datum/component/aura/proc/apply_visuals()
	if(!parent_mob)
		return
	if(!parent_mob.get_filter(AURA_FILTER))
		parent_mob.add_filter(AURA_FILTER, 2, list(
			"type" = "outline",
			"color" = OUTLINE_COLOUR,
			"alpha" = 10,
			"size" = 1,
		))

	var/mutable_appearance/new_fire_overlay = mutable_appearance(AURA_FIRE_ICON, AURA_FIRE_STATE, -BLACK_ROT_LAYER)
	new_fire_overlay.appearance_flags = RESET_COLOR
	parent_mob.overlays_standing[BLACK_ROT_LAYER] = new_fire_overlay
	parent_mob.apply_overlay(BLACK_ROT_LAYER)


/datum/component/aura/Destroy()
	remove_visuals()
	return ..()

/datum/component/aura/proc/remove_visuals()
	if(!parent_mob)
		return
	parent_mob.remove_filter(AURA_FILTER)
	parent_mob.remove_overlay(BLACK_ROT_LAYER)

/obj/item/clothing/ring/aura/dropped(mob/living/user)
	..()
	var/datum/component/auracom = GetComponent(/datum/component/aura)
	if(auracom)
		auracom.ClearFromParent()

#undef AURA_FIRE_ICON
#undef AURA_FIRE_STATE
#undef AURA_FILTER
#undef OUTLINE_COLOUR
