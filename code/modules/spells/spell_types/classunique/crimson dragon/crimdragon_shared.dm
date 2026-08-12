/obj/effect/temp_visual/crim_dragon/warning
	icon = 'icons/effects/effects.dmi'
	icon_state = "warning"
	light_outer_range = 2
	duration = 10 //in deciseconds
	layer = HUD_LAYER
	plane = ABOVE_LIGHTING_PLANE

/obj/effect/temp_visual/crim_dragon/warning/scatterslash
	duration = 20

/obj/effect/temp_visual/crim_dragon/warning/tanglecleaver
	duration = 92.5

/obj/effect/temp_visual/crim_dragon/large
	icon = 'icons/effects/64x64.dmi'
	icon_state = "right-to-left"
	light_power = 1.3
	light_outer_range =  MINIMUM_USEFUL_LIGHT_RANGE
	light_color = LIGHT_COLOR_FIRE
	duration = 35
	pixel_x = -16
	pixel_y = -16
	fade_time = 10

/obj/effect/temp_visual/crim_dragon/large/right_to_left
	icon = 'icons/effects/64x64.dmi'
	icon_state = "right-to-left"


/obj/effect/temp_visual/crim_dragon/large/left_to_right
	icon = 'icons/effects/64x64.dmi'
	icon_state = "left-to-right"

/obj/effect/temp_visual/crim_dragon/large/low_left_to_right
	icon = 'icons/effects/64x64.dmi'
	icon_state = "low-left-to-right"

/obj/effect/temp_visual/crim_dragon/large/low_right_to_left
	icon = 'icons/effects/64x64.dmi'
	icon_state = "low-right-to-left"

/obj/effect/temp_visual/crim_dragon/large/upright_boom
	icon = 'icons/effects/64x64.dmi'
	icon_state = "upright boom"
	duration = 10
	fade_time = 10
	pixel_y = 0

/obj/effect/temp_visual/crim_dragon/large/second_boom
	icon = 'icons/effects/64x64.dmi'
	icon_state = "second boom"
	duration = 10
	fade_time = 10

/obj/effect/temp_visual/crim_dragon/large/tanglecleaver
	icon = 'icons/effects/64x64.dmi'
	icon_state = "tangleslash"

/obj/effect/temp_visual/crim_dragon/large/tanglecleaver/Initialize()
	dir = pick(GLOB.cardinals)
	..()

/obj/effect/temp_visual/crim_dragon/large/tigerslayer
	icon = 'icons/effects/64x64.dmi'
	icon_state = "tigerslayer"

/obj/effect/temp_visual/crim_dragon/warning/biggest
	icon = 'icons/effects/224x224.dmi'
	icon_state = "warning"
	pixel_x = -96
	pixel_y = -96
	duration = 92.5
