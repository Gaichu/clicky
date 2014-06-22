-- circles.lua

local rectangles,lg = {},love.graphics

local timer, timerSpeed, timerStart = 20,1,{}
local vx,vy,width,height = 0,250,32,32
local tStart = { }
local t,max = "t",2
for i=1,2 do
   tStart[#tStart+1] = t .. tostring(i)
end
for i=1,#tStart do tStart[i] = 0 end -- set all timers for the rectangles to 0

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
local const_t1, const_t2 = 5,8
function genRectangles(dt)
  tStart[1], tStart[2] = tStart[1] + timerSpeed*dt, tStart[2] + timerSpeed*dt
  if tStart[1] >= timer/const_t1 then 
    rectangles_setPos(math.random(0,lg.getWidth()-width),0)
    tStart[1] = 0
  elseif tStart[2] >= timer/const_t2 then 
      rectangles_setPos(math.random(0,lg.getWidth()-width),0)
      tStart[2] = 0
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
local printConst = 3 -- manipulate printConst to print text in str table
function clickOnRectangle_mousepressed(x,y,button) 
  if button == 'l' then 
    for i,v in ipairs(rectangles) do
      if x >= v.x and
        x <= v.x + width
        and
        y >= v.y and
        y <= v.y+height 
        then
        -- rm rectangles when clicked, inc score and print string
        table.remove(rectangles,i) 
        score = score + 1
        for i=1,#str do
          if score == printConst*i then printStr() end 
        end
      end
    end
  end
end
function printStr()
 for i=1,#str do
    if score == printConst*i then lg.print(str[i],50,50) end
 end
end
function printScore() lg.print("SCORE " .. score, 10, lg.getHeight()-17.5) end
function stringTimer(dt)
  strTimerStart = strTimerStart + dt
end

local floor = math.floor
function printTimePlay()
  lg.print("You just wasted " .. floor(strTimerStart) .. " seconds of your life", 12, 12.5) 
end
