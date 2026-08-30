/datum/voicepack/male/geseundae
	preview = list("jump", "pain", "groan", "huh", "laugh", "chuckle", "painmoan", "painscream", "paincrit", "giggle", "sigh")

/datum/voicepack/male/geseundae/get_sound(soundin, modifiers)
	var/used
	switch(soundin)
		if("attack")
			used = list('sound/vo/male/geseundae/attack1.ogg', 'sound/vo/male/geseundae/attack2.ogg', 'sound/vo/male/geseundae/attack3.ogg', 'sound/vo/male/geseundae/attack4.ogg', 'sound/vo/male/geseundae/attack5.ogg', 'sound/vo/male/geseundae/attack6.ogg', 'sound/vo/male/geseundae/attack7.ogg', 'sound/vo/male/geseundae/attack8.ogg', 'sound/vo/male/geseundae/attack9.ogg', 'sound/vo/male/geseundae/attack10.ogg', 'sound/vo/male/geseundae/attack11.ogg')

	if(!used)
		used = ..(soundin, modifiers)
	return used
