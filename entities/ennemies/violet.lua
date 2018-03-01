function violetCreate() 
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = violetUpdate,
			draw = violetDraw,
			color = 13,
			degres = 0,
			dirDegres = 0,
			score = 150,
			wp = violetNextWP(),
			die = emptyFunction,
			rayon = 2,
			spots = {
				{ degres= 0, rayon = 0},
				{ degres= 0, rayon = 2},
				{ degres= 0.1, rayon = 2.5},
				{ degres= 0, rayon = 0},
				{ degres= 0.25, rayon = 2},
				{ degres= 0.35, rayon = 2.3},
				{ degres= 0, rayon = 0},
				{ degres= 0.5, rayon = 2},
				{ degres= 0.60, rayon = 2.3},
				{ degres= 0, rayon = 0},
				{ degres= 0.75, rayon = 2},
				{ degres= 0.85, rayon = 2.5},
			}
	}
	return tmp
end

function violetNextWP()
	return {pos= { x = rnd(108)+10, y= rnd(100)+10}}
end

function violetUpdate(violet)
	if(utilsDistance(violet,violet.wp) < 4) then
		violet.wp = violetNextWP()
	end

	wantedDegres = atan2(violet.wp.pos.x - violet.pos.x, violet.wp.pos.y - violet.pos.y)
	delta = wantedDegres - violet.dirDegres

	if(delta > 0.5) delta = -1 + delta
	if(delta > 0) violet.dirDegres += 0.005
	if(delta < 0) violet.dirDegres -= 0.005

	violet.pos.x += cos(violet.dirDegres)*0.5
	violet.pos.y += sin(violet.dirDegres)*0.5
	
	violet.degres += 0.005

	utilsClamp(violet)
end

function violetDraw(violet)
	shipDraw(violet)
	--line(violet.pos.x,violet.pos.y,violet.wp.pos.x, violet.wp.pos.y,12)
end