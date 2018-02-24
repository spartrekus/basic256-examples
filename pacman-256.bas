# http://basic256.blogspot.co.at/2015/02/pac-man.html

levels=1
fastgraphics
graphsize 600,600
clg
dim board$ (16,levels)
dim area$ (16,30)
dim monstersname$(4)
dim monsterx(4)
dim monstery(4)
dim monsterxspeed(4)
dim monsteryspeed(4)
board$ [0,0]= "HHHHHHHHHHHHHHHHHHHHHHH       "
board$ [1,0]= "H**********H**********H Score "
board$ [2,0]= "H@HHH*HHHH*H*HHHH*HHH@H       "
board$ [3,0]= "H*********************H       "
board$ [4,0]= "H*HHH*H*HHH HHH*H*HHH*H @ 5P  "
board$ [5,0]= "H*****H*********H*****H       "
board$ [6,0]= "HHHHH*H*HHHHHHH*H*HHHHH * 1p  "
board$ [7,0]= "HHHHH*H         H*HHHHH       "
board$ [8,0]= "HHHHH*H HHH HHH H*HHHHH       "
board$ [9,0]= "        H     H         Lifes "
board$ [10,0]="H*HHH*H HHHHHHH H*HHH*H       "
board$ [11,0]="H@HHH*H         H*HHH@H       "
board$ [12,0]="H*HHH*H*HHH*HHH*H*HHH*H       "
board$ [13,0]="H*HHH*H*HHH*HHH*H*HHH*H       "
board$ [14,0]="H*********************H       "
board$ [15,0]="HHHHHHHHHHHHHHHHHHHHHHH       "
font "courier" ,25,200

# To put the board in a 2D array easier to handle
for row = 0 to 15
for collum = 0 to 29
area$ [row,collum]= mid( board$ [row,0],collum+1,1)
next collum
next row

# Main loop
for life = 3 to 0 step- 1
# Drawing the board
color black
rect 0,0,600,405
for y = 0 to 15
for x = 0 to 29
if area$[y,x]= "H" then color white
if area$[y,x]= "*" then color Yellow
if area$[y,x]= "@" then color red
text x*20,y*25,area$[y,x]
next x
next y

if life = 0 then
color green
font "Aril" ,50,100
Text 50,50,"GAME OVER"
refresh
end
end if


# initial variables for packman
xspeed = 1
yspeed = 0
xpac = 220
ypac = 125
mouth=0
Score = 0
dead = false

# initial positions for monsters
monstersname$[0]="Blue"
monsterx[0]=190
monstery[0]=240
monsterxspeed[0]=1
monsteryspeed[0]=0
monstersname$[1]="Yellow"
monsterx[1]=210
monstery[1]=240
monsterxspeed[1]=1
monsteryspeed[1]=0
monstersname$[2]="Orange"
monsterx[2]=190
monstery[2]=240
monsterxspeed[2]=-1
monsteryspeed[2]=0
monstersname$[3]="Purple"
monsterx[3]=210
monstery[3]=240
monsterxspeed[3]=-1
monsteryspeed[3]=0


# Action loop
do 
gosub packman
gosub monsters
refresh
pause .01
if Score = 139 then
color green
font "Aril" ,50,100
Text 50,50,"You won"
refresh
end
end if
until dead = true
next life



monsters:
for n = 0 to 3

# Erases monster for next frame
color black
rect monsterx[n]-10,monstery[n]-10,21,21

# Changing monster direction 
if (monsterx[n]+10)%20 =0 and (monstery[n]+10)%25=0 then

xcell=int((monsterx[n])/20)
ycell=int(monstery[n]/25)
self$ = area$[ycell,xcell]
lef$ = area$[ycell,xcell-1]
righ$ = area$[ycell,xcell+1]
up$ = area$[ycell-1,xcell]
down$ = area$[ycell+1,xcell]

flag=false
# when the monster is going right
if monsterxspeed[n]=1 then
if up$<>"H" and int(rand*2)>0 and flag = false then
monsteryspeed[n]=-1
monsterxspeed[n]=0
flag=true
end if
if down$<>"H" and flag = false then
monsteryspeed[n]=1
monsterxspeed[n]=0
flag=true
end if
if righ$="H" and flag = false then
monsteryspeed[n]=0
monsterxspeed[n]=-1
flag=true
end if
if lef$= "*" then color Yellow
if lef$= "@" then color red
if lef$= "*" or lef$= "@" then text (xcell-1)*20,ycell*25,lef$
end if
# when the monster is going left
if monsterxspeed[n]=-1 then
if up$<>"H" and int(rand*2)>0 and flag = false then
monsteryspeed[n]=-1
monsterxspeed[n]=0
flag=true
end if
if down$<>"H" and flag = false then
monsteryspeed[n]=1
monsterxspeed[n]=0
flag=true
end if
if lef$="H" and flag = false then
monsteryspeed[n]=0
monsterxspeed[n]=1
flag=true
end if
if righ$= "*" then color Yellow
if righ$= "@" then color red
if righ$= "*" or righ$= "@" then text (xcell+1)*20,ycell*25,righ$
end if
# when the monster is going up
if monsteryspeed[n]=-1 then
if lef$<>"H" and int(rand*2)>0 and flag = false then
monsteryspeed[n]=0
monsterxspeed[n]=-1
flag = true
end if
if righ$<>"H" and flag = false then
monsteryspeed[n]=0
monsterxspeed[n]=1
flag = true
end if
if up$="H" and flag = false then
monsteryspeed[n]=1
monsterxspeed[n]=0
flag=true
end if
if down$= "*" then color Yellow
if down$= "@" then color red
if down$= "*" or down$= "@" then text xcell*20,(ycell+1)*25,down$
end if
# when the monster is going down
if monsteryspeed[n]=1 then
if lef$<>"H" and int(rand*2)>0 and flag = false then
monsteryspeed[n]=0
monsterxspeed[n]=-1
flag = true
end if
if righ$<>"H" and flag = false then
monsteryspeed[n]=0
monsterxspeed[n]=1
flag = true
end if
if down$="H" and flag = false then
monsteryspeed[n]=-1
monsterxspeed[n]=0
flag = true
end if
if up$= "*" then color Yellow
if up$= "@" then color red
if up$= "*" or up$= "@" then text xcell*20,(ycell-1)*25,up$
end if
end if


# Shift from left to right of the board 
IF monsterx[n] = 15 THEN monsterx[n] = 435
IF monsterx[n] = 440 THEN monsterx[n] = 15

monsterx[n]=monsterx[n]+monsterxspeed[n]
monstery[n]=monstery[n]+monsteryspeed[n]

# Drawing the monsters
if n = 0 then color Blue
if n = 1 then color Orange
if n = 2 then color Yellow
if n = 3 then color Purple
Circle monsterx[n],monstery[n],10
rect monsterx[n]-10,monstery[n],21,11
# Monsters eyes and mouth
color white
Circle monsterx[n]-3,monstery[n]-4,4
Circle monsterx[n]+3,monstery[n]-4,4
color black
Circle monsterx[n]-3+monsterxspeed[n]*2,monstery[n]+monsteryspeed[n]*2-4,2
Circle monsterx[n]+3+monsterxspeed[n]*2,monstery[n]-4+monsteryspeed[n]*2,2
rect monsterx[n]-4,monstery[n]+4,8,3

# Pac dies
if abs(monsterx[n] - (xpac+10))<2 and abs(monstery[n]-(ypac+15))<2 then 
dead = true
sound 1000,1000
end if
next n

return


packman:
# Erases pacman for next frame
color black
rect xpac,ypac,20,28

# Identifies the cells around pacman
if xpac/20 =int(xpac/20) and ypac/25=int(ypac/25)then
xcell=int((xpac)/20)
ycell=int(ypac/25)
self$ = area$[ycell,xcell]
lef$ = area$[ycell,xcell-1]
righ$ = area$[ycell,xcell+1]
up$ = area$[ycell-1,xcell]
down$ = area$[ycell+1,xcell]
# Key controls
z = key
if z = 16777235 and up$<>"H" then
yspeed = -1
xspeed = 0
end if
if z = 16777237 and down$<>"H" then
yspeed = 1
xspeed = 0
end if
if z = 16777234 and lef$<>"H" then 
xspeed = -1
yspeed = 0
end if
if z = 16777236 and righ$<>"H" then
xspeed = 1
yspeed = 0
end if
# to stop when crashing the wall
if up$="H" and yspeed=-1 then yspeed=0
if down$="H" and yspeed=1 then yspeed=0
if lef$="H" and xspeed=-1 then xspeed=0
if righ$="H" and xspeed=1 then xspeed=0
# adding points 
if self$="*" then 
area$[ycell,xcell]=" "
Score = Score+1
end if
if self$="@" then 
area$[ycell,xcell]=" "
Score = Score+5
end if
end if
# transportation left to right 
IF xpac = 10 THEN xpac = 435
IF xpac = 440 THEN xpac = 20
# changing position
xpac = xpac+xspeed
ypac = ypac+yspeed
# Drawing packman
color white
if xspeed = 1 then direc=1.57
if xspeed = -1 then direc=-1.57
if yspeed = 1 then direc= 3.14
if yspeed = -1 then direc= 0
if yspeed+xspeed<>0 then mouth=mouth+.2
pie xpac,ypac+5,20,20,direc+sin (mouth),6.28-2*sin (mouth)

# Writing scores and lifes
color black
rect 520,60,100,30
rect 520,260,100,30
color white
text 520,60,Score
text 520,260,life
return
