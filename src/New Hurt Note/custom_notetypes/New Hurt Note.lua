--[[ Old code:
local redAlpha = 0

function onCreate()
    makeLuaSprite('redFlash', '', 0, 0)
    makeGraphic('redFlash', screenWidth, screenHeight, 'FF0000')
    setObjectCamera('redFlash', 'hud')
    setProperty('redFlash.alpha', 0)
    addLuaSprite('redFlash', true)

    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'New Hurt Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/New-HURTNOTE_assets')
            setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.texture', 'noteSplashes/New-HURTnoteSplashes')
            setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
            setPropertyFromGroup('unspawnNotes', i, 'hitHealth', 0)
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0)
            setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'New Hurt Note' then
        hurtBothSides(true)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'New Hurt Note' then
        hurtBothSides(false)
    end
end

function hurtBothSides(playerHit)
    if playerHit then
        setProperty('health', getProperty('health') - 0.1)
    else
        setProperty('health', getProperty('health') + 0.1)
    end

    triggerEvent('Screen Shake', '0.1,0.01', '0.1,0.01')

    redAlpha = 0.5
    setProperty('redFlash.alpha', redAlpha)
end

function onUpdate(elapsed)
    if redAlpha > 0 then
        redAlpha = redAlpha - (elapsed * 1.5)
        if redAlpha < 0 then redAlpha = 0 end
        setProperty('redFlash.alpha', redAlpha)
    end
end
]]
local redAlpha = 0

function onCreate()
    -- Create red flash overlay
    makeLuaSprite('redFlash', '', 0, 0)
    makeGraphic('redFlash', screenWidth, screenHeight, 'FF0000')
    setObjectCamera('redFlash', 'hud')
    setProperty('redFlash.alpha', 0)
    addLuaSprite('redFlash', true)
    
    -- Preload the splash image (use default hurt splash)
    precacheImage('HURTNOTE_splash')
end

function onCreatePost()
    -- Set up hurt note properties for all unspawned notes
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'New Hurt Note' then
            -- Make it look like a hurt note
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/New-HURTNOTE_assets')
            setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.texture', 'noteSplashes/New-HURTnoteSplashes')
            
            -- Critical: Make note unpressable like original hurt note
            setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
            setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
            setPropertyFromGroup('unspawnNotes', i, 'hitHealth', 0)
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0)
            
            -- Visual properties to match hurt note
            setPropertyFromGroup('unspawnNotes', i, 'color', getColorFromHex('FF0000'))
            setPropertyFromGroup('unspawnNotes', i, 'alpha', 0.9)
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'New Hurt Note' then
        triggerHurtEffects(true)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'New Hurt Note' then
        setProperty('health', getProperty('health') + 0.1)
        triggerHurtEffects(false)
    end
end

function triggerHurtEffects(playerHurt)
    if playerHurt then
        setProperty('health', getProperty('health') - 0.1)
    end
    
    -- Screen shake
    triggerEvent('Screen Shake', '0.2, 0.02', '0.2, 0.02')
    
    -- Red flash effect
    redAlpha = 0.8
    setProperty('redFlash.alpha', redAlpha)
end

function onUpdate(elapsed)
    -- Handle red flash fadeout
    if redAlpha > 0 then
        redAlpha = redAlpha - (elapsed * 2)
        if redAlpha < 0 then redAlpha = 0 end
        setProperty('redFlash.alpha', redAlpha)
    end
end
