/datum/migrant_wave/crimson_dragon
	name = "The Crimson Dragon"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/crimson_dragon
	weight = 8
	roles = list(
		/datum/migrant_role/crimson_dragon = 1,
	)
	greet_text = "A deserter from Lingyue. Travelling by yourself in search of a new place to live."

/datum/migrant_role/crimson_dragon
	name = "Crimson Dragon"
	greet_text = "You're a deserter of Lingyue's army. Hunted by the Dynasty, you've taken to Azure Peak to try and carve a new home."
	grant_lit_torch = TRUE
	forbidden_races = list(RACES_SMALL, RACES_CONSTRUCT, RACES_DESPISED)
