function cameraInit()
	cam = {x = 0, y = 0, l = 0, size = 0}
end

function cameraUpdate()
	if(cam.l > 0) then
		cam.x = rnd(cam.size*2)-(cam.size)
		cam.y = rnd(cam.size*2)-(cam.size)
	else
		cam.x = 0
		cam.y = 0
	end
	cam.l -= 1
	cameraApply()
end

function cameraApply()
	camera(cam.x,cam.y)
end

function cameraReset()
	camera(0,0)
end

function cameraShake(size,length)
	if(cam.size <= size) then
		cam.l = length
		cam.size = size
	end
end