function spawnersInit()
	spawners = {}
end

function spawnersUpdate()
	for e in all(spawners) do
		spawnerUpdate(e)
	end
end

function spawnersDraw()
	for e in all(spawners) do
		spawnerDraw(e)
	end
end