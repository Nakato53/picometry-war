function particlesInit()
	particles = {}
end

function particlesUpdate()
	for e in all(particles) do
		e.pos.x += e.v.x
		e.pos.y += e.v.y
		utilsClampBounce(e)
		e.l -= 1
		if(e.l <= 0) del(particles,e)
	end

	-- if(elapsedTime % 30 == 0) then
	-- 	particlesExplose( {x = flr(rnd(100))+10, y= flr(rnd(100))+10 } , flr(rnd(10))+4, 2  )
	-- end
end

function particlesDraw()
	for e in all(particles) do
		pset(e.pos.x, e.pos.y,e.c)
	end
end

function particlesExplose(position,color,speed,count, speedmax)
	if(speedmax == nil) speedmax = speed
	delta = speedmax - speed

	for i=0,count,1 do
		tmp = {
			pos = { x = position.x, y = position.y },
			c = color,
			v = { x = cos( (i/count) + (rnd(0.05)-0.05) )*(flr(rnd(delta))+speed), y = sin( (i/count)+ (rnd(0.05)-0.05))*(flr(rnd(delta))+speed) },
			l = 10
		}
		add(particles,tmp)
	end
end