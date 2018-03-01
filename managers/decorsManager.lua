function decorsInit()
	decors = {}
end

function decorsUpdate()
	for e in all(decors) do
		e.update(e)
	end
end

function decorsDraw()
	for e in all(decors) do
		e.draw(e)
	end
end