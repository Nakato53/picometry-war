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
end


function uiDraw()
	rectfill(0,0,127,120,1) -- background
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