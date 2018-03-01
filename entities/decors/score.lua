function createScoreDecors(ennemy)
	if(player.alive == false ) return 
	tmp = {
		pos = {x = ennemy.pos.x, y = ennemy.pos.y},
		score = ennemy.score*player.multiplier,
		l = 10,
		update = scoreDecorUpdate,
		draw = scoreDecorDraw
}
	add(decors,tmp)
end


function scoreDecorUpdate(score)
	score.l-=1
	if(score.l < 0) del(decors,score)
end

function scoreDecorDraw(score)
	print("+"..score.score, score.pos.x-3,score.pos.y-(10-score.l))
end