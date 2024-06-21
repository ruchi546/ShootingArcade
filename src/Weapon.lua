Object = Object or require("lib/classic")
local Actor = Actor or require("src/Actor")

local Weapon = Actor:extend()

local mouseX, mouseY

function Weapon:new(sprite, x, y, speed)
    Weapon.super.new(self, sprite, x, y, speed)
    w,h = love.graphics.getDimensions()

    -- Position of the weapon
    self.sprite =  love.graphics.newImage(sprite or "src/textures/Gun/GunPOV.png")
    self.x = x or 0
    self.y = h - self.sprite:getHeight()/6 or 0
    self.speed = speed or 0
    self.offsetX = self.sprite:getHeight()/2
    self.offsetY = self.sprite:getWidth()/2
    self.rotation = 0
end

function Weapon:update(dt)
    Weapon.super.update(self,dt)
    
    mouseX, mouseY = love.mouse.getPosition()
    self:movement(dt)
end

function Weapon:movement(dt)
    if mouseY <= self.y then
        self.rotation = math.atan2((mouseY - self.y), (mouseX - self.x)) + math.pi/2
        self.x = self.x + (mouseX - self.x) *self.speed * dt
    end
end

function Weapon:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.rotation, 0.5, 0.5, self.offsetX, self.offsetY)
end

return Weapon