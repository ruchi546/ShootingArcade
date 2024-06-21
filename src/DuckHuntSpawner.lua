local Actor = Actor or require "src/Actor"
local DuckHunTarget = DuckHunTarget or require("src/DuckHuntTarget")

local DuckHuntSpawner = Actor:extend()

math.randomseed(os.time())
local number

function DuckHuntSpawner:new(number, timer, x, y, speed)
    self.number = number or 1
    self.zero =  0
    timerDuck =  timer or 5

    w, h = love.graphics.getDimensions()
    self.x = x or 0
    self.y = y or 0
    self.speed = speed or 0
end

function DuckHuntSpawner:update(dt)
    self.zero =  self.zero + dt 
    if self.zero > timerDuck then
        self:random()
        self:spawn()
    end

    if timerDuck > 0.2 then
        timerDuck = timerDuck - dt/100
    end
end

function DuckHuntSpawner:random()
    self.y = math.random(0, h-250) 
    self.speed = math.random(400,600)
    number = math.random(1,5)
end

function DuckHuntSpawner:spawn()
    self.zero = 0
    if number == 1 then
        local t1 = DuckHunTarget(self.x, self.y, self.speed, 1.25, "src/textures/DuckShooting/DuckFlyGold.png",true,5)
        table.insert(duckHuntActorList, t1)
    else 
        local t2 = DuckHunTarget(self.x, self.y, self.speed, 1.5, "src/textures/DuckShooting/DuckFly.png",true,1)
        table.insert(duckHuntActorList, t2)
    end
end

function DuckHuntSpawner:draw()
end

return DuckHuntSpawner