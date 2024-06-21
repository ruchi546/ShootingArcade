local Actor = Actor or require("src/Actor")
local Hammer = Hammer or require("src/GunSight")
local WhacTarget = WhacTarget or require("src/WhacTarget")
local WhacSpawner = WhacSpawner or require("src/WhacSpawner")
local WhacHUD = WhacHUD or require("src/DuckWhacHUD")
local SoundManager = SoundManager or require("src/SoundManager")

local WhacAMole = Actor:extend()

whacAMoleActorList = {}
local background

--actors
local hammer
local spawner
local whacSounds 

function WhacAMole:new()
    w, h = love.graphics.getDimensions()

    -- Set background
    background = love.graphics.newImage("src/textures/Whac/BackgroundWhac.png")

    -- Set hammer, not in actor list to print ovrer the targets that spawn (in the list)
    hammer = Hammer("src/textures/Whac/Hammer.png",0.05)

    -- Set spawner
    spawner = WhacSpawner()
    table.insert(whacAMoleActorList, spawner)

    -- Set hud
    hud = WhacHUD(560,10, "Score: ", 0, 5, "WhacAMole")
    table.insert(whacAMoleActorList, hud)

    -- Set sounds
    whacSounds = SoundManager()
    whacSounds:add("whac", "src/audio/Sounds/WhacSound.mp3")
    whacSounds:add("whackMusic", "src/audio/Music/WhacMusic.wav")
    whacSounds:volume("whac", 0.5)
    whacSounds:volume("whackMusic", 0.25)
    whacSounds:loop("whackMusic")
end

function WhacAMole:update(dt)
    for _,v in pairs(whacAMoleActorList) do
        v:update(dt)
    end
    hammer:update(dt)

    self:playMusic()
end

function WhacAMole:playMusic()
    if getGameState() == 4  then
        whacSounds:play("whackMusic")
    else
        whacSounds:stop("whackMusic")
    end
end

function WhacAMole:draw() 
    love.graphics.draw(background)   
    for _,v in pairs(whacAMoleActorList) do
        v:draw()
    end

    hammer:draw()
end

function WhacAMole:mouse(x, y, button, istouch)
    if button == 1 then
        for _,v in pairs(whacAMoleActorList) do
            if v:is(WhacTarget) and v.x < x and v.x + 190 - 50> x and v.y < y and v.y + 150 > y then
                v:deleate()
                whacSounds:play("whac")
                hud:addPoint(1)
            end

        end
    end
end

return WhacAMole