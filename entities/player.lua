function playerInit()

	player = {
		life = 3,
		multiplier = 1,
		pos={x=64,y=64},
		degres = 0,
		v = {x = 0, y=0},
		speed = 0.1,
		maxspeed = 2,
		kills = 0,
		color = 7,
		bombCount = 0,
		alive = true,
		bomb = bombCreate(),
		weapon = nil,
		tag = "p",
		timer = 0,
		spots = {
			{ degres= 0, rayon = 3},
			{ degres= 0.4, rayon = 3},
			{ degres= 0.6, rayon = 3},
		}
	}
	playerSetWeapon(WDCCreate())
end

function playerSetWeapon(wpn)
	player.wpn = wpn
end

function playerUpdate()
	player.timer+=1

	if(player.alive == true ) then
		if(player.multiplier == 1 and player.kills > 25) then
			player.multiplier = 2
			soundsPlay(sounds.bonusmultiplier)
			createTextDecors("Multplicateur x2", 50,120)
		end
		if(player.multiplier == 2 and player.kills > 50)  then 
			player.multiplier = 3
			soundsPlay(sounds.bonusmultiplier)
			createTextDecors("Multplicateur x3", 50,120)
		end
		if(player.multiplier == 3 and player.kills > 500) then  
			player.multiplier = 10
			soundsPlay(sounds.bonusmultiplier)
			createTextDecors("Multplicateur x10", 50,120)
		end

		if(btn(0,1)) player.pos.x -= player.maxspeed
		if(btn(1,1)) player.pos.x += player.maxspeed
		if(btn(2,1)) player.pos.y -= player.maxspeed
		if(btn(3,1)) player.pos.y += player.maxspeed

		utilsClamp(player)

		player.degres = atan2(mouse.pos.x - player.pos.x, mouse.pos.y - player.pos.y)


		if(mouse.click == true ) then
			weaponsFire(player.wpn)
		end

		if(mouse.rightclick == true) then
			weaponsFire(player.bomb)
		end
	else
		player.pos={x=64,y=64}
		if(player.timer > 80 ) then
			if(player.life == 0) screensChange(gameoverInit,gameoverUpdate,gameoverDraw)
			player.alive = true
			player.timer = 0
			currentWave =createRandomWave()
		end
	end
end


-- function playerTail()
-- 		tmp = {
-- 			pos = { x = player.pos.x, y = player.pos.y },
-- 			c = player.color,
-- 			v = { x = -cos(player.degres), y = -sin(player.degres) },
-- 			l = 10
-- 		}
-- 		add(particles,tmp)
-- end

function playerDie()
	if(player.alive == true) then
		player.life -= 1



		player.bombCount += 1
		player.bomb.fire(player.bomb)
		player.alive = false
		player.multiplier = 1
		player.timer = 0
		player.kills = 0
	end
end

function playerDraw()
	if(player.alive == true and  (player.timer > 30 or player.timer % 2 == 0 ) ) shipDraw(player)
end