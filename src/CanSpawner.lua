local Actor = Actor or require "src/Actor"
local CanTarget = CanTarget or require("src/CanTarget")

local CanSpawner = Actor:extend()

math.randomseed(os.time())

function CanSpawner:new(number, timer, x, y, speed, sprite)
    self.number = number or 1
    self.zero =  0
    self.timer =  timer or 5

    w, h = love.graphics.getDimensions()
    self.x = x or 0
    self.y = y or 0
    self.speed = speed or 0
    self.sprite = sprite or "src/textures/CanHop/SodaCan.png"
end

function CanSpawner:update(dt)
    self.zero =  self.zero + dt 
    if self.zero > self.timer then
        self:random()
        self:spawn()
    end
end

function CanSpawner:random()
    self.y = math.random(50, h-100) 
    self.speed = math.random(100,200)
end

function CanSpawner:spawn()
    self.zero = 0
    local t = CanTarget(self.x, self.y, self.speed)
    table.insert(canHopActorList, t)
end

function CanSpawner:draw()
end

return CanSpawner