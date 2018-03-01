function createFollowPlayerWave()
	tmp = {
		update = followPlayerWaveUpdate,
		draw = emptyFunction,
		timer = 0,
		nextwave = 250,
		count = 0,
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

function followPlayerWaveUpdate(wave)
	wave.timer += 1

	if(wave.timer % 10 == 0) then

		if(wave.count == 0) then
			wave.pos = {x = player.pos.x, y = player.pos.y }
			if(wave.pos.x < 64) wave.pos.x += 8
			if(wave.pos.x > 64) wave.pos.x -= 8
			if(wave.pos.y < 64) wave.pos.y += 8
			if(wave.pos.y > 64) wave.pos.y -= 8
		else
			if(player.pos.x < wave.pos.x) wave.pos.x -= 8
			if(player.pos.x > wave.pos.x) wave.pos.x += 8	
			if(player.pos.y < wave.pos.y) wave.pos.y -= 8
			if(player.pos.y > wave.pos.y) wave.pos.y += 8
		end

		tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = wave.pos.x, y = wave.pos.y }
				tmp.degres = atan2(wave.pos.x - tmp.pos.x, wave.pos.y - tmp.pos.y)
				spawnerCreate(tmp)


		wave.count +=1

		if(wave.count > 19 ) wavesChange()

	end
end
