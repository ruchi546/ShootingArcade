local Actor = Actor or require("src/Actor")
local HorizontalTargets = HorizontalTargets or require("src/HorizontalTargets")
local Text = Text or require("src/Text")
local Spawners = Spawners or require("src/Spawners")
local Sprite = Sprite or require("src/Sprite")
local GunSight = GunSight or require("src/GunSight")
local Button = Button or require("src/Button")
local Score = Score or require("src/Scores")
local SoundManager = SoundManager or require("src/SoundManager")

local TheKiller = Actor:extend()

TableActorsTargets = {}
local TableHUD = {}
TablaBulletHole = {}
local ScoreShootingArc = 0
local TableSpawner = {}

local TableMenu = {}
local TableGameOverMenu = {}

local GameState = "main"

local time = 0
local DefaulTime = 30

local Cooldown = 0.8
local CooldownTimer = 0
local canShoot = true

function TheKiller:new()

    self.Cooldown = Cooldown
    self.CooldownTimer = CooldownTimer
    self.canShoot = canShoot

    backgroundImgBack = Sprite("src/textures/TheKiller/BackgroundCircus.png", w / 2, h / 2)
    backgroundImgFront = Sprite("src/textures/TheKiller/BackgroundCircusFront.png", w / 2, h / 2)

    PlayerButton = Button(w / 2, h / 2 - 50, 1.3, 1.3, "play", "src/textures/Menus/PlayButtonNormal.png",
        "src/textures/Menus/PlayButtonHover.png", "src/textures/Menus/PlayButtonPressed.png")
    table.insert(TableMenu, PlayerButton)

    ReturnButton = Button(w / 2, h / 2 + 240, 0.6, 0.6, "return", "src/textures/Menus/ReturnButtonNormal.png",
        "src/textures/Menus/ReturnButtonHover.png", "src/textures/Menus/ReturnButtonPressed.png")
    table.insert(TableMenu, ReturnButton)

    --HUD
    local font = love.graphics.newFont("src/fonts/Alphakind.ttf", 30)
    love.graphics.setFont(font)

    ScoreText = Text(500, 550, "Score: ", 0, 252, 220, 165)
    table.insert(TableHUD, ScoreText)

    Timer = Text(w / 2 - 300, 550, "TIME: ", DefaulTime, 252, 220, 165)
    table.insert(TableHUD, Timer)

    sprites = { "src/textures/TheKiller/DuckTargetEnemy.png", "src/textures/TheKiller/DuckTargetInnocent.png"}

    Spawner1 = Spawners(w, h / 2 + 7, 2, 5, sprites)
    table.insert(TableSpawner, Spawner1)

    Spawner2 = Spawners(w, h / 5 + 13, 2, 5, sprites)
    table.insert(TableSpawner, Spawner2)

    Spawner3 = Spawners(w, h - h / 4 - 6, 2, 5, sprites)
    table.insert(TableSpawner, Spawner3)

    gunSight = GunSight("src/textures/Gun/GunSight.png")

    GameOverImg = Sprite("src/textures/Menus/GameOver.png", w / 2, h / 2 - 230)
    table.insert(TableGameOverMenu, GameOverImg)

    ScoreText1 = Text(w / 2 - 100, h / 2 - 140, "Your Score: ", Timer:Return())
    table.insert(TableGameOverMenu, ScoreText1)

    GameoverButton = Button(w / 2, h / 2 + 240, 0.6, 0.6, "play", "src/textures/Menus/NextButtonNormal.png",
        "src/textures/Menus/NextButtonHover.png", "src/textures/Menus/NextButtonPressed.png")
    table.insert(TableGameOverMenu, GameoverButton)

    theKillerMusic = SoundManager()
    theKillerMusic:add("music", "src/audio/Music/TheKillerMusic.mp3")
    theKillerMusic:add("shoot", "src/audio/Sounds/GunSound.wav")
    theKillerMusic:add("hit", "src/audio/Sounds/HitSound.ogg")
    theKillerMusic:volume("music", 0.25)
    theKillerMusic:volume("shoot", 0.5)
    theKillerMusic:volume("hit", 0.5)
    theKillerMusic:loop("music")
end

function TheKiller:update(dt)
    self:playMusic()

    if GameState == "play" then
        if Timer:Return() > 0 and GameState == "play" then
            for _, v in pairs(TableSpawner) do
                v:update(dt)
            end

            for _, v in pairs(TableActorsTargets) do
                v:update(dt)
            end

            for _, v in pairs(TablaBulletHole) do
                v:update(dt)
            end

            TimerUpdate(dt)
        else
            Score:addScore("Shooting", ScoreText.score)
            GameState = "gameOver"
            TableActorsTargets = {} -- No mas patos
            ScoreText1.score = ScoreText.score
            Timer:addPoint(DefaulTime)
        end
    end

    gunSight:update(dt)

    for _, v in ipairs(TableMenu) do
        v:update(dt)
    end

    if GameState == "return" then
        GameState = "main"
        setGameState(0)
    end

    if GameState == "gameOver" then
        for _, v in pairs(TableGameOverMenu) do
            v:update(dt)
        end
    end

    if canShoot == false then
        self.CooldownTimer = self.CooldownTimer + dt
        if self.CooldownTimer > self.Cooldown then
            canShoot = true
            self.CooldownTimer = 0
        end
    end
end

function TheKiller:draw()
    backgroundImgBack:draw()

    if GameState == "play" then
        for _, v in pairs(TablaBulletHole) do
            v:draw()
        end
        for _, v in pairs(TableActorsTargets) do
            v:draw()
        end
        backgroundImgFront:draw()

        for _, v in pairs(TableHUD) do
            v:draw()
        end
    end

    if GameState == "main" then
        backgroundImgFront:draw()
        for _, v in ipairs(TableMenu) do
            v:draw()
        end
    end

    if GameState == "gameOver" then
        for _, v in pairs(TableGameOverMenu) do
            v:draw()
        end
    end

    gunSight:draw()
end

function TheKiller:mouse(x, y, button, istouch)
    if button == 1 then
        if canShoot then
            canShoot = false
            Shoot()
        end
        if GameState == "main" or GameState == "gameOver" then
            for _, v in pairs(TableMenu) do
                local aux = v:checkButtonClick(x, y)
                if aux ~= nil then
                    GameState = aux
                end
            end
        end
    end
end

function Shoot()
    BulletHole = Sprite("src/textures/TheKiller/BulletHole.png", x, y, 1, 1, 0, true, 5)
    table.insert(TablaBulletHole, BulletHole)
    local destroyedValue
    theKillerMusic:play("shoot")

    for index, value in ipairs(TableActorsTargets) do
        if value.origin.x < x and value.origin.x + value.image:getWidth() * value.weight > x and value.origin.y < y and value.origin.y + value.image:getHeight() * value.height > y then
            ScoreShootingArc = ScoreShootingArc + value.score
            ScoreText:addPoint(value.score)
            theKillerMusic:play("hit")
            destroyedValue = index
        end
    end
    
    if destroyedValue ~= nil then
        table.remove(TableActorsTargets, destroyedValue)
    end
end

function TheKiller:keypressed(key)
    if key == "escape" and GameState == "play" then
        GameState = "main"
    end
end

function TheKiller:Reset()
    Timer:setPoint(DefaulTime)
    TableActorsTargets = {}
    TablaBulletHole = {}
    ScoreText:resetPoints()
end

function TimerUpdate(dt)
    time = time + dt
    if time > 1 then
        Timer:addPoint(-1)
        time = 0
    end
end

function TheKiller:playMusic()
    if GameState == "play" or GameState == "main" then
        theKillerMusic:play("music")
    else
        theKillerMusic:stop("music")
    end
end

return TheKiller
