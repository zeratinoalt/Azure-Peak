//temp visual effects are done in deciseconds
//order is: temp visuals -> attack anchors
GLOBAL_LIST_EMPTY(meianchor1)
GLOBAL_LIST_EMPTY(meianchor2)
GLOBAL_LIST_EMPTY(meiarenawallanchor)
GLOBAL_LIST_EMPTY(meianchor4)
GLOBAL_LIST_EMPTY(arenawall)

//attack anchors - they're used by the attacks as refs for spawning tiles & whatnot

/obj/structure/meihua_arena_anchor
	name = ""
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = "marker"
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/meihua_arena_anchor/Initialize()
	. = ..()
	GLOB.meianchor1 += src

/obj/structure/meihua_arena_anchor_challenged
	name = ""
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = "marker-red"
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/meihua_arena_anchor_challenged/Initialize()
	. = ..()
	GLOB.meianchor2 += src

/obj/structure/meihua_arena_wall_anchor
	name = ""
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = "marker-blue"
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/meihua_arena_wall_anchor/Initialize()
	. = ..()
	GLOB.meiarenawallanchor += src

/obj/structure/meihua_anchor_tulpa
	name = ""
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/meihua_anchor_tulpa/Initialize()
	. = ..()
	GLOB.meianchor4 += src


