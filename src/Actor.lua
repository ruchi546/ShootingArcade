-- Base class for all actors in the game
Vector = Vector or require "lib/vector"

local Actor = Object:extend()

function Actor:new(x,y,speed)
    self.position = Vector.new(x or 0, y or 0)
    self.scale = Vector.new(1,1)
    self.speed = speed or 30
    self.rot = 0
end

function Actor:update(dt)

end

function Actor:draw()
end

return Actor