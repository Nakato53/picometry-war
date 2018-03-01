function cursorInit()
	mouse = { pos = { x = 0, y = 0} , click = false, lastclick = false, rightclick = false}
end

function cursorUpdate()
	if(mouse.click == true) then
		mouse.lastclick = true
	else
		mouse.lastclick = false
	end
	poke(0x5F2D, 1)
	mouse.pos.x = stat(32)
	mouse.pos.y = stat(33)
	mouse.click =  stat(34) == 1
	mouse.rightclick =  stat(34) == 2
	utilsClamp(mouse)
end

function cursorDraw()
	line(mouse.pos.x - 3, mouse.pos.y, mouse.pos.x - 1, mouse.pos.y, 9)
	line(mouse.pos.x +1, mouse.pos.y, mouse.pos.x +3, mouse.pos.y, 9)
	line(mouse.pos.x , mouse.pos.y-3, mouse.pos.x , mouse.pos.y-1, 9)
	line(mouse.pos.x , mouse.pos.y+1, mouse.pos.x , mouse.pos.y+3, 9)
end