
function blackholeCreate()
	if((#score<6 ) or currentBlackholes > 1) return greenCreate()
	tmp = {
			pos = { x = rnd(108)+10, y= rnd(100)+10},
			update = blackholeUpdate,
			draw = blackholeDraw,
			color = 0,
			degres = 0,
			score = 30,
			life = 10,
			rayon = 3,
			l = 200,
			die = blackholeDie,
	}
	currentBlackholes+=1

	return tmp

end

function blackholeUpdate(blackhole)
	blackhole.l -= 1
	if(blackhole.l <= 0) then
		blackhole.die(blackhole)
		for i=1,5 do
			new = bluecircleCreate()
			new.pos.x = blackhole.pos.x + rnd(4)-4
			new.pos.y = blackhole.pos.y + rnd(4)-4
			add(ennemies,new)
		end
		del(ennemies,blackhole)
		return
	end
	
	nearBullets = utilsEntitiesGetNear(blackhole,bullets, blackhole.rayon*3.8)
	--repulse les bullets
	for e in all(nearBullets) do
		tmpX = (e.pos.x - blackhole.pos.x)*0.5
		tmpY = (e.pos.y - blackhole.pos.y)*0.5
		e.v.x += tmpX
		e.v.y += tmpY
	end

	nearParticles = utilsEntitiesGetNear(blackhole,particles, blackhole.rayon*3.8)
	for e in all(nearParticles) do
		tmpX = (e.pos.x - blackhole.pos.x)*0.5
		tmpY = (e.pos.y - blackhole.pos.y)*0.5
		e.v.x -= tmpX
		e.v.y -= tmpY
		dist = utilsDistance(blackhole,e)
		if(dist<5) then
			currentDegres= atan2(e.pos.x - blackhole.pos.x, e.pos.y - blackhole.pos.y)
			degres = currentDegres + 0.1
			e.v.x = cos(degres)*2
			e.v.y = sin(degres)*2
			e.l = 10
		end
	end
end


function blackholeDraw(blackhole)
		scale = blackhole.rayon + 1*sin(elapsedTime/10)
		circfill(blackhole.pos.x,blackhole.pos.y,scale,0)
        circ(blackhole.pos.x,blackhole.pos.y,scale,8)

        for i=0,1,0.1 do
        	  pset( blackhole.pos.x + cos(i)* (blackhole.rayon + 3*sin(elapsedTime/10)),blackhole.pos.y + sin(i)* (blackhole.rayon + 3*sin(elapsedTime/10)),0)
        end

end

function blackholeDie(blackhole)
	currentBlackholes -= 1
	particlesExplose(blackhole.pos , blackhole.color , 2, 50, 4)
end
