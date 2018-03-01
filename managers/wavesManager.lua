function wavesInit()
	waves = {
		createCornerWave,
		createFollowPlayerWave,
		createRandomWave,
		createSquareWave,
		createCircleWave
	}
	currentWave =createRandomWave()
end

function wavesUpdate()
	if(player.alive == true) currentWave.update(currentWave)
end

function wavesDraw()
	currentWave.draw(currentWave)
end

function wavesChange()
	currentWave = waves[flr(rnd(#waves)+1)]()
end