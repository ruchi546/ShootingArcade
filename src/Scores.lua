local Actor = Actor or require("src/Actor")
local Button = Button or require("src/Button")

local Scores = Actor:extend()
local ReturnButton
local TableMenu = {}
local font1
local font2
local maxScores 
local scoreTable

function Scores:new()
    ReturnButton = Button(w / 2, h / 2 + 240, 0.6, 0.6, "return", "src/textures/Menus/ReturnButtonNormal.png",
        "src/textures/Menus/ReturnButtonHover.png", "src/textures/Menus/ReturnButtonPressed.png")
    table.insert(TableMenu, ReturnButton)
    font1 = love.graphics.newFont("src/fonts/Alphakind.ttf", 30)
    font2 = love.graphics.newFont("src/fonts/Alphakind.ttf", 50)
    maxScores = 6
    
    scoreTable = {DuckHunt = {}, CanHop = {}, Shooting = {}, WackAMole = {}}
end

function Scores:update(dt)
    Scores.super.update(self, dt)
    ReturnButton:update(dt)
end

function Scores:draw()
    Scores.super.draw(self)
        
    love.graphics.setFont(font2)
    love.graphics.print("SCORES", 300, 50)
    love.graphics.setFont(font1)

    self:drawScoreTable()

    ReturnButton:draw()
end

function Scores:drawScoreTable()
    local gameScores = {
        DuckHunt = scoreTable.DuckHunt,
        CanHop = scoreTable.CanHop,
        D_TheKiller = scoreTable.Shooting,
        WackAMole = scoreTable.WackAMole
    }

    local xPosition = 40
    local yPosition = 125
    local columnSeparation = 190
    local rowSeparation = 50

    for game, scores in pairs(gameScores) do
        love.graphics.print(game, xPosition, yPosition)

        table.sort(scores, function(a, b) return a > b end)

        if #scores > maxScores then
            table.remove(scores, #scores)
        end

        for i, score in ipairs(scores) do
            love.graphics.setColor(1, 1, 1)
            if i == 1 then
                love.graphics.setColor(0, 1, 0)
            end
            love.graphics.print(score, xPosition + 50, yPosition + i * rowSeparation)
        end

        love.graphics.setColor(1, 1, 1)
        xPosition = xPosition + columnSeparation
    end
end

function Scores:addScore(game, score)
    table.insert(scoreTable[game], score)
end

function Scores:mouse(x, y, button, istouch)
    if button == 1 then
        local aux = ReturnButton:checkButtonClick(x, y)

        if aux ~= nil then
            setGameState(0)
        end
    end
end

return Scores