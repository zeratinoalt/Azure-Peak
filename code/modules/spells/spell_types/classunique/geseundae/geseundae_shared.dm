//temp visual effects are done in deciseconds
//order is: temp visuals -> attack anchors
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
	duration = 10 //in deciseconds
	layer = HUD_LAYER
	plane = ABOVE_LIGHTING_PLANE



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

//attack anchors - they're used by the attacks as refs for spawning tiles & whatnot

/obj/structure/geseundae_attack_anchor
	name = ""
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = "marker-red"
	density = FALSE
	mouse_opacity = 0
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/geseundae_attack_anchor/secondslash
	icon_state = "marker"

/obj/structure/geseundae_attack_anchor/aoe
	icon_state = "marker-blue"
