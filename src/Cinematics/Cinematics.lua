-- Original by RamenDominoes (Please credit if using this, thanks! <3)
-- Repaired/Recreated by SuperHero2010

local upperBar
local lowerBar
local initialYUpperBar
local initialYLowerBar

function onCreate()
    upperBar = makeLuaSprite("upperBar", nil, -110, -350)
    makeGraphic("upperBar", 1500, 350, "000000")
    setObjectCamera("upperBar", "hud")
    addLuaSprite("upperBar", true)

    lowerBar = makeLuaSprite("lowerBar", nil, -110, 720)
    makeGraphic("lowerBar", 1500, 350, "000000")
    setObjectCamera("lowerBar", "hud")
    addLuaSprite("lowerBar", true)

    initialYUpperBar = getProperty("upperBar.y")
    initialYLowerBar = getProperty("lowerBar.y")
end

function onEvent(eventName, value1, value2)
    if eventName == "Cinematics" then
        local speed = tonumber(value1)
        local distance = tonumber(value2)

        -- ENTRANCES
        if speed > 0 and distance > 0 then
            doTweenY("upperBarTween", "upperBar", initialYUpperBar + distance, speed, "quadInOut")
            doTweenY("lowerBarTween", "lowerBar", initialYLowerBar - distance, speed, "quadInOut")
        end

        if distance <= 0 then
            doTweenY("upperBarTween", "upperBar", initialYUpperBar, speed, "sineInOut")
            doTweenY("lowerBarTween", "lowerBar", initialYLowerBar, speed, "sineInOut")
        end
    end
end