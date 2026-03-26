/datum/voicepack/erlking
	preview = list("agony", "laugh", "pain", "hmph", "painmoan", "rage", "paincrit", "chuckle", "clearthroat", "embed", "grumble", "groan", "hmm", "huh", "laugh", "rage", "warcry")

/datum/voicepack/erlking/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getmold(soundin)
		if("young")
			used = getmyoung(soundin)
		if("silenced")
			used = getmsilenced(soundin)
	if(!used)
		switch(soundin)
			if("attack")
				used = list('sound/vo/male/erlking/fight (1).ogg', 'sound/vo/male/erlking/fight (2).ogg','sound/vo/male/erlking/fight (3).ogg','sound/vo/male/erlking/fight (4).ogg','sound/vo/male/erlking/fight (5).ogg','sound/vo/male/erlking/fight (6).ogg','sound/vo/male/erlking/fight (7).ogg','sound/vo/male/erlking/fight (8).ogg','sound/vo/male/erlking/fight (9).ogg','sound/vo/male/erlking/fight (10).ogg','sound/vo/male/erlking/fight (11).ogg','sound/vo/male/erlking/fight (12).ogg','sound/vo/male/erlking/fight (13).ogg','sound/vo/male/erlking/fight (14).ogg',)
			if("laugh")
				used = list('sound/vo/male/erlking/laugh (1).ogg', 'sound/vo/male/erlking/laugh (2).ogg', 'sound/vo/male/erlking/laugh (3).ogg')
