function scoreInit()
	score = { 0,0,0,0 }
end

function scoreAdd(value)
	if(player.alive == false ) return  
	value = tostr(value)

	for i=1,#value do
		local str = hex2num(sub(value,-i, -i))[1]
		scoreAddToArray(str,i)
	end
end

function scoreAddToArray(chiffre,colonne)
	if(score[colonne] == nil) score[colonne] = 0
	

	score[colonne]+=chiffre

	if(colonne == 5 and (score[colonne] == 5 or  score[colonne] == 0) ) then
		player.bombCount+=1
		soundsPlay(sounds.bonusbomb)
		createTextDecors("+1 bombe", 70,120)
	end

	if(score[colonne] > 9) then
		delta = score[colonne]-10
		score[colonne] = delta
		if(colonne+1 == 6) then
			createTextDecors("+1 vie", 70,120)
			soundsPlay(sounds.bonuslife)
			player.life += 1
		end
		scoreAddToArray(1,colonne+1)
	end
end

function scoreDraw(x,y)
	for i=1,#score do
		print(score[#score-i+1], i*4 +x, y,7)
	end	
end
