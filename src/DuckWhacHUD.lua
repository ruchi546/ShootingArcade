local Actor = Actor or require("src/Actor")
local Score = Score or require("src/Scores")

local DuckWhacHUD = Actor:extend()

function DuckWhacHUD:new(x,y, text, score, life, game)
    DuckWhacHUD.super.new(self)
    self.x =  x or 0
    self.y = y or 0
    self.text = text or "0"
    self.score = score or 0
    self.life = life or 5
    self.game = game or "DuckWhac"
end

function DuckWhacHUD:update(dt)
    DuckWhacHUD.super.update(self,dt)
    if self.life == 0 then
        self:endGame()
    end
end

function DuckWhacHUD:endGame()
    self:setLife(5)
    if self.game == "DuckHunt" then
        Score:addScore("DuckHunt", self.score)
        --reset the timer
        timerDuck = 0.9

    elseif self.game == "WhacAMole" then
        Score:addScore("WackAMole", self.score)
        timerWhac = 0.6
    end
    
    self:resetScore()
    setGameState(0)
end

function DuckWhacHUD:addPoint(point)
    self.score = self.score + point
end

function DuckWhacHUD:removePoints(point)
    if self.score - point <= 0 then
        self.score = 0
    elseif self.score - point > 0 then
        self.score = self.score - point
    end
end

function DuckWhacHUD:removeLife()
    if self.life - 1 <= 0 then
        self.life = 0
    elseif self.life - 1 > 0 then
        self.life = self.life - 1
    end
end

function DuckWhacHUD:getLife()
    return self.life
end

function DuckWhacHUD:setLife(life)
    self.life = life
end

function DuckWhacHUD:resetScore()
    self.score = 0
end 


function DuckWhacHUD:draw()
    DuckWhacHUD.super.draw(self)

    love.graphics.setColor(0/255, 0/255, 0/255)
    love.graphics.print(self.text, self.x, self.y)
    love.graphics.print(self.score, self.x + 170, self.y)

    love.graphics.print("Life", self.x, self.y + 50)
    love.graphics.print(self.life, self.x + 170, self.y + 50)

    love.graphics.setColor(1,1,1)
end

return DuckWhacHUD