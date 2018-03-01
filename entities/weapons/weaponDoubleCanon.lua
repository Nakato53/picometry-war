function WDCCreate()
	return {
		cadence = 3,
		last = 0,
		fire = WDCFire
	}
end

function WDCFire()
	soundsPlay(sounds.fire)
	tmp = {
			pos = {x = player.pos.x+(2*cos(player.degres-0.1)) , y = player.pos.y+(2*sin(player.degres-0.1))},
			update = bulletUpdate,
			draw = bulletDraw,
			v = {x = 0, y=0},
			color = 10
		}
	tmp.v.x = cos(player.degres)*7
	tmp.v.y = sin(player.degres)*7

	tmp.pos.x = tmp.pos.x - tmp.v.x
	tmp.pos.y = tmp.pos.y - tmp.v.y

	add(bullets,tmp)


	tmp = {
			pos = {x = player.pos.x+(2*cos(player.degres+0.1)) , y = player.pos.y+(2*sin(player.degres+0.1))},
			update = bulletUpdate,
			draw = bulletDraw,
			v = {x = 0, y=0},
			color = 10
		}
	tmp.v.x = cos(player.degres)*7
	tmp.v.y = sin(player.degres)*7

	
	tmp.pos.x = tmp.pos.x - tmp.v.x
	tmp.pos.y = tmp.pos.y - tmp.v.y


	add(bullets,tmp)
end