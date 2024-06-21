local Actor = Actor or require("src/Actor")
local Target = Target or require("src/CanTarget")
local Weapon = Weapon or require("src/Weapon")
local Spawners = Spawners or require("src/CanSpawner")
local CanHud = CanHud or require("src/CanHUD")
local GunSight = GunSight or require("src/GunSight")
local SoundManager = SoundManager or require("src/SoundManager")

local CanHop = Actor:extend()

canHopActorList = {}

local gunSight
local weapon
local canHud
local canSounds
local spawner
local hitObjective = 0

function CanHop:new()
    canHud = CanHud(10, 550, "Score", 0, 5, "src/textures/CanHop/BackgroundBar.png")
    table.insert(canHopActorList, canHud)

    weapon = Weapon(("src/textures/Gun/GunPOV.png"), w / 2, 0, 15)
    table.insert(canHopActorList, weapon)

    gunSight = GunSight("src/textures/Gun/GunSight.png")
    table.insert(canHopActorList, gunSight)

    spawner = Spawners(1, 1.2)
    table.insert(canHopActorList, spawner)

    canSounds = SoundManager()
    canSounds:add("canHit", "src/audio/Sounds/MetalCanSound.wav")
    canSounds:add("gun", "src/audio/Sounds/GunSound.wav")
    canSounds:add("canMusic", "src/audio/Music/CanMusic.wav")
    canSounds:volume("canHit", 0.3)
    canSounds:volume("gun", 0.5)
    canSounds:volume("canMusic",0.5)
end

function CanHop:update(dt)
    for _, v in pairs(canHopActorList) do
        v:update(dt)
    end
    self:playMusic()
end

function CanHop:playMusic()
    if getGameState() == 2  then
        canSounds:play("canMusic")
    else
        canSounds:stop("canMusic")
    end
end

function CanHop:draw()
    for _, v in pairs(canHopActorList) do
        v:draw()
    end
end

function CanHop:reset()
    canHopActorList = {}
end

-- Shoot and delete according to times shot
function CanHop:mouse(x, y, button)
    if button == 1 then
        SoundManager:play("gun")
        for _, v in pairs(canHopActorList) do
            if v:is(Target) and x > v.x - v:getWidth() / 2 and x < v.x + v:getWidth() / 2 and y > v.y - v:getHeight() / 2 and y < v.y + v:getHeight() / 2 then
                hitObjective = hitObjective + 1
                
                v:displacement(true)

                v:timesHit(hitObjective)
                if v:remainingHealthCan() == 0 then
                    v:deleate()
                end
                hitObjective = 0
                canHud:addPoint(1)
            end
        end
    end
end

return CanHop
