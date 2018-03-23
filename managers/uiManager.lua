function uiInit()
	lifeHUD ={
		color = 7,
		pos = {x = 90, y = 124 },
		degres = 0,
		spots = {
			{ degres= 0, rayon = 3},
			{ degres= 0.4, rayon = 3},
			{ degres= 0.6, rayon = 3},
		}
	}
	gridInit()
end

function uiUpdate()
	gridUpdate()
end


function gridInit()
	grid = {}
	for y=1,16 do
		grid[y] = {}
		for x=1,17 do
			grid[y][x] = { 
						pos= {
							x = (x-1)*8,
							y = (y-1)*8
						},
						offset = {
							x = 0,
							y = 0
						},
						velocity = {
						 	x = rnd(1)-0.5, 
						 	y = rnd(1)-0.5
						}
						
					}
		end
	end
end

function gridUpdate()
	for y=1,16 do
		for x=1,17 do
			local pt = grid[y][x]



			pt.offset.x += pt.velocity.x
			pt.offset.y += pt.velocity.y

		
			local angle = atan2(-pt.offset.x,-pt.offset.y)
			pt.velocity.x += cos(angle)*0.1
			pt.velocity.y += sin(angle)*0.1


			if(abs(pt.offset.x) < 1.0 )then 
				pt.velocity.x =0
				pt.offset.x = 0
			end
			if(abs(pt.offset.y) < 1.0 )then 
				pt.velocity.y =0
				pt.offset.y = 0
			end

		end
	end
end

function gridWave(x,y,f)

	if(x > 0 and x < 17 and y > 0 and y < 17) then

		if(x-1>1) grid[y][x-1].velocity.x = -f
		if(x+1<16) grid[y][x+1].velocity.x = f
		if(y-1>1) grid[y-1][x].velocity.y = -f
		if(y+1<16) grid[y+1][x].velocity.y = f


		if(x-1>1 and y-1 > 1) grid[y-1][x-1].velocity.x = -0.75*f
		if(x-1>1 and y-1 > 1) grid[y-1][x-1].velocity.y = -0.75*f

		if(x+1<16 and y+1 < 16)grid[y+1][x+1].velocity.x = 0.75*f
		if(x+1<16 and y+1 < 16)grid[y+1][x+1].velocity.y = 0.75*f


		if(x+1<16 and y-1 > 1)grid[y-1][x+1].velocity.x = 0.75*f
		if(x+1<16 and y-1 > 1)grid[y-1][x+1].velocity.y = -0.75*f


		if(x-1>1 and y+1 < 16)grid[y+1][x-1].velocity.x = -0.75*f
		if(x-1>1 and y+1 < 16 )grid[y+1][x-1].velocity.y = 0.75*f	

	end

end

function gridPoint(x,y)
	if(x < 1 or x > 17 or y < 1 or y > 17) then
		local tmp= { x = x*16, y = y*16}
		return tmp
	end

	return {x=grid[y][x].pos.x + grid[y][x].offset.x, y = grid[y][x].pos.y + grid[y][x].offset.y }
end

function drawGridPoint(x,y)

	local myPoint = gridPoint(x,y)
	local rightPoint = gridPoint(x+1,y)
	local downPoint = gridPoint(x,y-1)

	line(myPoint.x, myPoint.y, rightPoint.x, rightPoint.y,1)
	line(myPoint.x, myPoint.y, downPoint.x, downPoint.y,1)

end

function uiDraw()
	rectfill(0,0,127,120,0) -- background

	--grid
	for y=1,16 do
		for x=1,16 do
			drawGridPoint(x,y)
		end
	end

	rect(0,0,127,120,12) --contour
	scoreDraw(1,122) --score


	


	print("mult:"..player.multiplier,60,122,7)	 --multiplier

	shipDraw(lifeHUD)
	print(":"..player.life,95,122,7)	 --life 

	circ(110,124,3,8)	
	circ(110,124,2,9)
	circ(110,124,1,10)		
	print(":"..player.bombCount,116,122,7)	 --bomb
end