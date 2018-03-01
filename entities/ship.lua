function shipDraw(ship)
	for i=1,#ship.spots do
		next = i+1
		
		if(next > #ship.spots) next = 1
			line( 
				ship.pos.x+(ship.spots[i].rayon*cos(ship.degres+ship.spots[i].degres)),
				ship.pos.y+(ship.spots[i].rayon*sin(ship.degres+ship.spots[i].degres)),
				ship.pos.x+(ship.spots[next].rayon*cos(ship.degres+ship.spots[next].degres)),
				ship.pos.y+(ship.spots[next].rayon*sin(ship.degres+ship.spots[next].degres)),
				ship.color
			)
	end
	if(debug == 1) circ(ship.pos.x,ship.pos.y,ship.rayon,8)
end