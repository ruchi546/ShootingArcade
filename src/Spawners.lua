local Object = Object or require("lib/classic")
local HorizontalTargets = HorizontalTargets or require("src/HorizontalTargets")
local Actor = Actor or require "src/Actor"

local Spawners = Actor:extend()

function Spawners:new(x, y, frequencyMin, frequencyMax, sprite)
    self.x = x or 30
    self.y = y or 0
    self.sprite = sprite
    self.frequencyMin = frequencyMin or 2
    self.frequencyMax = frequencyMax or 5
    self.tFinal = randomNumber(self.frequencyMin, self.frequencyMax) or 3
    self.tActual = 0  
end

function Spawners:update(dt)
    self.tActual = self.tActual + dt
    self.number = randomNumber(1, 3)

    if self.tActual > self.tFinal then
       
        if self.number == 1 then
            local aux1, aux2, aux3 = randomSpeed()
            local obj = HorizontalTargets(self.x - aux2, self.y, self.sprite[1],aux1, 0.4, 5, aux3)
            table.insert(TableActorsTargets, obj)
        elseif self.number == 2 then
            local aux1, aux2, aux3 = randomSpeed()
            local obj = HorizontalTargets(self.x- aux2, self.y, self.sprite[2], aux1, 0.4, -5, aux3)
            table.insert(TableActorsTargets, obj)
        end

        self.tActual = 0
        self.tFinal = randomNumber(self.frequencyMin, self.frequencyMax)
    end
end

function Spawners:draw()
end

function randomNumber(num1, num2)
    return love.math.random(num1, num2)
end

function randomSpeed()
    if love.math.random(1,2) == 1 then
        return -250, 0, false
    else
        return 250, 800, true
    end 
end

return Spawners