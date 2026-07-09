-- Original by RamenDominoes (Please credit if using this, thanks! <3)
-- Repaired/Recreated by SuperHero2010

local upperBar
local lowerBar
local initialYUpperBar
local initialYLowerBar
local initialYStrum
local shouldMoveStrum = true

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

function onCountdownStarted()
    if initialYStrum == nil or initialYStrum == 0 then
        initialYStrum = getPropertyFromGroup("strumLineNotes", 0, "y")
    end
end

function onEvent(eventName, value1, value2)
    if eventName == "Cinematics (UnderLap)" then
        local speed = tonumber(value1)
        local distance = tonumber(value2)

        -- ENTRANCES (distance > 0)
        if distance > 0 then
            doTweenY("upperBarTween", "upperBar", initialYUpperBar + distance, speed, "quadInOut")
            doTweenY("lowerBarTween", "lowerBar", initialYLowerBar - distance, speed, "quadInOut")

            if shouldMoveStrum then
                for i = 0, 7 do
                    local targetY = initialYStrum + distance - 35
                    noteTweenY("strumTween" .. i, i, targetY, speed, "quadInOut")
                end
            end

            -- Fade HUD assets
            local fadeSpeed = speed - 0.1
            if fadeSpeed < 0.1 then fadeSpeed = 0.1 end

            -- Try to fade common HUD elements
            local hudElements = {"scoreTxt", "healthBar", "healthBarBG", "iconP1", "iconP2", "timeBar", "timeBarBG", "timeTxt"}
            for _, elem in ipairs(hudElements) do
                local success, err = pcall(function()
                    doTweenAlpha(elem .. "Fade", elem, 0, fadeSpeed, "linear")
                end)
            end
        end

        -- EXITS (distance <= 0)
        if distance <= 0 then
            doTweenY("upperBarTween", "upperBar", initialYUpperBar, speed, "sineInOut")
            doTweenY("lowerBarTween", "lowerBar", initialYLowerBar, speed, "sineInOut")

            if shouldMoveStrum then
                for i = 0, 7 do
                    noteTweenY("strumTween" .. i, i, initialYStrum, speed, "sineInOut")
                end
            end

            -- Fade HUD assets back in
            local fadeSpeed = speed + 0.1

            local hudElements = {"scoreTxt", "healthBar", "healthBarBG", "iconP1", "iconP2", "timeBar", "timeBarBG", "timeTxt"}
            for _, elem in ipairs(hudElements) do
                local success, err = pcall(function()
                    doTweenAlpha(elem .. "Fade", elem, 1, fadeSpeed, "linear")
                end)
            end
        end
    end
end