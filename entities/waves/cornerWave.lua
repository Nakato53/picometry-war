function createCornerWave()
	tmp = {
		update = cornerWaveUpdate,
		draw = emptyFunction,
		timer = 0,
		nextwave = 250,
		count = 0,
		point = 0,
		pos = nil,
		ennemypool = {
			blueCreate,
			violetCreate,
			greenCreate,
			redCreate,
			pinkCreate
		}
	}
	return tmp
end

function cornerWaveUpdate(wave)
	wave.timer += 1

	if(wave.timer % 15 == 0) then
		if(wave.point == 0) wave.pos = {x = 10, y = 10 }
		if(wave.point == 1) wave.pos = {x = 118, y = 10 }
		if(wave.point == 2) wave.pos = {x = 10, y = 110 }
		if(wave.point == 3) wave.pos = {x = 118, y = 110 }
		wave.point+=1
		if(wave.point == 4) wave.point = 0

		tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = wave.pos.x, y = wave.pos.y }
				tmp.degres = atan2(wave.pos.x - tmp.pos.x, wave.pos.y - tmp.pos.y)
				spawnerCreate(tmp)

		wave.count +=1

		if(wave.count > 19 ) wavesChange()

	end
end
