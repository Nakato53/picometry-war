function createTextDecors(text,posx,posy)
	if(player.alive == false ) return 
	tmp = {
		pos = {x = posx, y = posy},
		text = text, 
		l = 45,
		update = textDecorUpdate,
		draw = textDecorDraw
}
	add(decors,tmp)
end


function textDecorUpdate(text)
	text.l-=1
	if(text.l < 0) del(decors,text)
end

function textDecorDraw(text)
	print(text.text, text.pos.x-3,text.pos.y-(45-text.l), 7)
end