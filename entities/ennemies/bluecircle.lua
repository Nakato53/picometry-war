function bluecircleCreate() 
	if(#score<5 or (#score==5 and score[5]<=5) ) return greenCreate()
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = bluecircleUpdate,
			draw = bluecircleDraw,
			die = emptyFunction,
			color = 15,
			degres = rnd(100)/100,
			rayon = 2,
			score = 100
	}
	return tmp
end

function bluecircleUpdate(bluecircle)

	wantedDegres = atan2(player.pos.x - bluecircle.pos.x, player.pos.y - bluecircle.pos.y)
	delta = wantedDegres - bluecircle.degres

	if(delta > 0.5) delta = -1 + delta
	if(delta > 0) bluecircle.degres += 0.02
	if(delta < 0) bluecircle.degres -= 0.02

	bluecircle.pos.x += cos(bluecircle.degres)*2
	bluecircle.pos.y += sin(bluecircle.degres)*2


	utilsClamp(bluecircle)
end

function bluecircleDraw(bluecircle)
	circ(bluecircle.pos.x,bluecircle.pos.y,bluecircle.rayon,bluecircle.color)
	line(bluecircle.pos.x,bluecircle.pos.y, bluecircle.pos.x + (cos(bluecircle.degres)*bluecircle.rayon),bluecircle.pos.y + (sin(bluecircle.degres)*bluecircle.rayon),bluecircle.color )
end