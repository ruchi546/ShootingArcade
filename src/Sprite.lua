local Object = Object or require("lib/classic")
local Vector = Vector or require("lib/vector")

local Sprite = Object:extend()

function Sprite:new(_path, _x, _y, _w, _h, _rotation, selfdestroy, timer)
    self.image = love.graphics.newImage(_path)
    self.position = Vector.new(_x or 0, _y or 0)
    self.weight = _w or 1
    self.height = _h or 1
    self.rotation = _rotation or 0
    self.origin = Vector.new(self.position.x-self.image:getWidth()/2 * self.weight, self.position.y-self.image:getHeight()/2 * self.height)
    self.selfdestroy = selfdestroy or false
    self.tFinal = timer or 0
    self.tActual = 0

end

function Sprite:update(dt)
end

function Sprite:draw()
    love.graphics.draw(self.image, self.origin.x, self.origin.y, self.rotation, self.weight, self.height)
end

return Sprite
