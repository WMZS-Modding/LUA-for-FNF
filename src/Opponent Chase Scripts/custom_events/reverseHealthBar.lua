local flippedHealthBar = false

function onCreatePost()
    applyFlipState(flippedHealthBar)
end

function onUpdatePost()
    if flippedHealthBar then
        local healthBarX = getProperty('healthBar.x')
        local healthBarWidth = getProperty('healthBar.width')

        setProperty('iconP1.x', - 110 + getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26))
        setProperty('iconP2.x', 110 + getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2))
    end
end

function onEvent(name, value1, value2)
    if name == 'reverseHealthBar' then
        if value1 == 'true' then
            flippedHealthBar = true
        elseif value1 == 'false' then
            flippedHealthBar = false
        end

        applyFlipState(flippedHealthBar)
    end
end

function applyFlipState(isFlipped)
    if isFlipped then
        setProperty('healthBar.flipX', true)
        setProperty('iconP1.flipX', true)
        setProperty('iconP2.flipX', true)
    else
        setProperty('healthBar.flipX', false)
        setProperty('iconP1.flipX', false)
        setProperty('iconP2.flipX', false)
    end
end
