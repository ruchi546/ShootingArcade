local Actor = Actor or require("src/Actor")
local CanHUD = CanHUD or require("src/CanHUD")

CanTarget = Actor:extend()

function CanTarget:new(x, y, speed, canHealth)
    CanTarget.super.new(self, sprite, x, y, speed)

    self.x = math.random(5, 750)
    self.y = 550
    self.speed = math.random(100, 350)
    self.sprite = love.graphics.newImage("src/textures/CanHop/SodaCan.png")
    self.scale = scale or 0.1
    self.gravity = 100
    self.vida = vida or 1
    self.canHealth = canHealth or 4
    self.rotationSpeed = math.random(-5, 5)
end

function CanTarget:update(dt)
    CanTarget.super.update(self, dt)

    self:bounds()
    self:movement(dt)
end

function CanTarget:displacement(on)
    hasTouched = on
end

function CanTarget:movement(dt)
    self.y = self.y - self.speed * dt
    self.speed = self.speed - self.gravity * dt

    self.rot = self.rot + self.rotationSpeed * dt

    if hasTouched then
        self.y = self.y - self.speed * dt
        CanTarget:displacement(false)
    end
end

function CanTarget:timesHit(timesHit)
    if timesHit == 1 then
        self.rot = self.speed / 5
    elseif timesHit == 2 then
        self.rot = self.speed / 2
    elseif timesHit == 3 then
        self.rot = self.speed
    end

    return timesHit
end

function CanTarget:remainingHealthCan()
    self.canHealth = self.canHealth - 1

    return self.canHealth
end

function CanTarget:bounds()
    if self.x < 0 or self.x > w or self.y > h then
        CanHUD:substractLife()
        self:deleate()
    end
end

function CanTarget:deleate()
    local deleateList = {}
    for i, v in ipairs(canHopActorList) do
        if v == self then
            table.insert(deleateList, i)
        end
    end

    for i, v in ipairs(deleateList) do
        table.remove(canHopActorList, v)
    end
end

function CanTarget:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.rot, self.scale, self.scale, self.sprite:getWidth() / 2,
        self.sprite:getHeight() / 2)
end

function CanTarget:getWidth()
    return self.sprite:getWidth() * self.scale
end

function CanTarget:getHeight()
    return self.sprite:getHeight() * self.scale
end

return CanTarget
