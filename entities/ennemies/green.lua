function greenCreate() 
		if(#score<5) return violetCreate()

	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = greenUpdate,
			draw = shipDraw,
			color = 11,
			degres = 0,
			die = emptyFunction,
			rayon = 3,
			score = 300,
			spots = {
				{ degres= 0, rayon = 3},
				{ degres= 0.25, rayon = 3},
				{ degres= 0.5, rayon = 3},
				{ degres= 0.75, rayon = 3},
			}
	}
	return tmp
end

function greenUpdate(green)
	green.degres = atan2(player.pos.x - green.pos.x, player.pos.y - green.pos.y)
	green.pos.x += cos(green.degres)*1.7
	green.pos.y += sin(green.degres)*1.7
	utilsClamp(green)
end

function greenDraw(green)
	ship_draw(green)
end