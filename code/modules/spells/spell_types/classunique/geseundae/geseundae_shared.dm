//temp visual effects are done in deciseconds
//order is: temp visuals -> attack anchors
GLOBAL_LIST_EMPTY(gesanchor1)
GLOBAL_LIST_EMPTY(gesanchor2)
GLOBAL_LIST_EMPTY(gesaoeanchor)
GLOBAL_LIST_EMPTY(gesteleanchor)

/obj/effect/temp_visual/geseundaedecoy
	desc = ""
	duration = 50

/obj/effect/temp_visual/geseundaedecoy/Initialize(mapload, atom/mimiced_atom)
	. = ..()
	alpha = initial(alpha)
	if(mimiced_atom)
		name = mimiced_atom.name
		appearance = mimiced_atom.appearance
		setDir(SOUTH)
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/temp_visual/geseundaedecoy/fading/Initialize(mapload, atom/mimiced_atom)
	. = ..()
	animate(src, alpha = 0, time = duration)

/obj/effect/temp_visual/geseundae/warning
	icon = 'icons/effects/effects.dmi'
	icon_state = "warning"
	light_outer_range = 2
	duration = 30
	layer = HUD_LAYER
	plane = ABOVE_LIGHTING_PLANE

/obj/effect/temp_visual/geseundae/warning/short
	duration = 15

/obj/effect/temp_visual/geseundae/warning/falloftheblade
	duration = 92.5

/obj/effect/temp_visual/geseundae/warning/tendril
	icon_state = "blood_tendril_wiggle"
	duration = 15
	color = COLOR_BLACK

/obj/effect/temp_visual/geseundae/warning/big
	icon = 'icons/effects/160x160.dmi'
	icon_state = "warning"
	light_outer_range = 2
	duration = 10 //in deciseconds
	layer = HUD_LAYER
	plane = ABOVE_LIGHTING_PLANE
	pixel_x = -64
	pixel_y = -64

/obj/effect/temp_visual/geseundae/large
	icon = 'icons/effects/64x64.dmi'
	icon_state = "slash series"
	duration = 35
	pixel_x = -16
	pixel_y = -16
	fade_time = 10

/obj/effect/temp_visual/geseundae/large/bigslash
	icon_state = "sword big slash"

/obj/effect/temp_visual/geseundae/large/bigslash/black
	color = COLOR_BLACK

/obj/effect/temp_visual/geseundae/large/smoke_afterdash
	icon_state = "smoke_afterdash"
	color = COLOR_BLACK

//attack anchors - they're used by the attacks as refs for spawning tiles & whatnot

/obj/structure/geseundae_attack_anchor
	name = ""
	desc = ""
	icon = null
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/geseundae_attack_anchor/Initialize()
	. = ..()
	GLOB.gesanchor1 += src

/obj/structure/geseundae_attack_anchor_secondslash
	name = ""
	desc = ""
	icon = null
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/geseundae_attack_anchor_secondslash/Initialize()
	. = ..()
	GLOB.gesanchor2 += src

/obj/structure/geseundae_attack_anchor_aoe
	name = ""
	desc = ""
	icon = null
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/geseundae_attack_anchor_aoe/Initialize()
	. = ..()
	GLOB.gesaoeanchor += src

/obj/structure/geseundae_attack_teleanchor
	name = ""
	desc = ""
	icon = null
	icon_state = ""
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/geseundae_attack_teleanchor/Initialize()
	. = ..()
	GLOB.gesteleanchor += src
