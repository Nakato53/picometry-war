function redCreate() 
	if(#score<5 or (#score==5 and score[5]<=5) ) return greenCreate()
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = redUpdate,
			draw = redDraw,
			color = 8,
			degres = 0,
			die = emptyFunction,
			rayon = 2,
			score = 300,
			phase = 1,
			wp = nil,
			timer = 0,
			spots = {
				{ degres= 0.5, rayon = 1},
				{ degres= 0.15, rayon = 3},
				{ degres= 0.35, rayon = 3},
				{ degres= 0.65, rayon = 3},
				{ degres= 0.85, rayon = 3}
			}
	}
	return tmp
end

function redUpdate(red)


	if(red.phase == 1) then
		red.timer += 1
		red.degres = atan2(player.pos.x - red.pos.x, player.pos.y - red.pos.y)
		red.pos.x += cos(red.degres)*0.5
		red.pos.y += sin(red.degres)*0.5

		if(red.timer == 60) then
			red.phase = 2
			red.timer = 0
			
		end
	end
	if(red.phase == 2) then
		red.timer += 1


		red.wp = {pos={ x = red.pos.x + cos(red.degres)*60 , y = red.pos.y + sin(red.degres)*60}}

		red.degres = atan2(player.pos.x - red.pos.x, player.pos.y - red.pos.y)
		red.pos.x += cos(red.degres)*0.5
		red.pos.y += sin(red.degres)*0.5

		if(red.timer == 20) red.phase = 3
	end
	if(red.phase == 3) then

		red.degres = atan2(red.wp.pos.x - red.pos.x, red.wp.pos.y - red.pos.y)
		red.pos.x += cos(red.degres)*3
		red.pos.y += sin(red.degres)*3

		if(utilsDistance(red,red.wp) < 4 or ( red.pos.x < 4 or red.pos.x > 123 or red.pos.y < 4 or red.pos.y > 116)) then
			red.phase = 1
		end
	end

	utilsClamp(red)
end

function redDraw(red)
	if(red.phase == 2 and elapsedTime%2==0) then
		line(red.pos.x,red.pos.y,red.wp.pos.x, red.wp.pos.y,8)
	end
	shipDraw(red)
end