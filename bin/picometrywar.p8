pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- picometrie-war
-- by nakato
-- ./main.lua
debug = 0
scale = 1
function _init()
timeinit()
soundsinit()
screensinit()
screenschange(menuinit,menuupdate,menudraw)
end
function _update()
timeupdate()
currentscreen.update()
end
function _draw()
cls()
currentscreen.draw()
end




































































































































































-- ./managers/decorsmanager.lua
function decorsinit()
decors = {}
end

function decorsupdate()
for e in all(decors) do
e.update(e)
end
end

function decorsdraw()
for e in all(decors) do
e.draw(e)
end
end
-- ./managers/timemanager.lua
function timeinit()
elapsedtime = 0
end

function timeupdate()
elapsedtime += 1
end
-- ./managers/wavesmanager.lua
function wavesinit()
waves = {
createcornerwave,
createfollowplayerwave,
createrandomwave,
createsquarewave,
createcirclewave
}
currentwave =createrandomwave()
end

function wavesupdate()
if(player.alive == true) currentwave.update(currentwave)
end

function wavesdraw()
currentwave.draw(currentwave)
end

function waveschange()
currentwave = waves[flr(rnd(#waves)+1)]()
end
-- ./managers/bulletsmanager.lua
function bulletsinit()
bullets = {}
end

function bulletsupdate()
for e in all(bullets) do
e.update(e)
end
end

function bulletsdraw()
for e in all(bullets) do
e.draw(e)
end
end

-- ./managers/particlesmanager.lua
function particlesinit()
particles = {}
end

function particlesupdate()
for e in all(particles) do
e.pos.x += e.v.x
e.pos.y += e.v.y
utilsclampbounce(e)
e.l -= 1
if(e.l <= 0) del(particles,e)
end

-- if(elapsedtime % 30 == 0) then
-- particlesexplose( {x = flr(rnd(100))+10, y= flr(rnd(100))+10 } , flr(rnd(10))+4, 2 )
-- end
end

function particlesdraw()
for e in all(particles) do
pset(e.pos.x, e.pos.y,e.c)
end
end

function particlesexplose(position,color,speed,count, speedmax)
if(speedmax == nil) speedmax = speed
delta = speedmax - speed

for i=0,count,1 do
tmp = {
pos = { x = position.x, y = position.y },
c = color,
v = { x = cos( (i/count) + (rnd(0.05)-0.05) )*(flr(rnd(delta))+speed), y = sin( (i/count)+ (rnd(0.05)-0.05))*(flr(rnd(delta))+speed) },
l = 10
}
add(particles,tmp)
end
end
-- ./managers/ennemiesmanager.lua
function ennemiesinit()
ennemies = {}
currentblackholes = 0
end

function ennemiesupdate()

--spawn pink
--if(elapsedtime % 50 == 0) spawnercreate(pinkcreate())
--if(elapsedtime % 75 == 0) spawnercreate(violetcreate())

--if(elapsedtime % 100 == 0) spawnercreate(ennemiesspool[flr(rnd(#ennemiesspool-1)+1)]())
--if(elapsedtime % 50 == 0) spawnercreate(violetcreate())
--if(elapsedtime % 200 == 0) spawnercreate(blackholecreate())
for e in all(ennemies) do
e.update(e)

if( utilsdistance(e,player) < 4 ) then
playerdie()
end
end

end

function ennemiesdraw()

for e in all(ennemies) do
e.draw(e)
end
end

-- ./managers/uimanager.lua
function uiinit()
lifehud ={
color = 7,
pos = {x = 90, y = 124 },
degres = 0,
spots = {
{ degres= 0, rayon = 3},
{ degres= 0.4, rayon = 3},
{ degres= 0.6, rayon = 3},
}
}
end


function uidraw()
rectfill(0,0,127,120,1) -- background
rect(0,0,127,120,12) --contour
scoredraw(1,122) --score

print("mult:"..player.multiplier,60,122,7) --multiplier

shipdraw(lifehud)
print(":"..player.life,95,122,7) --life

circ(110,124,3,8)
circ(110,124,2,9)
circ(110,124,1,10)
print(":"..player.bombcount,116,122,7) --bomb


end
-- ./managers/scoremanager.lua
function scoreinit()
score = { 0,0,0,0 }
end

function scoreadd(value)
if(player.alive == false ) return
value = tostr(value)

for i=1,#value do
local str = hex2num(sub(value,-i, -i))[1]
scoreaddtoarray(str,i)
end
end

function scoreaddtoarray(chiffre,colonne)
if(score[colonne] == nil) score[colonne] = 0


score[colonne]+=chiffre

if(colonne == 5 and (score[colonne] == 5 or score[colonne] == 0) ) then
player.bombcount+=1
soundsplay(sounds.bonusbomb)
createtextdecors("+1 bombe", 70,120)
end

if(score[colonne] > 9) then
delta = score[colonne]-10
score[colonne] = delta
if(colonne+1 == 6) then
createtextdecors("+1 vie", 70,120)
soundsplay(sounds.bonuslife)
player.life += 1
end
scoreaddtoarray(1,colonne+1)
end
end

function scoredraw(x,y)
for i=1,#score do
print(score[#score-i+1], i*4 +x, y,7)
end
end

-- ./managers/screensmanager.lua
function screensinit()
currentscreen = { init = emptyfunction, update = emptyfunction, draw = emptyfunction}
end

function screenschange(init,upd,draw)
currentscreen.init = init
currentscreen.update = upd
currentscreen.draw = draw
currentscreen.init()
end
-- ./managers/soundsmanager.lua
function soundsinit()
sounds = {
bomb = 1,
bonusbomb = 7,
bonusmultiplier = 6,
bonuslife = 8,
fire = 13
}
musics = {
none = -1,
menu = 1,
game = 2
}
end

function musicchange(musictoplay)
music(musictoplay,300)
end

function soundsplay(soundtoplay)
sfx(soundtoplay)
end


-- ./managers/weaponsmanager.lua

function weaponsfire(wpn)
if(elapsedtime - wpn.last > wpn.cadence) then
wpn.last = elapsedtime
wpn.fire(wpn)
end
end

function weaponsbomb()
for e in all(ennemies) do
particlesexplose( e.pos , e.color , 2 , 10, 4 )
scoreadd(e.score)
e.die(e)
del(ennemies,e)
end
end
-- ./managers/spawnersmanager.lua
function spawnersinit()
spawners = {}
end

function spawnersupdate()
for e in all(spawners) do
spawnerupdate(e)
end
end

function spawnersdraw()
for e in all(spawners) do
spawnerdraw(e)
end
end
-- ./utils/utils.lua
function utilsclamp(o)
if(o.pos.x < 4) o.pos.x = 4
if(o.pos.x > 126) o.pos.x = 126
if(o.pos.y < 4) o.pos.y = 4
if(o.pos.y > 116) o.pos.y = 116
end


function utilsclampbounce(o)
if(o.pos.x < 2) o.v.x *= -1
if(o.pos.x > 126) o.v.x *= -1
if(o.pos.y < 2) o.v.y *= -1
if(o.pos.y > 118) o.v.y *= -1
end

function utilsclampwavespawn(pos)
if(pos.x < 36 )pos.x = 36
if(pos.x > 92 )pos.x = 92
if(pos.y < 32 )pos.y = 32
if(pos.y > 80 )pos.y = 80
end


function utilsinsidezone(source,dest,taille)
return ( source.pos.x > dest.pos.x - taille and source.pos.x < dest.pos.x + taille and source.pos.y > dest.pos.y - taille and source.pos.y < dest.pos.y + taille )
end

function utilsdistance(source,destination)
return sqrt( ((destination.pos.x-source.pos.x)*(destination.pos.x-source.pos.x)) + ((destination.pos.y-source.pos.y)*(destination.pos.y-source.pos.y)) )
end


function emptyfunction(e)

end


function utilsentitiesgetnear(obj, list, distance)
retour = {}
for e in all(list) do
if(utilsdistance(obj,e) <= distance) add(retour,e)
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
-- ./screens/gameoverscreen.lua
function gameoverinit()

pressx = {x = 50, step= 0.5}

particlesinit()

musicchange(musics.none)

end

function gameoverupdate()


pressx.x += pressx.step
if(pressx.x < 40 or pressx.x > 60) pressx.step*=-1


pos = {x = flr(rnd(128)),y = flr(rnd(120))}

particlesexplose(pos,flr(rnd(7))+7,2,30, 4)


particlesupdate()

if(btn(5)) then
screenschange(menuinit,menuupdate,menudraw)
end

end

function gameoverdraw()


rectfill(0,0,127,120,0) -- background

particlesdraw()

rectfill(0,20,127,40,1)
line(0,19,127,19,7)
line(0,41,127,41,7)
print("game-over :", 30,25, 7)
scoredraw(70,32) --score

rectfill(0,98,127,108,0)
line(0,97,127,97,7)
line(0,109,127,109,7)
print("press x", pressx.x,101,7)


end
-- ./screens/menuscreen.lua
function menuinit()
pressx = {x = 50, step= 0.5}

particlesinit()
musicchange(musics.menu)

end

function menuupdate()
pressx.x += pressx.step
if(pressx.x < 40 or pressx.x > 60) pressx.step*=-1


pos = {x = flr(rnd(128)),y = flr(rnd(120))}

particlesexplose(pos,flr(rnd(7))+7,2,30, 4)


particlesupdate()

if(btn(4)) then

-- stop the music with a 300 ms fade out
music(-1, 300)
screenschange(gameinit,gameupdate,gamedraw)
end

end

function menudraw()

rectfill(0,0,127,120,0) -- background

particlesdraw()

rectfill(0,20,127,40,1)
line(0,19,127,19,7)
line(0,41,127,41,7)
print("picometry-war", 30,25, 7)
print(" by nakato", 70,32,12)


rectfill(0,98,127,108,0)
line(0,97,127,97,7)
line(0,109,127,109,7)
print("press c", pressx.x,101,7)



end
-- ./screens/gamescreen.lua
function gameinit()

--init entities
cursorinit()
playerinit()

--init managers

uiinit()
bulletsinit()
ennemiesinit()
particlesinit()
scoreinit()
spawnersinit()
decorsinit()
wavesinit()

elapsedtime = 0

musicchange(musics.game)

end

function gameupdate()

--entities update
cursorupdate()
playerupdate()

--managers update
ennemiesupdate()
bulletsupdate()
particlesupdate()
spawnersupdate()
decorsupdate()
wavesupdate()


end

function gamedraw()

--ui
uidraw()

--managers draw
wavesdraw()
spawnersdraw()
ennemiesdraw()
bulletsdraw()
particlesdraw()
decorsdraw()


--entities draw
playerdraw()
cursordraw()


end
-- ./entities/bullet.lua
function bulletupdate(bullet)
bullet.pos.x += bullet.v.x
bullet.pos.y += bullet.v.y

--test sortie zone
if(bullet.pos.x < 1 or bullet.pos.x > 126 or bullet.pos.y < 1 or bullet.pos.y > 119 ) then
utilsclamp(bullet)
particlesexplose( bullet.pos , bullet.color , 2, 10,4)
del(bullets,bullet)
end

--test ennemy
for e in all(ennemies) do
if(utilsdistance(bullet,e) <= e.rayon +1 ) then
particlesexplose( e.pos , e.color , 2 ,10,4 )
scoreadd(e.score*player.multiplier)
if(e.life != nil ) e.life-=1
if(e.life == nil or e.life <= 0) then
e.die(e)
createscoredecors(e)
if(player.alive == true) player.kills += 1
del(ennemies,e)
end
del(bullets,bullet)
end
-- if(utilsinsidezone(bullet,e,2) == true) then
-- particlesexplose( e.pos , e.color , 2 )
-- del(ennemies,e)
-- del(bullets,bullet)
-- end
end

end

function bulletdraw(bullet)
pset(bullet.pos.x, bullet.pos.y,bullet.color)
end
-- ./entities/cursor.lua
function cursorinit()
mouse = { pos = { x = 0, y = 0} , click = false, lastclick = false, rightclick = false}
end

function cursorupdate()
if(mouse.click == true) then
mouse.lastclick = true
else
mouse.lastclick = false
end
poke(0x5f2d, 1)
mouse.pos.x = stat(32)
mouse.pos.y = stat(33)
mouse.click = stat(34) == 1
mouse.rightclick = stat(34) == 2
utilsclamp(mouse)
end

function cursordraw()
line(mouse.pos.x - 3, mouse.pos.y, mouse.pos.x - 1, mouse.pos.y, 9)
line(mouse.pos.x +1, mouse.pos.y, mouse.pos.x +3, mouse.pos.y, 9)
line(mouse.pos.x , mouse.pos.y-3, mouse.pos.x , mouse.pos.y-1, 9)
line(mouse.pos.x , mouse.pos.y+1, mouse.pos.x , mouse.pos.y+3, 9)
end
-- ./entities/ship.lua
function shipdraw(ship)
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
-- ./entities/decors/score.lua
function createscoredecors(ennemy)
if(player.alive == false ) return
tmp = {
pos = {x = ennemy.pos.x, y = ennemy.pos.y},
score = ennemy.score*player.multiplier,
l = 10,
update = scoredecorupdate,
draw = scoredecordraw
}
add(decors,tmp)
end


function scoredecorupdate(score)
score.l-=1
if(score.l < 0) del(decors,score)
end

function scoredecordraw(score)
print("+"..score.score, score.pos.x-3,score.pos.y-(10-score.l))
end
-- ./entities/decors/text.lua
function createtextdecors(text,posx,posy)
if(player.alive == false ) return
tmp = {
pos = {x = posx, y = posy},
text = text,
l = 45,
update = textdecorupdate,
draw = textdecordraw
}
add(decors,tmp)
end


function textdecorupdate(text)
text.l-=1
if(text.l < 0) del(decors,text)
end

function textdecordraw(text)
print(text.text, text.pos.x-3,text.pos.y-(45-text.l), 7)
end
-- ./entities/weapons/weapondoublecanon.lua
function wdccreate()
return {
cadence = 3,
last = 0,
fire = wdcfire
}
end

function wdcfire()
soundsplay(sounds.fire)
tmp = {
pos = {x = player.pos.x+(2*cos(player.degres-0.1)) , y = player.pos.y+(2*sin(player.degres-0.1))},
update = bulletupdate,
draw = bulletdraw,
v = {x = 0, y=0},
color = 10
}
tmp.v.x = cos(player.degres)*7
tmp.v.y = sin(player.degres)*7

tmp.pos.x = tmp.pos.x - tmp.v.x
tmp.pos.y = tmp.pos.y - tmp.v.y

add(bullets,tmp)


tmp = {
pos = {x = player.pos.x+(2*cos(player.degres+0.1)) , y = player.pos.y+(2*sin(player.degres+0.1))},
update = bulletupdate,
draw = bulletdraw,
v = {x = 0, y=0},
color = 10
}
tmp.v.x = cos(player.degres)*7
tmp.v.y = sin(player.degres)*7


tmp.pos.x = tmp.pos.x - tmp.v.x
tmp.pos.y = tmp.pos.y - tmp.v.y


add(bullets,tmp)
end
-- ./entities/weapons/bomb.lua
function bombcreate()
return {
cadence = 100,
last = 0,
fire = bombfire
}
end

function bombfire()
if(player.bombcount > 0) then
tmp = {
update = bombupdate,
draw = bombdraw,
rayon = 0,
pos = {x = player.pos.x, y= player.pos.y}
}
add(decors,tmp)
player.bombcount -= 1
soundsplay(sounds.bomb)
end
end

function bombupdate(bomb)
bomb.rayon += 2
for e in all(ennemies) do
local distance = utilsdistance(bomb,e)
if(distance < bomb.rayon) then
particlesexplose( e.pos , e.color , 2 ,10 )
scoreadd(e.score*player.multiplier)
createscoredecors(e)
e.die(e)
if(player.alive == true) player.kills += 1
del(ennemies,e)
end
end
if(bomb.rayon > 160) del(decors,bomb)
end

function bombdraw(bomb)
circ(bomb.pos.x,bomb.pos.y, bomb.rayon, 8)
circ(bomb.pos.x,bomb.pos.y, bomb.rayon - 1, 9)
circ(bomb.pos.x,bomb.pos.y, bomb.rayon - 2, 10)
circ(bomb.pos.x,bomb.pos.y, bomb.rayon - 4, 7)
end
-- ./entities/spawner.lua
function spawnercreate(ennemy)
tmp = {
tocreate = ennemy,
t = elapsedtime,
totaltime = 30
}
add(spawners,tmp)
end

function spawnerupdate(spawner)
if(elapsedtime - spawner.t > spawner.totaltime) then
add(ennemies,spawner.tocreate)
del(spawners,spawner)
end
end

function spawnerdraw(spawner)
circfill(spawner.tocreate.pos.x,spawner.tocreate.pos.y, cos(elapsedtime/3)*2 , spawner.tocreate.color)
end





-- ./entities/wave.lua

-- ./entities/waves/squarewave.lua
function createsquarewave()
tmp = {
update = squarewaveupdate,
draw = emptyfunction,
timer = 0,
nextwave = 350,
ennemypool = {
bluecreate,
violetcreate,
greencreate
}
}
return tmp
end

function squarewaveupdate(wave)
wave.timer += 1
if(wave.timer > wave.nextwave) waveschange()

if(wave.timer == 1) then

pos = {x = flr(rnd(60)+32), y = flr(rnd(48)+32) }

--around player
where = flr(rnd(100))
if(where < 70 ) then
pos = {x = player.pos.x, y = player.pos.y }
utilsclampwavespawn(pos)
end

for x=-4,4,1 do
--ligne haut
tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = pos.x - (x*8), y = pos.y - 32 }
tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
spawnercreate(tmp)

-- ligne bas
tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = pos.x - (x*8), y = pos.y + 32 }
tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
spawnercreate(tmp)
end
for y=-3,3,1 do
--ligne gauche
tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = pos.x - 32, y = pos.y + (y*8) }
tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
spawnercreate(tmp)


--ligne droite
tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = pos.x + 32, y = pos.y + (y*8) }
tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
spawnercreate(tmp)
end
end
end

-- ./entities/waves/randomwave.lua
function createrandomwave()
tmp = {
update = randomwaveupdate,
draw = emptyfunction,
step = 20,
timer = 0,
nextwave = 300,
ennemypool = {
blackholecreate,
bluecreate,
violetcreate,
greencreate,
pinkcreate,
redcreate,
snakecreate
}
}
return tmp
end

function randomwaveupdate(wave)
wave.timer += 1
if(wave.timer > wave.nextwave) waveschange()

if(elapsedtime%wave.step == 0)then
spawnercreate(wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
end
end

-- ./entities/waves/cornerwave.lua
function createcornerwave()
tmp = {
update = cornerwaveupdate,
draw = emptyfunction,
timer = 0,
nextwave = 250,
count = 0,
point = 0,
pos = nil,
ennemypool = {
bluecreate,
violetcreate,
greencreate,
redcreate,
pinkcreate
}
}
return tmp
end

function cornerwaveupdate(wave)
wave.timer += 1

if(wave.timer % 15 == 0) then
if(wave.point == 0) wave.pos = {x = 10, y = 10 }
if(wave.point == 1) wave.pos = {x = 118, y = 10 }
if(wave.point == 2) wave.pos = {x = 10, y = 110 }
if(wave.point == 3) wave.pos = {x = 118, y = 110 }
wave.point+=1
if(wave.point == 4) wave.point = 0

tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = wave.pos.x, y = wave.pos.y }
tmp.degres = atan2(wave.pos.x - tmp.pos.x, wave.pos.y - tmp.pos.y)
spawnercreate(tmp)

wave.count +=1

if(wave.count > 19 ) waveschange()

end
end

-- ./entities/waves/circlewave.lua
function createcirclewave()
tmp = {
update = circlewaveupdate,
draw = emptyfunction,
timer = 0,
nextwave = 250,
ennemypool = {
bluecreate,
violetcreate,
greencreate
}
}
return tmp
end

function circlewaveupdate(wave)
wave.timer += 1
if(wave.timer > wave.nextwave) waveschange()

if(wave.timer == 1) then

pos = {x = flr(rnd(60)+32), y = flr(rnd(42)+40) }

--around player
where = flr(rnd(100))
if(where < 10 ) then
pos = {x = player.pos.x, y = player.pos.y }
utilsclampwavespawn(pos)
end

local nbtotal = 20
for i=1,nbtotal do
--ligne haut
tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = pos.x+cos(i/nbtotal)*8*4, y = pos.y + sin(i/nbtotal)*8*4 }
tmp.degres = atan2(pos.x - tmp.pos.x, pos.y - tmp.pos.y)
spawnercreate(tmp)
end
end
end

-- ./entities/waves/followplayerwave.lua
function createfollowplayerwave()
tmp = {
update = followplayerwaveupdate,
draw = emptyfunction,
timer = 0,
nextwave = 250,
count = 0,
pos = nil,
ennemypool = {
bluecreate,
violetcreate,
greencreate,
redcreate,
pinkcreate
}
}
return tmp
end

function followplayerwaveupdate(wave)
wave.timer += 1

if(wave.timer % 10 == 0) then

if(wave.count == 0) then
wave.pos = {x = player.pos.x, y = player.pos.y }
if(wave.pos.x < 64) wave.pos.x += 8
if(wave.pos.x > 64) wave.pos.x -= 8
if(wave.pos.y < 64) wave.pos.y += 8
if(wave.pos.y > 64) wave.pos.y -= 8
else
if(player.pos.x < wave.pos.x) wave.pos.x -= 8
if(player.pos.x > wave.pos.x) wave.pos.x += 8
if(player.pos.y < wave.pos.y) wave.pos.y -= 8
if(player.pos.y > wave.pos.y) wave.pos.y += 8
end

tmp = (wave.ennemypool[flr(rnd(#wave.ennemypool))+1]())
tmp.pos = { x = wave.pos.x, y = wave.pos.y }
tmp.degres = atan2(wave.pos.x - tmp.pos.x, wave.pos.y - tmp.pos.y)
spawnercreate(tmp)


wave.count +=1

if(wave.count > 19 ) waveschange()

end
end

-- ./entities/ennemies/pink.lua
function pinkcreate()
if(#score<5) return violetcreate()

tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = pinkupdate,
draw = pinkdraw,
die = pinkdie,
color = 14,
degres = rnd(100)/100,
score = 200,
rayon = 2,
spots = {
{ degres= 0.125, rayon = 3},
{ degres= 0.375, rayon = 3},
{ degres= 0.625, rayon = 3},
{ degres= 0.875, rayon = 3},
{ degres= 0.125, rayon = 3},
{ degres= 0.625, rayon = 3},
{ degres= 0.875, rayon = 3},
{ degres= 0.375, rayon = 3},
}
}
return tmp
end

function pinkupdate(pink)

wanteddegres = atan2(player.pos.x - pink.pos.x, player.pos.y - pink.pos.y)
delta = wanteddegres - pink.degres

if(delta > 0.5) delta = -1 + delta
if(delta > 0) pink.degres += 0.01
if(delta < 0) pink.degres -= 0.01

pink.pos.x += cos(pink.degres)*1.5
pink.pos.y += sin(pink.degres)*1.5

utilsclamp(pink)
end

function pinkdraw(pink)
shipdraw(pink)
end

function pinkdie(pink)

for i=1,3 do
new = subpinkcreate()
new.pos.x = pink.pos.x + rnd(4)-4
new.pos.y = pink.pos.y + rnd(4)-4
add(ennemies,new)
end
end
-- ./entities/ennemies/blue.lua
function bluecreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = blueupdate,
draw = shipdraw,
color = 12,
degres = 0,
score = 250,
phase = 0,
step = 0.1,
rayon = 2,
die = emptyfunction,
spots = {
{ degres= 0, rayon = 2},
{ degres= 0.25, rayon = 4},
{ degres= 0.5, rayon = 2},
{ degres= 0.75, rayon = 4},
}
}
return tmp
end

function blueupdate(blue)
blue.degres = 0
if(blue.phase == 0) then
blue.spots[2].rayon -= blue.step
blue.spots[4].rayon -= blue.step
if(blue.spots[2].rayon <= 2.1 ) blue.phase = 1
end
if(blue.phase == 1) then
blue.spots[1].rayon += blue.step
blue.spots[3].rayon += blue.step
if(blue.spots[3].rayon >= 4 ) blue.phase = 2
end
if(blue.phase == 2) then
blue.spots[1].rayon -= blue.step
blue.spots[3].rayon -= blue.step
if(blue.spots[3].rayon <= 2.1 ) blue.phase = 3
end
if(blue.phase == 3) then
blue.spots[2].rayon += blue.step
blue.spots[4].rayon += blue.step
if(blue.spots[4].rayon >= 4 ) blue.phase = 0
end


dir = atan2(player.pos.x - blue.pos.x, player.pos.y - blue.pos.y)
blue.pos.x += cos(dir)*0.5
blue.pos.y += sin(dir)*0.5

utilsclamp(blue)
end

function bluedraw(blue)
shipdraw(blue)
end
-- ./entities/ennemies/blackhole.lua

function blackholecreate()
if((#score<6 ) or currentblackholes > 1) return greencreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = blackholeupdate,
draw = blackholedraw,
color = 0,
degres = 0,
score = 30,
life = 10,
rayon = 3,
l = 200,
die = blackholedie,
}
currentblackholes+=1

return tmp

end

function blackholeupdate(blackhole)
blackhole.l -= 1
if(blackhole.l <= 0) then
blackhole.die(blackhole)
for i=1,5 do
new = bluecirclecreate()
new.pos.x = blackhole.pos.x + rnd(4)-4
new.pos.y = blackhole.pos.y + rnd(4)-4
add(ennemies,new)
end
del(ennemies,blackhole)
return
end

nearbullets = utilsentitiesgetnear(blackhole,bullets, blackhole.rayon*3.8)
--repulse les bullets
for e in all(nearbullets) do
tmpx = (e.pos.x - blackhole.pos.x)*0.5
tmpy = (e.pos.y - blackhole.pos.y)*0.5
e.v.x += tmpx
e.v.y += tmpy
end

nearparticles = utilsentitiesgetnear(blackhole,particles, blackhole.rayon*3.8)
for e in all(nearparticles) do
tmpx = (e.pos.x - blackhole.pos.x)*0.5
tmpy = (e.pos.y - blackhole.pos.y)*0.5
e.v.x -= tmpx
e.v.y -= tmpy
dist = utilsdistance(blackhole,e)
if(dist<5) then
currentdegres= atan2(e.pos.x - blackhole.pos.x, e.pos.y - blackhole.pos.y)
degres = currentdegres + 0.1
e.v.x = cos(degres)*2
e.v.y = sin(degres)*2
e.l = 10
end
end
end


function blackholedraw(blackhole)
scale = blackhole.rayon + 1*sin(elapsedtime/10)
circfill(blackhole.pos.x,blackhole.pos.y,scale,0)
circ(blackhole.pos.x,blackhole.pos.y,scale,8)

for i=0,1,0.1 do
pset( blackhole.pos.x + cos(i)* (blackhole.rayon + 3*sin(elapsedtime/10)),blackhole.pos.y + sin(i)* (blackhole.rayon + 3*sin(elapsedtime/10)),0)
end

end

function blackholedie(blackhole)
currentblackholes -= 1
particlesexplose(blackhole.pos , blackhole.color , 2, 50, 4)
end

-- ./entities/ennemies/violet.lua
function violetcreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = violetupdate,
draw = violetdraw,
color = 13,
degres = 0,
dirdegres = 0,
score = 150,
wp = violetnextwp(),
die = emptyfunction,
rayon = 2,
spots = {
{ degres= 0, rayon = 0},
{ degres= 0, rayon = 2},
{ degres= 0.1, rayon = 2.5},
{ degres= 0, rayon = 0},
{ degres= 0.25, rayon = 2},
{ degres= 0.35, rayon = 2.3},
{ degres= 0, rayon = 0},
{ degres= 0.5, rayon = 2},
{ degres= 0.60, rayon = 2.3},
{ degres= 0, rayon = 0},
{ degres= 0.75, rayon = 2},
{ degres= 0.85, rayon = 2.5},
}
}
return tmp
end

function violetnextwp()
return {pos= { x = rnd(108)+10, y= rnd(100)+10}}
end

function violetupdate(violet)
if(utilsdistance(violet,violet.wp) < 4) then
violet.wp = violetnextwp()
end

wanteddegres = atan2(violet.wp.pos.x - violet.pos.x, violet.wp.pos.y - violet.pos.y)
delta = wanteddegres - violet.dirdegres

if(delta > 0.5) delta = -1 + delta
if(delta > 0) violet.dirdegres += 0.005
if(delta < 0) violet.dirdegres -= 0.005

violet.pos.x += cos(violet.dirdegres)*0.5
violet.pos.y += sin(violet.dirdegres)*0.5

violet.degres += 0.005

utilsclamp(violet)
end

function violetdraw(violet)
shipdraw(violet)
--line(violet.pos.x,violet.pos.y,violet.wp.pos.x, violet.wp.pos.y,12)
end
-- ./entities/ennemies/green.lua
function greencreate()
if(#score<5) return violetcreate()

tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = greenupdate,
draw = shipdraw,
color = 11,
degres = 0,
die = emptyfunction,
rayon = 3,
score = 300,
spots = {
{ degres= 0, rayon = 3},
{ degres= 0.25, rayon = 3},
{ degres= 0.5, rayon = 3},
{ degres= 0.75, rayon = 3},
}
}
return tmp
end

function greenupdate(green)
green.degres = atan2(player.pos.x - green.pos.x, player.pos.y - green.pos.y)
green.pos.x += cos(green.degres)*1.7
green.pos.y += sin(green.degres)*1.7
utilsclamp(green)
end

function greendraw(green)
ship_draw(green)
end
-- ./entities/ennemies/subpink.lua
function subpinkcreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = subpinkupdate,
draw = subpinkdraw,
die = emptyfunction,
color = 14,
degres = rnd(100)/100,
rayon = 1.5,
score = 50,
spots = {
{ degres= 0.125, rayon = 1.5},
{ degres= 0.375, rayon = 1.5},
{ degres= 0.625, rayon = 1.5},
{ degres= 0.875, rayon = 1.5},
{ degres= 0.125, rayon = 1.5},
{ degres= 0.625, rayon = 1.5},
{ degres= 0.875, rayon = 1.5},
{ degres= 0.375, rayon = 1.5},
}
}
return tmp
end

function subpinkupdate(pink)

wanteddegres = atan2(player.pos.x - pink.pos.x, player.pos.y - pink.pos.y)
delta = wanteddegres - pink.degres

if(delta > 0.5) delta = -1 + delta
if(delta > 0) pink.degres += 0.01
if(delta < 0) pink.degres -= 0.01

pink.pos.x += cos(pink.degres)*1.5
pink.pos.y += sin(pink.degres)*1.5

utilsclamp(pink)
end

function subpinkdraw(pink)
shipdraw(pink)
end
-- ./entities/ennemies/bluecircle.lua
function bluecirclecreate()
if(#score<5 or (#score==5 and score[5]<=5) ) return greencreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = bluecircleupdate,
draw = bluecircledraw,
die = emptyfunction,
color = 15,
degres = rnd(100)/100,
rayon = 2,
score = 100
}
return tmp
end

function bluecircleupdate(bluecircle)

wanteddegres = atan2(player.pos.x - bluecircle.pos.x, player.pos.y - bluecircle.pos.y)
delta = wanteddegres - bluecircle.degres

if(delta > 0.5) delta = -1 + delta
if(delta > 0) bluecircle.degres += 0.02
if(delta < 0) bluecircle.degres -= 0.02

bluecircle.pos.x += cos(bluecircle.degres)*2
bluecircle.pos.y += sin(bluecircle.degres)*2


utilsclamp(bluecircle)
end

function bluecircledraw(bluecircle)
circ(bluecircle.pos.x,bluecircle.pos.y,bluecircle.rayon,bluecircle.color)
line(bluecircle.pos.x,bluecircle.pos.y, bluecircle.pos.x + (cos(bluecircle.degres)*bluecircle.rayon),bluecircle.pos.y + (sin(bluecircle.degres)*bluecircle.rayon),bluecircle.color )
end
-- ./entities/ennemies/snake.lua
function snakecreate()
if(#score< 6 ) return greencreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = snakeupdate,
draw = snakedraw,
die = emptyfunction,
color = 3,
degres = 0,
truedegres = rnd(100)/100,
deltadegres = 0,
deltastep = 0.05,
score = 200,
rayon = 2,
spots = {
{ degres= 0, rayon = 4},
{ degres= 0.4, rayon = 4},
{ degres= 0.6, rayon = 4},
}
}
return tmp
end


function snaketail(snake)
tmp = {
pos = { x = snake.pos.x, y = snake.pos.y },
c = 10,
v = { x = -cos(snake.degres), y = -sin(snake.degres) },
l = 10
}
add(particles,tmp)
end

function snakeupdate(snake)


snake.truedegres = atan2(player.pos.x - snake.pos.x, player.pos.y - snake.pos.y)
snake.deltadegres += snake.deltastep
if(snake.deltadegres > 0.2 or snake.deltadegres < -0.2) snake.deltastep*= -1
snake.degres = snake.truedegres+snake.deltadegres

snake.pos.x += cos(snake.degres)*1.5
snake.pos.y += sin(snake.degres)*1.5

utilsclamp(snake)
snaketail(snake)
end

function snakedraw(snake)
shipdraw(snake)


end

-- ./entities/ennemies/red.lua
function redcreate()
if(#score<5 or (#score==5 and score[5]<=5) ) return greencreate()
tmp = {
pos = { x = rnd(108)+10, y= rnd(100)+10},
update = redupdate,
draw = reddraw,
color = 8,
degres = 0,
die = emptyfunction,
rayon = 2,
score = 300,
phase = 1,
wp = nil,
timer = 0,
spots = {
{ degres= 0.5, rayon = 1},
{ degres= 0.15, rayon = 3},
{ degres= 0.35, rayon = 3},
{ degres= 0.65, rayon = 3},
{ degres= 0.85, rayon = 3}
}
}
return tmp
end

function redupdate(red)


if(red.phase == 1) then
red.timer += 1
red.degres = atan2(player.pos.x - red.pos.x, player.pos.y - red.pos.y)
red.pos.x += cos(red.degres)*0.5
red.pos.y += sin(red.degres)*0.5

if(red.timer == 60) then
red.phase = 2
red.timer = 0

end
end
if(red.phase == 2) then
red.timer += 1


red.wp = {pos={ x = red.pos.x + cos(red.degres)*60 , y = red.pos.y + sin(red.degres)*60}}

red.degres = atan2(player.pos.x - red.pos.x, player.pos.y - red.pos.y)
red.pos.x += cos(red.degres)*0.5
red.pos.y += sin(red.degres)*0.5

if(red.timer == 20) red.phase = 3
end
if(red.phase == 3) then

red.degres = atan2(red.wp.pos.x - red.pos.x, red.wp.pos.y - red.pos.y)
red.pos.x += cos(red.degres)*3
red.pos.y += sin(red.degres)*3

if(utilsdistance(red,red.wp) < 4 or ( red.pos.x < 4 or red.pos.x > 123 or red.pos.y < 4 or red.pos.y > 116)) then
red.phase = 1
end
end

utilsclamp(red)
end

function reddraw(red)
if(red.phase == 2 and elapsedtime%2==0) then
line(red.pos.x,red.pos.y,red.wp.pos.x, red.wp.pos.y,8)
end
shipdraw(red)
end
-- ./entities/particle.lua

-- ./entities/player.lua
function playerinit()

player = {
life = 3,
multiplier = 1,
pos={x=64,y=64},
degres = 0,
v = {x = 0, y=0},
speed = 0.1,
maxspeed = 2,
kills = 0,
color = 7,
bombcount = 0,
alive = true,
bomb = bombcreate(),
weapon = nil,
tag = "p",
timer = 0,
spots = {
{ degres= 0, rayon = 3},
{ degres= 0.4, rayon = 3},
{ degres= 0.6, rayon = 3},
}
}
playersetweapon(wdccreate())
end

function playersetweapon(wpn)
player.wpn = wpn
end

function playerupdate()
player.timer+=1

if(player.alive == true ) then
if(player.multiplier == 1 and player.kills > 25) then
player.multiplier = 2
soundsplay(sounds.bonusmultiplier)
createtextdecors("multplicateur x2", 50,120)
end
if(player.multiplier == 2 and player.kills > 50) then
player.multiplier = 3
soundsplay(sounds.bonusmultiplier)
createtextdecors("multplicateur x3", 50,120)
end
if(player.multiplier == 3 and player.kills > 500) then
player.multiplier = 10
soundsplay(sounds.bonusmultiplier)
createtextdecors("multplicateur x10", 50,120)
end

if(btn(0,1)) player.pos.x -= player.maxspeed
if(btn(1,1)) player.pos.x += player.maxspeed
if(btn(2,1)) player.pos.y -= player.maxspeed
if(btn(3,1)) player.pos.y += player.maxspeed

utilsclamp(player)

player.degres = atan2(mouse.pos.x - player.pos.x, mouse.pos.y - player.pos.y)


if(mouse.click == true ) then
weaponsfire(player.wpn)
end

if(mouse.rightclick == true) then
weaponsfire(player.bomb)
end
else
player.pos={x=64,y=64}
if(player.timer > 80 ) then
if(player.life == 0) screenschange(gameoverinit,gameoverupdate,gameoverdraw)
player.alive = true
player.timer = 0
currentwave =createrandomwave()
end
end
end


-- function playertail()
-- tmp = {
-- pos = { x = player.pos.x, y = player.pos.y },
-- c = player.color,
-- v = { x = -cos(player.degres), y = -sin(player.degres) },
-- l = 10
-- }
-- add(particles,tmp)
-- end

function playerdie()
if(player.alive == true) then
player.life -= 1



player.bombcount += 1
player.bomb.fire(player.bomb)
player.alive = false
player.multiplier = 1
player.timer = 0
player.kills = 0
end
end

function playerdraw()
if(player.alive == true and (player.timer > 30 or player.timer % 2 == 0 ) ) shipdraw(player)
end
__sfx__
001000000c043171001a4001a400246150c04300000000000c043000000000000000246150000000000000000c043000000000000000246150c04300000000000c0430000000000000002461500000000000c043
001100002266312660116600f6600c660086500b65008650096500d6500e6200d6200d6200e6100c6100b6000b6000a6000b6000b6000c6000000000000000000000000000000000000000000000000000000000
012000000d2250e7000d2250e7000d2250e7000d2250e700042250570004225057000422505700042250f1000e7000e7000d7000c7000c7000c700074000c700074000c7000c7000b7000b7000b7000b70000000
012000000d2251e6000d2250f6000d225106000d225146000b2250b6000b2250b0000b2250b0000b2250b00000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000c0000c025131000c0000c02513100000000c0250c0000c025131000c0000c02513100000000c0250c0000c025131000c0000c02513100000000c0250c0000c025131000c0000c02513100000000c025
001000001d050120001400015050160001005017000170001105015000140001a050110000f000160500c0000c0000f0500c000110500f000100000f050120001505015000150001005016000140001105010000
010a0000084400a4400c4300f42017410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000767005650073500933009300143000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000187531a7501c7501f750247502b7502530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000101a0101c0201d0201f0101e0101b0101a01019010190101901018010170101801019010170101901021500215002150021500235002450022500205002050021500225002350024500255002550024500
001000101a0301c0251902017020170351a0401e0451b030180551606015055170401a05019040180501905000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000201b0531a053100501b0531a0530f0501b0530c0511b0531a053100501b0531a0530f0501b0530c0511b0531a053100501b0531a0530f0501b0530c0511b0531a053100501b0531a0530f0501b0530c051
0010000000000000001c050000000000014050000000000013050000000000016050000001e050000000000015050000000000015050000000000019050000000000020050000000000016050000001705000000
011000003931320300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 00024344
03 00050444
03 00020c0b

