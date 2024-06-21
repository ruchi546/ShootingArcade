Vector = Vector or require "lib/vector"
local Actor = Actor or require "src/Actor"

local HorTarget = Actor:extend()

function HorTarget:new(_x, _y, _sprite, _speed, _size, score, fliped)
    self.image = love.graphics.newImage(_sprite)
    self.position = Vector.new(_x or 0, _y or 0)
    self.scale = Vector.new(1, 1)
    self.speed = _speed or 30
    self.rot = 0
    self.size = _size
    self.weight = _size
    self.height = _size
    self.origin = Vector.new(self.position.x - self.image:getWidth() / 2 * self.weight,
        self.position.y - self.image:getHeight() / 2 * self.height)
    self.score = score or 5
    self.fliped = fliped or false
end

function HorTarget:update(dt)
    self.origin.x = self.origin.x + self.speed * dt
    x, y = love.mouse.getPosition()
    isMousePress = love.mousepressed()

    local destroyedValue

    for index, value in ipairs(TableActorsTargets) do
        if value.origin.x < -100 then
            destroyedValue = index
        end
    end
    if destroyedValue ~= nil then
        table.remove(TableActorsTargets, destroyedValue)
    end

end

function HorTarget:draw()
    local scaleX = self.fliped and -self.size or self.size
    local originX = self.fliped and (self.origin.x + self.image:getWidth() * self.size) or self.origin.x
    love.graphics.draw(self.image, originX, self.origin.y, 0, scaleX, self.size)
end

function resetPositon(x, y)
    self.x = x
    self.y = y
end

return HorTarget
