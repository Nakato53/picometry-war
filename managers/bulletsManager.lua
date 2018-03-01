function bulletsInit()
	bullets = {}
end

function bulletsUpdate()
	for e in all(bullets) do
		e.update(e)
	end
end

function bulletsDraw()
	for e in all(bullets) do
		e.draw(e)
	end
end
