#define WEAPON_SWORD /obj/item/rogueweapon/sword/sabre/meihua
#define WEAPON_SPEAR /obj/item/rogueweapon/spear/partizan/meihua

/datum/action/cooldown/spell/ardor
	button_icon = 'icons/mob/actions/classuniquespells/crimsondragon.dmi'
	name = "Ardor"
	desc = "Picks between two weapons and gives 'em to you."
	button_icon_state = "tigerslayer"
	sound = 'sound/silence.ogg'

	click_to_activate = TRUE
	self_cast_possible = TRUE

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_MINOR_PROJECTILE

	charge_required = FALSE


	associated_skill = /datum/skill/magic/arcane
	spell_tier = 6
	spell_requirements =  SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z

	cooldown_time = 2 SECONDS

	var/weapontosummon = null

/datum/action/cooldown/spell/ardor/cast(atom/cast_on)
	. = ..()
	var/mob/living/user = owner
	if(!istype(user))
		return FALSE

	if(weapontosummon)
		qdel(weapontosummon)

	var/weapontype = pick(/obj/item/rogueweapon/sword/sabre/meihua, /obj/item/rogueweapon/spear/partizan/meihua)

	var/obj/item/rogueweapon/newweapon = new weapontype(get_turf(owner))
	weapontosummon = newweapon
	owner.put_in_active_hand(newweapon)

/datum/component/martyrweapon/proc/summon_weapon(obj/item/rogueweapon/weapon)
	var/weapontype = pick(WEAPON_SWORD, WEAPON_MACE, WEAPON_TRIDENT,WEAPON_AXE)
	var/obj/item/rogueweapon/newweapon = new weapontype(get_turf(weapon))

	newweapon.visible_message(span_danger("[newweapon] hardens itself, finally."))
	SSroguemachine.martyrweapon = newweapon

	QDEL_NULL(weapon)
	return
