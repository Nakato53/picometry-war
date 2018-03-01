function soundsInit()
	sounds = {
		bomb = 1,
		bonusbomb = 7,
		bonusmultiplier = 6,
		bonuslife = 8,
		fire = 13
	}
	musics = {
		none = -1,
		menu = 1,
		game = 2
	}	 
end

function musicChange(musictoplay)
	music(musictoplay,300)
end

function soundsPlay(soundtoplay)
	sfx(soundtoplay)
end

