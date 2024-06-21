local Actor = Actor or require("src/Actor")
local Score = Score or require("src/Scores")

local CanHud = Actor:extend()
local remainingLives
local score

function CanHud:new(x, y, text, points, health, background)
    CanHud.super.new(self)
    self.x = x or 0
    self.y = y or 0
    self.text = text or "0"
    score = points or 0
    remainingLives = health or 5
    self.background = love.graphics.newImage(background or "src/textures/BackgroundBar.png")
end

function CanHud:update(dt)
    CanHud.super.update(self, dt)
end

function CanHud:addPoint(point, reset)
    score = score + point

    if reset then
        score = 0
    end
end

function CanHud:substractLife()
    remainingLives = remainingLives - 1
    if (remainingLives == 0) then
        self:endGame()
    end
end

function CanHud:endGame()
    remainingLives = 5
    Score:addScore("CanHop", score)
    score = 0

    setGameState(0)
end

function CanHud:draw()
    CanHud.super.draw(self)

    --print the background
    love.graphics.draw(self.background)
    
    --print the score
    love.graphics.print(self.text, self.x, self.y)
    love.graphics.print(score, self.x + 170, self.y)
    love.graphics.print("vida", self.x + 220, self.y)
    love.graphics.print(remainingLives, self.x + 350, self.y)
end

return CanHud
