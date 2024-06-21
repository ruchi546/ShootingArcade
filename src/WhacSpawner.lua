local Actor = Actor or require "src/Actor"
local WhacTarget = WhacTarget or require "src/WhacTarget"
local WackSpawner = Actor:extend()

math.randomseed(os.time())

function WackSpawner:new(timer, x, y, speed)
    self.zero =  0
    timerWhac =  timer or 0.6 --global to reset in hud

    w, h = love.graphics.getDimensions()
    self.x = x or 0
    self.y = y or 0
    self.speed = speed or 0
end

function WackSpawner:update(dt)
    self.zero =  self.zero + dt 
    if self.zero > timerWhac then
        self:random()
        self:spawn()
    end

    -- Reduce the timer to increase the speed of the targets
    if timerWhac > 0.2 then
        timerWhac = timerWhac - dt/100
    end
end

function WackSpawner:random()
    self.x = math.random(0, w-190)
    self.y = math.random(0, h-190) 
end

function WackSpawner:spawn()
    self.zero = 0
    local random = math.random(0.1, 0.3) --time to be visible in position before hide
    local t1 = WhacTarget(self.x, self.y, 0.5, "src/textures/Whac/SpritesWhac.png", random)
    table.insert(whacAMoleActorList, t1)
end

function WackSpawner:draw()
end

return WackSpawner