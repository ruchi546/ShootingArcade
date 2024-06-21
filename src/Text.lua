local Actor = Actor or require("src/Actor")

local Text = Actor:extend()

function Text:new(x, y, text, score, r,g,b)
    Text.super.new(self)
    self.x = x or 0
    self.y = y or 0
    self.text = text or "0"
    self.score = score or 0
    self.r = r or 255
    self.g = g or 255
    self.b = b or 255

end

function Text:update(dt)

end

function Text:addPoint(point)
    self.score = self.score + point
end

function Text:setPoint(point)
    self.score = point
end

function Text:resetPoints()
    self.score = 0
end

function Text:Return()
    return self.score
end

function Text:draw()

    love.graphics.setColor(self.r / 255, self.g / 255, self.b / 255)
    love.graphics.print(self.text, self.x, self.y)
    love.graphics.print(self.score, self.x + 170, self.y)
    
    love.graphics.setColor(1, 1, 1)
end

return Text
