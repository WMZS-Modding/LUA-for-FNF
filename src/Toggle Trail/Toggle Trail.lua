-- Original Script by Shadow Mario
trailEnabledDad = false
trailEnabledBF = false
timerStartedDad = false
timerStartedBF = false
luaDebugMode = true

trailLength = 36
trailDelay = 0.005

activeNoteHitsBF = 0
activeNoteHitsDad = 0
noteTimerBF = 0
noteTimerDad = 0

function onSongStart()
    trailEnabledBF = false
    trailEnabledDad = false
    timerStartedBF = false
    timerStartedDad = false
    activeNoteHitsBF = 0
    activeNoteHitsDad = 0
    curTrailBF = 0
    curTrailDad = 0

    if timerStartedBF then
        cancelTimer('timerTrailBF')
        timerStartedBF = false
    end
    if timerStartedDad then
        cancelTimer('timerTrailDad')
        timerStartedDad = false
    end
end

function onEvent(name, value1, value2)
    if name == "Toggle Trail" then
        if value1 == '1' then
            if not timerStartedDad then
                runTimer('timerTrailDad', trailDelay, 0)
                timerStartedDad = true
            end
            trailEnabledDad = true
            curTrailDad = 0
        elseif value1 == '0' or value1 == '' or value1 == nil then
            trailEnabledDad = false
            activeNoteHitsDad = 0
            if timerStartedDad then
                cancelTimer('timerTrailDad')
                timerStartedDad = false
            end
        end

        if value2 == '1' then
            if not timerStartedBF then
                runTimer('timerTrailBF', trailDelay, 0)
                timerStartedBF = true
            end
            trailEnabledBF = true
            curTrailBF = 0
        elseif value2 == '0' or value2 == '' or value2 == nil then
            trailEnabledBF = false
            activeNoteHitsBF = 0
            if timerStartedBF then
                cancelTimer('timerTrailBF')
                timerStartedBF = false
            end
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if trailEnabledBF then
        activeNoteHitsBF = activeNoteHitsBF + 1
        noteTimerBF = 0
        createTrailFrame('BF')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if trailEnabledDad then
        activeNoteHitsDad = activeNoteHitsDad + 1
        noteTimerDad = 0
        createTrailFrame('Dad')
    end
end

function onUpdate(elapsed)
    if trailEnabledBF and activeNoteHitsBF > 0 then
        noteTimerBF = noteTimerBF + elapsed
        if noteTimerBF > 0.5 then
            activeNoteHitsBF = 0
            noteTimerBF = 0
        end
    end

    if trailEnabledDad and activeNoteHitsDad > 0 then
        noteTimerDad = noteTimerDad + elapsed
        if noteTimerDad > 0.5 then
            activeNoteHitsDad = 0
            noteTimerDad = 0
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'timerTrailDad' then
        if trailEnabledDad or activeNoteHitsDad > 0 then
            createTrailFrame('Dad')
        end
    end

    if tag == 'timerTrailBF' then
        if trailEnabledBF or activeNoteHitsBF > 0 then
            createTrailFrame('BF')
        end
    end
end

curTrailDad = 0
curTrailBF = 0

function createTrailFrame(tag)
    num = 0
    image = ''
    frame = ''
    x = 0
    y = 0
    scaleX = 0
    scaleY = 0
    angle = 0
    offsetX = 0
    offsetY = 0
    flipX = false

    if tag == 'BF' then
        num = curTrailBF
        curTrailBF = curTrailBF + 1

        if trailEnabledBF then
            image = getProperty('boyfriend.imageFile')
            frame = getProperty('boyfriend.animation.frameName')
            angle = getProperty('boyfriend.angle')
            x = getProperty('boyfriend.x')
            y = getProperty('boyfriend.y')
            scaleX = getProperty('boyfriend.scale.x') 
            scaleY = getProperty('boyfriend.scale.y') 
            offsetX = getProperty('boyfriend.offset.x')
            offsetY = getProperty('boyfriend.offset.y')
            flipX = getProperty('boyfriend.flipX')
        end
    else
        num = curTrailDad
        curTrailDad = curTrailDad + 1

        if trailEnabledDad then
            image = getProperty('dad.imageFile')
            frame = getProperty('dad.animation.frameName')
            angle = getProperty('dad.angle')
            x = getProperty('dad.x')
            y = getProperty('dad.y')
            scaleX = getProperty('dad.scale.x')
            scaleY = getProperty('dad.scale.y')
            offsetX = getProperty('dad.offset.x')
            offsetY = getProperty('dad.offset.y')
            flipX = getProperty('dad.flipX')
        end
    end

    if num - trailLength + 1 >= 0 then
        for i = (num - trailLength + 1), (num - 1) do
            setProperty('psychicTrail'..tag..i..'.alpha', getProperty('psychicTrail'..tag..i..'.alpha') - (0.3 / (trailLength - 1)))
        end
    end
    removeLuaSprite('psychicTrail'..tag..(num - trailLength))

    if not (image == '') then
        trailTag = 'psychicTrail'..tag..num
        makeAnimatedLuaSprite(trailTag, image, x, y)
        setProperty(trailTag..'.angle', angle)
        setProperty(trailTag..'.offset.x', offsetX)
        setProperty(trailTag..'.offset.y', offsetY)
        setProperty(trailTag..'.scale.x', scaleX)
        setProperty(trailTag..'.scale.y', scaleY)
        setProperty(trailTag..'.flipX', flipX)
        setProperty(trailTag..'.alpha', 0.2)

        addAnimationByPrefix(trailTag, 'stuff', frame, 0, false)
        addLuaSprite(trailTag, false)
    end
end
