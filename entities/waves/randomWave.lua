function createRandomWave()
	tmp = {
		update = randomWaveUpdate,
		draw = emptyFunction,
		step = 20,
		timer = 0,
		nextwave = 300,
		ennemypool = {
			blackholeCreate,
			blueCreate,
			violetCreate,
			greenCreate,
			pinkCreate,
			redCreate,
			snakeCreate
		}
	}
	return tmp
end

function randomWaveUpdate(wave)
	wave.timer += 1
	if(wave.timer > wave.nextwave) wavesChange()

	if(elapsedTime%wave.step == 0)then
		spawnerCreate(wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
	end
end
