function utilsClamp(o)
	if(o.pos.x < 4) o.pos.x = 4
	if(o.pos.x > 126) o.pos.x = 126
	if(o.pos.y < 4) o.pos.y = 4
	if(o.pos.y > 116) o.pos.y = 116	
end


function utilsClampBounce(o)
	if(o.pos.x < 2) o.v.x *= -1
	if(o.pos.x > 126) o.v.x *= -1
	if(o.pos.y < 2) o.v.y *= -1
	if(o.pos.y > 118) o.v.y *= -1
end

function utilsClampWaveSpawn(pos)
	if(pos.x < 36 )pos.x = 36
	if(pos.x > 92 )pos.x = 92
	if(pos.y < 32 )pos.y = 32
	if(pos.y > 80 )pos.y = 80
end


function utilsInsideZone(source,dest,taille)
	return ( source.pos.x > dest.pos.x - taille and source.pos.x < dest.pos.x + taille and source.pos.y > dest.pos.y - taille and source.pos.y < dest.pos.y + taille )
end

function utilsDistance(source,destination)
	return sqrt( ((destination.pos.x-source.pos.x)*(destination.pos.x-source.pos.x)) + ((destination.pos.y-source.pos.y)*(destination.pos.y-source.pos.y)) )
end


function emptyFunction(e)

end


function utilsEntitiesGetNear(obj, list, distance)
	retour = {}
	for e in all(list) do
		if(utilsDistance(obj,e) <= distance) add(retour,e)
	end
	return retour
end

function hex2num(str)
local obj={}
for i=1,#str do
obj[i]=("0x"..sub(str,i,i))+0
end
return obj
end