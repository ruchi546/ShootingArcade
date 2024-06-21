local Object = Object or require("lib/classic")
local Vector = Vector or require("lib/vector")

local Button = Object:extend()

function Button:new(_x, _y, _w, _h, _returnInput, _pathNormal, _pathHover, _pathPress)
    self.imageNormal = love.graphics.newImage(_pathNormal)              --Normal
    self.imageHover = love.graphics.newImage(_pathHover) or _pathNormal --Hover
    self.imagePress = love.graphics.newImage(_pathPress) or _pathNormal --Press
    self.returnInput = _returnInput
    self.position = Vector.new(_x or 0, _y or 0)
    self.weight = _w or 1
    self.height = _h or 1
    self.IsHover = false
    self.IsPressed = false
    self.origin = Vector.new(self.position.x - self.imageNormal:getWidth() / 2 * self.weight,self.position.y - self.imageNormal:getHeight() / 2 * self.height)

end

function Button:update(dt)
    x, y = love.mouse.getPosition()
    isMousePress = love.mousepressed()
    
    if self.origin.x < x and self.origin.x + self.imageNormal:getWidth() * self.weight > x and self.origin.y < y and self.origin.y + self.imageNormal:getHeight() * self.height > y then
        self.IsHover = true
    else
        self.IsHover = false
    end
end

function Button:draw()
    if self.IsHover == false then
        love.graphics.draw(self.imageNormal, self.origin.x, self.origin.y, 0, self.weight, self.height)
    elseif self.IsHover and self.IsPressed then
        love.graphics.draw(self.imagePress, self.origin.x, self.origin.y, 0, self.weight, self.height)
    else
        love.graphics.draw(self.imageHover, self.origin.x, self.origin.y, 0, self.weight, self.height)
    end
end

function Button:checkButtonClick(_x, _y)
    if self.origin.x < _x and self.origin.x + self.imageNormal:getWidth() * self.weight > _x and self.origin.y < _y and self.origin.y + self.imageNormal:getHeight() * self.height > _y then
        self.IsPressed = true
        return self.returnInput
    end
end


return Button