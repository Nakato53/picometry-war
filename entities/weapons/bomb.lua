function bombCreate()
	return {
		cadence = 100,
		last = 0,
		fire = bombFire
	}
end

function bombFire()
	if(player.bombCount > 0) then
	tmp = {
		update = bombUpdate,
		draw = bombDraw,
		rayon = 0,
		pos = {x = player.pos.x, y= player.pos.y}
	}
	add(decors,tmp)
	cameraShake(5,60)
	player.bombCount -= 1
	soundsPlay(sounds.bomb)
	end
end

function bombUpdate(bomb)
	bomb.rayon += 2
	for e in all(ennemies) do
		local distance = utilsDistance(bomb,e)
		if(distance < bomb.rayon) then
			particlesExplose( e.pos , e.color , 2 ,10 )
			scoreAdd(e.score*player.multiplier)
			createScoreDecors(e)
			e.die(e)
			if(player.alive == true) player.kills += 1
			del(ennemies,e)
		end
	end
	if(bomb.rayon > 160) del(decors,bomb)
end

function bombDraw(bomb)
	circ(bomb.pos.x,bomb.pos.y, bomb.rayon, 8)
	circ(bomb.pos.x,bomb.pos.y, bomb.rayon - 1, 9)
	circ(bomb.pos.x,bomb.pos.y, bomb.rayon - 2, 10)
	circ(bomb.pos.x,bomb.pos.y, bomb.rayon - 4, 7)
end