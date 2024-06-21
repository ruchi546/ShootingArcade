local Object = Object or require("lib/classic")
local Sprite = Sprite or require("src/Sprite")
local Button = Button or require("src/Button")
local ShootingArcade = require("src/TheKiller")

local MainMenu = Object:extend()

local x, y
local GameBanner1
local GameBanner2
local GameBanner3
local ArrowL
local ArrowR
local TableButton = {}
local TableGameBanners = {}
local BannerState = 1 --1 ,2 ,3 ,...
local ButtonState = 0
local music

function MainMenu:new()
    w, h = love.graphics.getDimensions()
    love.mouse.setVisible(true)

    GameBanner1 = Sprite("src/textures/DuckShooting/DuckShootingBanner.png", w / 2, h / 2)
    table.insert(TableGameBanners, GameBanner1)
    GameBanner2 = Sprite("src/textures/CanHop/CanHopBanner.jpg", w / 2, h / 2)
    table.insert(TableGameBanners, GameBanner2)
    GameBanner3 = Sprite("src/textures/TheKiller/TheKillerBanner.jpg", w / 2, h / 2)
    table.insert(TableGameBanners, GameBanner3)
    GameBanner4 = Sprite("src/textures/Whac/WhacBanner.png", w / 2, h / 2)
    table.insert(TableGameBanners, GameBanner4)
    GameBanner5 = Sprite("src/textures/Scores/ScoresBanner.png", w / 2, h / 2)
    table.insert(TableGameBanners, GameBanner5)

    ArrowL = Button(50, h / 2, 0.12, 0.12, "Left", "src/textures/Menus/ArrowLeftNormal.png", "src/textures/Menus/ArrowLeftHover.png",
        "src/textures/Menus/ArrowLeftHover.png")
    table.insert(TableButton, ArrowL)
    ArrowR = Button(w - 50, h / 2, 0.12, 0.12, "Right", "src/textures/Menus/ArrowRightNormal.png", "src/textures/Menus/ArrowRightHover.png",
        "src/textures/Menus/ArrowRightHover.png")
    table.insert(TableButton, ArrowR)
    PlayButton = Button(w / 2, h - h / 10, 1, 1, "Play", "src/textures/Menus/PlayButtonNormal.png", "src/textures/Menus/PlayButtonHover.png",
        "src/textures/Menus/PlayButtonPressed.png")
    table.insert(TableButton, PlayButton)

    music = love.audio.newSource("src/audio/Music/MainMenuMusic.mp3", "stream")
end

function MainMenu:update(dt)
    TableGameBanners[BannerState]:update(dt)

    for _, v in pairs(TableButton) do
        v:update(dt)
    end
    x, y = love.mouse.getPosition()

    self:playMusic()
end

function MainMenu:playMusic()
    if getGameState() == 0  then
        music:play()
    else
        music:stop()
    end
end


function MainMenu:draw()
    TableGameBanners[BannerState]:draw()

    for _, v in pairs(TableButton) do
        v:draw()
    end
end

function MainMenu:mouse(x, y, button, istouch)
    if button == 1 then
        for _, v in pairs(TableButton) do
            Value = v:checkButtonClick(x, y)

            if Value ~= nill then
                if Value == "Left" then
                    if BannerState - 1 <= 0 then
                        BannerState = #TableGameBanners
                    else
                        BannerState = BannerState - 1
                    end
                elseif Value == "Right" then
                    if BannerState + 1 > #TableGameBanners then
                        BannerState = 1
                    else
                        BannerState = BannerState + 1
                    end
                end
                if Value == "Play" then
                    ButtonState = BannerState
                   if ButtonState == 3 then 
                    ShootingArcade:Reset()
                    end
                   
                    setGameState(ButtonState)
                    buttonState = 0
                    love.audio.stop(music)
                end
            end
        end
    end
end

return MainMenu
