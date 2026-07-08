local shake = 0
local pi = math.pi
local offset = 56
local isShake = false
local wasShake = false
local anchorpos = {}
local dadPos = {}
local bfPos = {}
local oppIntensity = 0
local playerIntensity = 0

function onCreatePost()
    makeLuaSprite('shakeAmt', '', 0, 0)
    setProperty('shakeAmt.visible', false)
    addLuaSprite('shakeAmt', false)

    for i = 0, getProperty('strumLineNotes.length') - 1 do
        xshake = getPropertyFromGroup('strumLineNotes', i, 'x')
        yshake = getPropertyFromGroup('strumLineNotes', i, 'y')
        table.insert(anchorpos, {xshake,yshake})
    end
    table.insert(dadPos, {getProperty('dad.x'), getProperty('dad.y')})
    table.insert(bfPos, {getProperty('boyfriend.x'), getProperty('boyfriend.y')})
end

function onEvent(name, value1, value2)
    if name == "shake-arrow" then
        -- value1: Opponent On/Off, Intensity
        -- value2: Player On/Off, Intensity

        -- Parse value1 (Opponent)
        oppIntensity = 0
        if value1 then
            local status, intensity = string.match(value1, "(%w+),%s*(%d+%.?%d*)")
            if status and intensity then
                if string.lower(status) == "on" then
                    oppIntensity = tonumber(intensity) or 0
                end
            else
                -- Fallback for simple numeric values
                oppIntensity = tonumber(value1) or 0
            end
        end

        -- Parse value2 (Player)
        playerIntensity = 0
        if value2 then
            local status, intensity = string.match(value2, "(%w+),%s*(%d+%.?%d*)")
            if status and intensity then
                if string.lower(status) == "on" then
                    playerIntensity = tonumber(intensity) or 0
                end
            else
                -- Fallback for simple numeric values
                playerIntensity = tonumber(value2) or 0
            end
        end

        if oppIntensity > 0 or playerIntensity > 0 then
            isShake = true
            setProperty('shakeAmt.x', 10) -- Base shake amount
        else
            isShake = false
            setProperty('shakeAmt.x', 0)
        end
    end
end

function onUpdate(elapsed)
    if isShake then
        shake = getProperty('shakeAmt.x')

        -- Apply shake to strum notes based on values
        for i = 0, getProperty('strumLineNotes.length')-1 do
            local isOpponent = i < 4
            local shouldShake = false
            local intensity = 1

            -- Value 1: Opponent On/Off, Intensity
            if isOpponent then
                if oppIntensity > 0 then
                    shouldShake = true
                    intensity = oppIntensity
                end
            -- Value 2: Player On/Off, Intensity  
            else
                if playerIntensity > 0 then
                    shouldShake = true
                    intensity = playerIntensity
                end
            end

            if shouldShake then
                setPropertyFromGroup('strumLineNotes', i, 'x', anchorpos[i+1][1] + math.random(-shake * 4 * intensity, shake * 4 * intensity))
                setPropertyFromGroup('strumLineNotes', i, 'y', anchorpos[i+1][2] + math.random(-shake * 4 * intensity, shake * 4 * intensity))
            end
        end
    elseif wasShake then
        -- Reset arrows only once when shake turns off
        for i = 0, getProperty('strumLineNotes.length')-1 do
            setPropertyFromGroup('strumLineNotes', i, 'x', anchorpos[i+1][1])
            setPropertyFromGroup('strumLineNotes', i, 'y', anchorpos[i+1][2])
        end
    end

    wasShake = isShake
end

function noteTween4(time)
    local rsp0 = time * pi
    local rsp1 = rsp0 / 4 + pi / 2
    local rsp2 = rsp0 / 8
    local rsp3 = rsp0 / 4

    for i = 0,7 do
        if i < 4 then
            setPropertyFromGroup("strumLineNotes", i, "x", screenWidth / 2 - offset + math.cos(rsp0 + pi * i * 0.5) * 250)
            setPropertyFromGroup("strumLineNotes", i, "y", screenHeight / 2 - offset + math.sin(rsp0 + pi * i * 0.5) * 250)
            setPropertyFromGroup("strumLineNotes", i, "direction", time * 180 + (downscroll and 180 or 0) + 90 * i)
        else
            setPropertyFromGroup("strumLineNotes", i, "x", screenWidth / 2 - offset + math.cos(-rsp0 + pi * i * 0.5) * 250)
            setPropertyFromGroup("strumLineNotes", i, "y", screenHeight / 2 - offset + math.sin(-rsp0 + pi * i * 0.5) * 250)
            setPropertyFromGroup("strumLineNotes", i, "direction", -time * 180 + (downscroll and 180 or 0) + 90 * i)
        end
    end
end
