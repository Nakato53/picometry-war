
function weaponsFire(wpn)
	if(elapsedTime - wpn.last > wpn.cadence) then
		wpn.last = elapsedTime
		wpn.fire(wpn)
	end
end

function weaponsBomb()
	for e in all(ennemies) do
			particlesExplose( e.pos , e.color , 2 , 10, 4  )
			scoreAdd(e.score)
			e.die(e)
			del(ennemies,e)
	end
end