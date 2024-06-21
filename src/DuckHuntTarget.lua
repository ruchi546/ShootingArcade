local Actor = Actor or require("src/Actor")
local SoundManager = SoundManager or require("src/SoundManager")
local Anim = Anim or require("lib/anim8")

local DuckHunTarget = Actor:extend()

math.randomseed(os.time())

function DuckHunTarget:new(x,y, speed, scale, sprite, anim, points)
    DuckHunTarget.super.new(self, sprite, x, y, speed)
    self.x = x or 0
    self.y = y or 0
    self.speed = speed or 100
    self.scale = scale or 0.1
    self.anim = anim or false
    self.points = points or 1
    self.sprite = love.graphics.newImage(sprite or "src/textures/duck.png")
    self.patterns = {self.loopPattern, self.zigzagPattern, self.diagonalPattern}
    self.currentPattern = math.random(1, #self.patterns)

    -- animation
    if self.anim then  
        self.grid = Anim.newGrid(64, 64, self.sprite:getWidth(), self.sprite:getHeight())
        self.animations = {}

        self.animations.fly = Anim.newAnimation(self.grid('1-2',1), 0.15)
    end
end

function DuckHunTarget:update(dt)
    DuckHunTarget.super.update(self,dt)

    self.patterns[self.currentPattern](self, dt)

    if self.anim then
        self.animations.fly:update(dt)
    end

    self:bounds()
end

function DuckHunTarget:loopPattern(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + math.sin(self.x / 100) * self.speed * dt
end

function DuckHunTarget:zigzagPattern(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + (math.cos(self.x / 25) * 250) * dt
end

function DuckHunTarget:diagonalPattern(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + (math.cos(self.x / 300) * 250) * dt
end

-- destroy the target if it goes out of bounds
function DuckHunTarget:bounds()
    if self.x < 0  then
        self:deleate()
    elseif  self.x > w then
        SoundManager:play("out")
        self:deleate()
        duckHud:removeLife()
    end
end

function DuckHunTarget:deleate()
    local deleateList = {}
    for k,v in pairs(duckHuntActorList) do
        if v == self then
            table.insert(deleateList, k)
        end
    end

    for k,v in pairs(deleateList) do
        table.remove(duckHuntActorList, v)
    end
end

function DuckHunTarget:getPoints()
    return self.points
end

function DuckHunTarget:draw()
   if self.anim then
    self.animations.fly:draw(self.sprite, self.x, self.y, 0, self.scale, self.scale, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
   else 
    love.graphics.draw(self.sprite, self.x, self.y, 0, self.scale, self.scale, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
   end
end

function DuckHunTarget:getWidth()
    return self.sprite:getWidth()*self.scale
end

function DuckHunTarget:getHeight()
    return self.sprite:getHeight()*self.scale
end

return DuckHunTarget