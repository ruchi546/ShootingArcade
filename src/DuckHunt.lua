local Object = Object or require("lib/classic")
local Actor = Actor or require("src/Actor")
local Weapon = Weapon or require("src/Weapon")
local GunSight = GunSight or require("src/GunSight")
local SoundManager = SoundManager or require("src/SoundManager")
local DuckHunTarget = DuckHunTarget or require("src/DuckHuntTarget")
local DuckHuntHUD = DuckHuntHUD or require("src/DuckWhacHUD")
local DuckHuntSpawner = DuckHuntSpawner or require("src/DuckHuntSpawner")

local DuckHunt = Actor:extend()

duckHuntActorList = {}
local background
local gunSight
local weapon
local duckSounds
local spawner

function DuckHunt:new()
    w, h = love.graphics.getDimensions()

    -- Set background
    background = love.graphics.newImage("src/textures/DuckShooting/BackgroundDuckShooting.png")

    -- Set duckHud
    duckHud = DuckHuntHUD(560,10, "Score", 0, 5, "DuckHunt")
    table.insert(duckHuntActorList, duckHud)

    -- Set weapon
    weapon = Weapon(("src/textures/Gun/GunPOV.png"), w/2, 0, 15)
    table.insert(duckHuntActorList, weapon)

    -- Set gunSight
    gunSight = GunSight("src/textures/Gun/GunSight.png")
    table.insert(duckHuntActorList, gunSight)

    -- Set spawner
    spawner = DuckHuntSpawner(1, 0.9)
    table.insert(duckHuntActorList, spawner)

    -- Set sounds
    duckSounds = SoundManager()
    duckSounds:add("duck", "src/audio/Sounds/QuackSound.wav")
    duckSounds:add("gun", "src/audio/Sounds/GunSound.wav")
    duckSounds:add("out", "src/audio/Sounds/OutSound.wav")
    duckSounds:add("duckMusic", "src/audio/Music/DuckMusic.mp3")
    duckSounds:volume("out", 0.5)
    duckSounds:volume("duck", 0.5)
    duckSounds:volume("gun", 0.5)
    duckSounds:volume("duckMusic", 0.25)
    duckSounds:loop("duckMusic")
end

function DuckHunt:update(dt)
    for _,v in pairs(duckHuntActorList) do
        v:update(dt)
    end

    self:playMusic()
end

function DuckHunt:playMusic()
    if getGameState() == 1  then
        duckSounds:play("duckMusic")
    else
        duckSounds:stop("duckMusic")
    end
end

function DuckHunt:draw() 
    love.graphics.draw(background)   
    for _,v in pairs(duckHuntActorList) do
        v:draw()
    end
end

function DuckHunt:mouse(x, y, button, istouch)
    if button == 1 then
        SoundManager:play("gun")
        --check collision with target
        for _,v in pairs(duckHuntActorList) do
            if (v:is(DuckHunTarget)) and x > v.x - v:getWidth()/2 and x < v.x + v:getWidth()/2 and y > v.y - v:getHeight()/2 and y < v.y + v:getHeight()/2 then
                if v.anim == true then
                    duckHud:addPoint(v:getPoints())
                elseif v.anim == false then
                    duckHud:addPoint(v:getPoints())
                end
                SoundManager:play("duck")
                v:deleate()
            end
        end
    end
end

return DuckHunt