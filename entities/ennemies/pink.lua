function pinkCreate() 
	if(#score<5) return violetCreate()
		
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = pinkUpdate,
			draw = pinkDraw,
			die = pinkDie,
			color = 14,
			degres = rnd(100)/100,
			score = 200,
			rayon = 2,
			spots = {
				{ degres= 0.125, rayon = 3},
				{ degres= 0.375, rayon = 3},
				{ degres= 0.625, rayon = 3},
				{ degres= 0.875, rayon = 3},
				{ degres= 0.125, rayon = 3},
				{ degres= 0.625, rayon = 3},
				{ degres= 0.875, rayon = 3},
				{ degres= 0.375, rayon = 3},
			}
	}
	return tmp
end

function pinkUpdate(pink)

	wantedDegres = atan2(player.pos.x - pink.pos.x, player.pos.y - pink.pos.y)
	delta = wantedDegres - pink.degres

	if(delta > 0.5) delta = -1 + delta
	if(delta > 0) pink.degres += 0.01
	if(delta < 0) pink.degres -= 0.01

	pink.pos.x += cos(pink.degres)*1.5
	pink.pos.y += sin(pink.degres)*1.5

	utilsClamp(pink)
end

function pinkDraw(pink)
	shipDraw(pink)
end

function pinkDie(pink)

	for i=1,3 do
		new = subpinkCreate()
		new.pos.x = pink.pos.x + rnd(4)-4
		new.pos.y = pink.pos.y + rnd(4)-4
		add(ennemies,new)
	end
end