local Actor = Actor or require("src/Actor")
local Anim = Anim or require("lib/anim8")

local WhacTarget = Actor:extend()

math.randomseed(os.time())

function WhacTarget:new(x, y, scale, sprite, timer)

    self.x = x or 0
    self.y = y or 0
    self.scale = scale or 1
    self.sprite = love.graphics.newImage(sprite or "src/textures/Whac/SpritesWhac.png")
    self.spriteReverse = love.graphics.newImage("src/textures/Whac/SpritesWhacReverse.png")
    self.spriteWhac = love.graphics.newImage("src/textures/Whac/Whac.png")

    self.grid = Anim.newGrid(190, 150, self.sprite:getWidth(), self.sprite:getHeight())
    self.animations = {}
    self.animations.spawn = Anim.newAnimation(self.grid('1-6',1), 0.1)

    self.grid2 = Anim.newGrid(190, 150, self.spriteWhac:getWidth(), self.spriteWhac:getHeight())
    self.animations.stay = Anim.newAnimation(self.grid2('1-1',1), 1)

    self.grid3 = Anim.newGrid(190, 150, self.spriteReverse:getWidth(), self.spriteReverse:getHeight())
    self.animations.reverse = Anim.newAnimation(self.grid3('1-6',1), 0.05)

    self.zero = 0
    self.timer = timer or 1
    self.state = "spawn"

end

function WhacTarget:update(dt)
    -- Animations update
    if self.state == "spawn" then
        self.animations.spawn:update(dt)
        if self.animations.spawn.position >= 6 then
            self.state = "stay" 
        end
    elseif self.state == "stay" then
        self.animations.stay:update(dt)
        self.zero = self.zero + dt
        if self.zero >=  self.timer then
            self.state = "reverse" 
        end
    elseif self.state == "reverse" then
        self.animations.reverse:update(dt)
        if self.animations.reverse.position >= 6 then
            self:deleate()
            hud:removeLife()
        end
    end

end

function WhacTarget:deleate()
    local deleateList = {}
    for i,v in ipairs(whacAMoleActorList) do
        if v == self then
            table.insert(deleateList, i)
        end
    end

    for i,v in ipairs(deleateList) do
        table.remove(whacAMoleActorList, v)
    end
end

function WhacTarget:draw()
    if self.state == "spawn" then
        self.animations.spawn:draw(self.sprite, self.x, self.y, 0, self.scale, self.scale)
    elseif self.state == "stay" then
        self.animations.stay:draw(self.spriteWhac, self.x, self.y, 0, self.scale, self.scale)
    elseif self.state == "reverse" then
        self.animations.reverse:draw(self.spriteReverse, self.x, self.y, 0, self.scale, self.scale)
    end
end

return WhacTarget