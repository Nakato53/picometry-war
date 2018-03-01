function screensInit()
	currentScreen = { init = emptyFunction, update = emptyFunction, draw = emptyFunction}
end

function screensChange(init,upd,draw)
	currentScreen.init = init
	currentScreen.update = upd
	currentScreen.draw = draw
	currentScreen.init()
end