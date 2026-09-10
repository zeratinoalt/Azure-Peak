/mob/proc/BecomeDistortion(mob/living/simple_animal/hostile/distortion/chosenmob = null, instant = FALSE, forced = FALSE)
	var/mob/themob = null
	var/list/message_list = list(
		"Tell me. Why is it that you have given up?",
		"So, what will you do now?",
		"What do you think of yourself, [src.name]?",
		"That's the shape of your heart and desire, isn't it?",
	)
	if(!chosenmob)
		chosenmob = pick(subtypesof(/mob/living/simple_animal/hostile/distortion))
	src.playsound_local(src, 'sound/abnormalities/silentgirl/Guilt_Apply.ogg', 15, FALSE)
	if(!instant)
		playsound(src, 'sound/distortions/distortion_bell.ogg', 50, FALSE)
		for(var/i in 1 to 4)
			if(src.client)
				Distortionblurb(src.client, "[message_list[i]]")
			SLEEP_CHECK_DEATH(80)
			playsound(src, 'sound/distortions/distortion_bell.ogg', 50, FALSE)
			if(stat >= UNCONSCIOUS) //YOU GOT KNOCKED TF OUT! YOUR ASS IS GRASS
				return FALSE
	themob = new chosenmob(get_turf(src))
	if(client)
		themob.key = key
	if(!ishuman(src))
		qdel(src)
		return
	var/mob/living/carbon/human/egoist = src
	ADD_TRAIT(egoist, TRAIT_NOBREATH, MAGIC_TRAIT) //We don't want the player suffocating inside
	ADD_TRAIT(egoist, TRAIT_COMBATFEAR_IMMUNE, MAGIC_TRAIT) //We don't want the player suffocating inside
	if(egoist.sanity_lost) //If they panicked already we just top them off
		egoist.adjustWhiteLoss(99999, updating_health = TRUE, forced = TRUE, white_healable = TRUE)
	forceMove(themob)

/mob/proc/Distortionblurb(client/C, text)
	if(!C)
		return
	var/style = "font-family: 'Baskerville'; text-align: center; color: #DC143C; font-size:14pt;"
	var/obj/effect/overlay/T = new()
	T.alpha = 0
	T.maptext_height = 120
	T.maptext_width = 424
	T.layer = FLOAT_LAYER
	T.plane = HUD_PLANE
	T.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	T.screen_loc = "Center-6,Center+3"
	C.screen += T
	animate(T, alpha = 255, time = 10)
	var/display_text = text
	T.maptext = "<br><span style=\"[style]\">[display_text]</span><br>"
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(fade_blurb), C, T, 25), 40) //fade_blurb qdels the object
