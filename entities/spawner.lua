function spawnerCreate(ennemy)
	tmp = {
		tocreate = ennemy,
		t = elapsedTime,
		totalTime = 30
	}
	add(spawners,tmp)
end

function spawnerUpdate(spawner)
	if(elapsedTime - spawner.t > spawner.totalTime) then 
		add(ennemies,spawner.tocreate)
		del(spawners,spawner)
	end
end

function spawnerDraw(spawner)
	circfill(spawner.tocreate.pos.x,spawner.tocreate.pos.y, cos(elapsedTime/3)*2  , spawner.tocreate.color)
end




