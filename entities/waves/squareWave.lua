function createSquareWave()
	tmp = {
		update = squareWaveUpdate,
		draw = emptyFunction,
		timer = 0,
		nextwave = 350,
		ennemypool = {
			blueCreate,
			violetCreate,
			greenCreate
		}
	}
	return tmp
end

function squareWaveUpdate(wave)
	wave.timer += 1
	if(wave.timer > wave.nextwave) wavesChange()

	if(wave.timer == 1) then
		
		pos = {x = flr(rnd(60)+32), y = flr(rnd(48)+32) }
		
		--around player
		where = flr(rnd(100))
		if(where < 70 ) then
			pos = {x = player.pos.x, y = player.pos.y }
			utilsClampWaveSpawn(pos)
		end

		for x=-4,4,1 do
				--ligne haut
				tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = pos.x - (x*8), y = pos.y - 32 }
				tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
				spawnerCreate(tmp)

				-- ligne bas
				tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = pos.x - (x*8), y = pos.y + 32 }
				tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
				spawnerCreate(tmp)
		end
		for y=-3,3,1 do
				--ligne gauche
				tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = pos.x - 32, y = pos.y + (y*8) }
				tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
				spawnerCreate(tmp)


				--ligne droite
				tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
				tmp.pos = { x = pos.x + 32, y = pos.y + (y*8) }
				tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
				spawnerCreate(tmp)
		end
	end
end
