debug = 0
scale = 1
function _init()
	timeInit()
	soundsInit()
	screensInit()
	screensChange(menuInit,menuUpdate,menuDraw)
end
function _update()
	timeUpdate()
	currentScreen.update()
end
function _draw()
	cls()
	currentScreen.draw()
end