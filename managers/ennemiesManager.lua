function ennemiesInit()
	ennemies = {}
	currentBlackholes = 0
end

function ennemiesUpdate()
	
	--spawn pink
	--if(elapsedTime % 50 == 0) spawnerCreate(pinkCreate())
	--if(elapsedTime % 75 == 0) spawnerCreate(violetCreate())

	--if(elapsedTime % 100 == 0) spawnerCreate(ennemiesSpool[flr(rnd(#ennemiesSpool-1)+1)]())
	--if(elapsedTime % 50 == 0) spawnerCreate(violetCreate())
	--if(elapsedTime % 200 == 0) spawnerCreate(blackholeCreate())
	for e in all(ennemies) do
		e.update(e)

		if( utilsDistance(e,player) < 4 ) then
			playerDie()
		end
	end

end

function ennemiesDraw()

	for e in all(ennemies) do
		e.draw(e)
	end
end
