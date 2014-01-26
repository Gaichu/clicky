-- main.lua

require 'rectangles' 

function love.load()

end
function love.draw()
  drawRectangles()
  printScore()
  printTimePlay()
  printStr()
end
function love.update(dt)
  genRectangles(dt)
  moveRectangles(dt)
  stringTimer(dt)
end
function love.mousepressed(x,y,button)
  clickOnRectangle_mousepressed(x,y,button)
end
