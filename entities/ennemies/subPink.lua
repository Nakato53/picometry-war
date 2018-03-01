function subpinkCreate() 
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = subpinkUpdate,
			draw = subpinkDraw,
			die = emptyFunction,
			color = 14,
			degres = rnd(100)/100,
			rayon = 1.5,
			score = 50,
			spots = {
				{ degres= 0.125, rayon = 1.5},
				{ degres= 0.375, rayon = 1.5},
				{ degres= 0.625, rayon = 1.5},
				{ degres= 0.875, rayon = 1.5},
				{ degres= 0.125, rayon = 1.5},
				{ degres= 0.625, rayon = 1.5},
				{ degres= 0.875, rayon = 1.5},
				{ degres= 0.375, rayon = 1.5},
			}
	}
	return tmp
end

function subpinkUpdate(pink)

	wantedDegres = atan2(player.pos.x - pink.pos.x, player.pos.y - pink.pos.y)
	delta = wantedDegres - pink.degres

	if(delta > 0.5) delta = -1 + delta
	if(delta > 0) pink.degres += 0.01
	if(delta < 0) pink.degres -= 0.01

	pink.pos.x += cos(pink.degres)*1.5
	pink.pos.y += sin(pink.degres)*1.5

	utilsClamp(pink)
end

function subpinkDraw(pink)
	shipDraw(pink)
end