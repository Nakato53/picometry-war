function createCircleWave()
	tmp = {
		update = circleWaveUpdate,
		draw = emptyFunction,
		timer = 0,
		nextwave = 250,
		ennemypool = {
			blueCreate,
			violetCreate,
			greenCreate
		}
	}
	return tmp
end

function circleWaveUpdate(wave)
	wave.timer += 1
	if(wave.timer > wave.nextwave) wavesChange()

	if(wave.timer == 1) then

		pos = {x = flr(rnd(60)+32), y = flr(rnd(42)+40) }
		
		--around player
		where = flr(rnd(100))
		if(where < 10 ) then
			pos = {x = player.pos.x, y = player.pos.y }
			utilsClampWaveSpawn(pos)
		end

		local nbTotal = 20
		for i=1,nbTotal do
			--ligne haut
				tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = pos.x+cos(i/nbTotal)*8*4, y = pos.y + sin(i/nbTotal)*8*4 }
				tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
				spawnerCreate(tmp)
		end
	end
end
