function snakeCreate() 
	if(#score< 6 ) return greenCreate()
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = snakeUpdate,
			draw = snakeDraw,
			die = emptyFunction,
			color = 3,
			degres = 0,
			trueDegres = rnd(100)/100,
			deltaDegres = 0,
			deltaStep = 0.05,
			score = 200,
			rayon = 2,
			spots = {
				{ degres= 0, rayon = 4},
				{ degres= 0.4, rayon = 4},
				{ degres= 0.6, rayon = 4},
			}
	}
	return tmp
end


function snakeTail(snake)
		tmp = {
			pos = { x = snake.pos.x, y = snake.pos.y },
			c = 10,
			v = { x = -cos(snake.degres), y = -sin(snake.degres) },
			l = 10
		}
		add(particles,tmp)
end

function snakeUpdate(snake)

	
	snake.trueDegres = atan2(player.pos.x - snake.pos.x, player.pos.y - snake.pos.y)
	snake.deltaDegres += snake.deltaStep
	if(snake.deltaDegres > 0.2 or snake.deltaDegres < -0.2) snake.deltaStep*= -1
	snake.degres = snake.trueDegres+snake.deltaDegres

	snake.pos.x += cos(snake.degres)*1.5
	snake.pos.y += sin(snake.degres)*1.5

	utilsClamp(snake)
	snakeTail(snake)
end

function snakeDraw(snake)
	shipDraw(snake)


end
