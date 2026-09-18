//temp visual effects are done in deciseconds
//order is: temp visuals -> attack anchors
//gaze upon my 15 separate glob_list_empty lists, and despair
GLOBAL_LIST_EMPTY(meianchor1)
GLOBAL_LIST_EMPTY(meianchor2)
GLOBAL_LIST_EMPTY(meiarenawallanchor)
GLOBAL_LIST_EMPTY(meianchor4)
GLOBAL_LIST_EMPTY(arenawall)
GLOBAL_LIST_EMPTY(dragonanchor)

/obj/effect/temp_visual/meihua/warning/biggest
	icon = 'icons/effects/224x224.dmi'
	icon_state = "warning"
	pixel_x = -96
	pixel_y = -96
	duration = 92.5

/obj/effect/temp_visual/meihua/big
	icon = 'icons/effects/64x64.dmi'
	icon_state = "double slash"
	pixel_x = -16 //So the big ol' 96x96 sprite shows up right
	pixel_y = -16
	duration = 35
	light_power = 1.3
	light_outer_range =  MINIMUM_USEFUL_LIGHT_RANGE
	light_color = LIGHT_COLOR_FIRE

/obj/effect/temp_visual/meihua/big/scarslash
	icon_state = "scarslash"

/obj/effect/temp_visual/meihua/big/flurry
	icon_state = "flurry"

/obj/effect/temp_visual/meihua/dragon
	icon = 'icons/effects/96x96.dmi'
	icon_state = "southdragon"
	pixel_x = -32 //So the big ol' 96x96 sprite shows up right
	pixel_y = -32
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 60
	pixel_z = 180

/obj/effect/temp_visual/meihua/dragon/Initialize(mapload)
	. = ..()
	animate(src, pixel_z = 0, time = 3, delay = 57, easing = SINE_EASING | EASE_OUT)

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
	icon = null
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/meihua_anchor_tulpa/Initialize()
	. = ..()
	GLOB.meianchor4 += src


/obj/structure/dragonanchor
	name = ""
	desc = ""
	icon = null
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/dragonanchor/Initialize()
	. = ..()
	GLOB.dragonanchor += src
