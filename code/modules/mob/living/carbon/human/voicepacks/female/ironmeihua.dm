/datum/voicepack/female/ironmeihua
	preview = list("pain", "painmoan", "painscream", "paincrit")

/datum/voicepack/female/ironmeihua/get_sound(soundin, modifiers)
	var/used
	switch(soundin)
		if("attack")
			used = list('sound/foley/ironmeihua/attack1.ogg', 'sound/foley/ironmeihua/attack2.ogg', 'sound/foley/ironmeihua/attack3.ogg', 'sound/foley/ironmeihua/attack4.ogg', 'sound/foley/ironmeihua/attack5.ogg', 'sound/foley/ironmeihua/attack6.ogg', 'sound/foley/ironmeihua/attack7.ogg', 'sound/foley/ironmeihua/attack8.ogg', 'sound/foley/ironmeihua/attack9.ogg', 'sound/foley/ironmeihua/attack10.ogg', 'sound/foley/ironmeihua/attack11.ogg')
		if("pain")
			used = list('sound/foley/ironmeihua/hurt1.ogg', 'sound/foley/ironmeihua/hurt2.ogg', 'sound/foley/ironmeihua/hurt3.ogg', 'sound/foley/ironmeihua/hurt4.ogg')
		if("painscream")
			used = list('sound/foley/ironmeihua/attack1.ogg', 'sound/foley/ironmeihua/attack2.ogg', 'sound/foley/ironmeihua/attack3.ogg', 'sound/foley/ironmeihua/attack4.ogg', 'sound/foley/ironmeihua/attack5.ogg')
		if("paincrit")
			used = list('sound/foley/ironmeihua/attack1.ogg', 'sound/foley/ironmeihua/attack2.ogg', 'sound/foley/ironmeihua/attack3.ogg', 'sound/foley/ironmeihua/attack4.ogg', 'sound/foley/ironmeihua/attack5.ogg')


	if(!used)
		used = ..(soundin, modifiers)
	return used
