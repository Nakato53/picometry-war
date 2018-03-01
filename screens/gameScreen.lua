function gameInit()

	--init entities
	cursorInit()
	playerInit()

	--init managers
	
	uiInit()
	bulletsInit()
	ennemiesInit()
	particlesInit()
	scoreInit()
	spawnersInit()
	decorsInit()
	wavesInit()

	elapsedTime = 0

	musicChange(musics.game)

end

function gameUpdate()

	--entities Update
	cursorUpdate()
	playerUpdate()

	--managers Update
	ennemiesUpdate()
	bulletsUpdate()
	particlesUpdate()
	spawnersUpdate()
	decorsUpdate()
	wavesUpdate()


end

function gameDraw()
	
	--ui
	uiDraw()

	--managers Draw
	wavesDraw()
	spawnersDraw()
	ennemiesDraw()
	bulletsDraw()
	particlesDraw()
	decorsDraw()


	--entities Draw
	playerDraw()
	cursorDraw()


end