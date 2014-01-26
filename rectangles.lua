-- circles.lua

local rectangles,lg = {},love.graphics

local timer, timerSpeed, timerStart = 20,1,{}
local vx,vy,width,height,maxRectangles = 0,250,32,32,5
for i=1,maxRectangles do timerStart[#timerStart+1] = 0 end -- 5 circles 5 starting points..
local score = 0

local str, strTimer, strTimerStart = {
  [[ nothing's going to happen ]],
  [[ no really.. ]],
  [[ are you serious?]],
  [[ Why? ]],
  [[ I warned you! ]],
  [[ *breaks out in laughter*]],
  [[ Okay, count me out of it ]]
}, 7.5,0

function rectangles_setPos(x,y)
  table.insert(rectangles, { x=x, y=y }) 
end
function genRectangles(dt)
  for i=1,maxRectangles do 
    timerStart[i] = timerStart[i] + timerSpeed*dt
    -- gen them at "random" time
    if timerStart[i] >= timer/i then
      rectangles_setPos(math.random(0,lg.getWidth()-width), 0)
      timerStart[i] = 0
    end
  end
end
function moveRectangles(dt)
  for i,v in ipairs(rectangles) do v.y = v.y + (vy*dt) end
end
function removeRectangles(dt)
  for i,v in ipairs(rectangles) do
    if v.y > lg.getHeight() then table.remove(rectangles, i) end
  end
end
function drawRectangles()
  for i,v in ipairs(rectangles) do lg.rectangle('fill', v.x,v.y,width,height) end
end
local printConst = 1 -- manipulate printConst to print text in str table
function clickOnRectangle_mousepressed(x,y,button) 
  if button == 'l' then 
    for i,v in ipairs(rectangles) do
      if x >= v.x and
        x <= v.x + width
        and
        y >= v.y and
        y <= v.y+height 
        then
        score = score + 1
        for i=2,#str do
          if score == printConst*i then printStr() end 
        end
      end
    end
  end
end
function printStr()
 for i=2,#str do
    if score == printConst*i then lg.print(str[i],50,50) end
 end
end
function printScore() lg.print("SCORE " .. score, 10, lg.getHeight()-17.5) end
function stringTimer(dt)
  strTimerStart = strTimerStart + dt
end
function printTimePlay()
  lg.print("You just wasted " .. math.floor(strTimerStart) .. " seconds of your life", 12, 12.5) 
end
