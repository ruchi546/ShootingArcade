local Object = Object or require("lib/classic")

local SoundManager = Object:extend()

local sounds = {}

function SoundManager:new()
end

function SoundManager:add(soundName, path)
    sounds[soundName] = love.audio.newSource(path, "static")
end

function SoundManager:remove(soundName)
    sounds[soundName] = nil
end

function SoundManager:play(soundName)
    if sounds[soundName] then
        sounds[soundName]:play()
    end
end

function SoundManager:stop(soundName)
    if sounds[soundName] then
        sounds[soundName]:stop()
    end
end

function SoundManager:loop(soundName)
    if sounds[soundName] then
        sounds[soundName]:setLooping(true)
    end
end

function SoundManager:endLoop(soundName)
    if sounds[soundName] then
        sounds[soundName]:setLooping(false)
    end
end

function SoundManager:volume(soundName, volume)
    if sounds[soundName] then
        sounds[soundName]:setVolume(volume)
    end
end

function SoundManager:pitch(soundName, pitch)
    if sounds[soundName] then
        sounds[soundName]:setPitch(pitch)
    end
end

return SoundManager