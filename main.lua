-- Import required modules
local Object = require ("lib/classic")
local MainMenu = require("src/MainMenu")
local DuckHunt = require("src/DuckHunt")
local CanHop = require("src/CanHop")
local TheKiller = require("src/TheKiller")
local WackAMole = require("src/WhacAMole")
local Scores = require("src/Scores")

-- Define global variables
local gameState = 0
local mainMenu, duckHunt, canHop, theKiller, wackAMole, scores
local font01, font02

-- Initialize the game
function love.load()
    mainMenu = MainMenu()
    duckHunt = DuckHunt()
    canHop = CanHop()
    theKiller = TheKiller()
    wackAMole = WackAMole()
    scores = Scores()

    font01 = love.graphics.newFont("src/fonts/m29.TTF", 30)
    font02 = love.graphics.newFont("src/fonts/Alphakind.ttf", 30)
end

-- Update the game state
function love.update(dt)
    if gameState == 0 then
        mainMenu:update(dt)
        love.mouse.setVisible(true) 
    elseif gameState == 1 then
        duckHunt:update(dt)
        love.graphics.setFont(font01)
        love.mouse.setVisible(false)
    elseif gameState == 2 then
        canHop:update(dt)
        love.graphics.setFont(font02)
        love.mouse.setVisible(false)
    elseif gameState == 3 then
        theKiller:update(dt)
        love.graphics.setFont(font02)
        love.mouse.setVisible(false)
    elseif gameState == 4 then
        wackAMole:update(dt)
        love.graphics.setFont(font01)
        love.mouse.setVisible(false)
    elseif gameState == 5 then
        love.graphics.setFont(font02)
        scores:update(dt)
        love.mouse.setVisible(true)
    end
end

-- Render the current game state
function love.draw()
    if gameState == 0 then
        mainMenu:draw()
    elseif gameState == 1 then
        duckHunt:draw()
    elseif gameState == 2 then
        canHop:draw()
    elseif gameState == 3 then
        theKiller:draw()
    elseif gameState == 4 then
        wackAMole:draw()
    elseif gameState == 5 then
        scores:draw()
    end
end

-- Get the current game state
function getGameState()
    return gameState
end

-- Set a new game state
function setGameState(newGameState)
    gameState = newGameState
end

-- Handle mouse input
function love.mousepressed(x, y, button, istouch)
    if gameState == 0 then
        mainMenu:mouse(x, y, button, istouch)
    elseif gameState == 1 then
        duckHunt:mouse(x, y, button, istouch)
    elseif gameState == 2 then
        canHop:mouse(x, y, button, istouch)
    elseif gameState == 3 then
        theKiller:mouse(x, y, button, istouch)
    elseif gameState == 4 then
        wackAMole:mouse(x, y, button, istouch)
    elseif gameState == 5 then
        scores:mouse(x, y, button, istouch)
    end
end

-- Handle keyboard input
function love.keypressed(key)
    theKiller:keypressed(key)
end