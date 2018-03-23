function bulletUpdate(bullet)
	bullet.pos.x += bullet.v.x
	bullet.pos.y += bullet.v.y

	--test sortie zone
	if(bullet.pos.x < 1 or bullet.pos.x > 126 or bullet.pos.y < 1 or bullet.pos.y > 119 ) then
		utilsClamp(bullet)
		particlesExplose( bullet.pos , bullet.color , 2, 10,4)
		del(bullets,bullet)
	end

	--test ennemy
	for e in all(ennemies) do
		if(utilsDistance(bullet,e) <= e.rayon +1 ) then
			particlesExplose( e.pos , e.color , 2 ,10,4 )
			scoreAdd(e.score*player.multiplier)
			if(e.life != nil ) e.life-=1
			if(e.life == nil or e.life <= 0) then
				--grid wave
				local gridx = flr(e.pos.x/8) +1
				local gridy = flr(e.pos.y/8) +1

				gridWave(gridx, gridy, 1)
				
				e.die(e)
				createScoreDecors(e)
				if(player.alive == true) player.kills += 1
				del(ennemies,e)
				cameraShake(1,5)


			end
			del(bullets,bullet)
		end
		-- if(utilsInsideZone(bullet,e,2) == true) then
		-- 	particlesExplose( e.pos , e.color , 2  )
		-- 	del(ennemies,e)
		-- 	del(bullets,bullet)
		-- end
	end

end

function bulletDraw(bullet)
	pset(bullet.pos.x, bullet.pos.y,bullet.color)
end