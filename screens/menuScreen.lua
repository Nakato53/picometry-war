function menuInit()
	pressX = {x = 50, step= 0.5}

	particlesInit()
	musicChange(musics.menu)
	cameraInit()
end

function menuUpdate()
	pressX.x += pressX.step
	if(pressX.x < 40 or pressX.x > 60) pressX.step*=-1

	
		pos = {x = flr(rnd(128)),y = flr(rnd(120))}

		particlesExplose(pos,flr(rnd(7))+7,2,30, 4)
	

	particlesUpdate()

	if(btn(4)) then

		-- stop the music with a 300 ms fade out
		music(-1, 300)
		screensChange(gameInit,gameUpdate,gameDraw)
	end

end

function menuDraw()
	
	rectfill(0,0,127,120,0) -- background

	particlesDraw()

	rectfill(0,20,127,40,1)
	line(0,19,127,19,7)
	line(0,41,127,41,7)
	print("picometry-war", 30,25, 7)
	print(" by nakato", 70,32,12)


	rectfill(0,98,127,108,0)
	line(0,97,127,97,7)
	line(0,109,127,109,7)
	print("press c", pressX.x,101,7)



end