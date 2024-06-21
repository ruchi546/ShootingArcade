local Object = Object or require("lib/classic")
local Actor = Actor or require("src/Actor")
local GunSight = Actor:extend()

local mouseX, mouseY = 0,0

function GunSight:new(sprite,scale)
    GunSight.super.new(self,sprite)
    self.sprite = love.graphics.newImage(sprite or "src/textures/Gun/GunSight.png")
    self.x = 0
    self.y = 0
    self.scale = scale or 0.5
end

function GunSight:update(dt)
    GunSight.super.update(self,dt)
    self:move(dt)
end

function GunSight:move(dt)
    mouseX, mouseY = love.mouse.getPosition()
    self.position = Vector.new(mouseX , mouseY)
end

function GunSight:draw()
    love.graphics.draw(self.sprite, mouseX, mouseY, 0, self.scale, self.scale, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
end

return GunSight