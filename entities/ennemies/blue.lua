function blueCreate() 
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = blueUpdate,
			draw = shipDraw,
			color = 12,
			degres = 0,
			score = 250,
			phase = 0,
			step = 0.1,
			rayon = 2,
			die = emptyFunction,
			spots = {
				{ degres= 0, rayon = 2},
				{ degres= 0.25, rayon = 4},
				{ degres= 0.5, rayon = 2},
				{ degres= 0.75, rayon = 4},
			}
	}
	return tmp
end

function blueUpdate(blue)
	blue.degres = 0
	if(blue.phase == 0) then
		blue.spots[2].rayon -= blue.step
		blue.spots[4].rayon -= blue.step
		if(blue.spots[2].rayon <= 2.1 ) blue.phase = 1
	end
	if(blue.phase == 1) then
		blue.spots[1].rayon += blue.step
		blue.spots[3].rayon += blue.step
		if(blue.spots[3].rayon >= 4 ) blue.phase = 2
	end
	if(blue.phase == 2) then
		blue.spots[1].rayon -= blue.step
		blue.spots[3].rayon -= blue.step
		if(blue.spots[3].rayon <= 2.1 ) blue.phase = 3
	end
	if(blue.phase == 3) then
		blue.spots[2].rayon += blue.step
		blue.spots[4].rayon += blue.step
		if(blue.spots[4].rayon >= 4 ) blue.phase = 0
	end


	dir = atan2(player.pos.x - blue.pos.x, player.pos.y - blue.pos.y)
	blue.pos.x += cos(dir)*0.5
	blue.pos.y += sin(dir)*0.5

	utilsClamp(blue)
end

function blueDraw(blue)
	shipDraw(blue)
end