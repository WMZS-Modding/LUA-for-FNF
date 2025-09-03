local flippedHealthBar = false -- Set to false to ensure it doesn't flip automatically

function onCreatePost()
    -- Ensure initial state of health bar and icons are applied based on flippedHealthBar value
    applyFlipState(flippedHealthBar)
end

function onUpdatePost()
    if flippedHealthBar then
        -- Dynamically adjust icon positions to match the flipped health bar
        local healthBarX = getProperty('healthBar.x')
        local healthBarWidth = getProperty('healthBar.width')
        local healthPercent = remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)

        -- Adjust player and opponent icons' positions dynamically
        setProperty('iconP1.x', -593+getProperty('healthBar.x') + (getProperty('healthBar.width')*(remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)*0.01))-(150 * getProperty('iconP1.scale.x'))/2 - 26*2)

        setProperty('iconP2.x', -593+getProperty('healthBar.x') + (getProperty('healthBar.width')*(remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)*0.01))+(150 * getProperty('iconP2.scale.x')-150)/2 - 26)
    end
end

function onEvent(name, value1, value2)
    if name == 'reverseHealthBar' then
        -- Flip health bar based on event argument value
        if value1 == 'true' then
            flippedHealthBar = true
        elseif value1 == 'false' then
            flippedHealthBar = false
        end

        -- Apply the new state after the event change
        applyFlipState(flippedHealthBar)
    end
end

-- Helper function to apply flip state
function applyFlipState(isFlipped)
    if isFlipped then
        -- Flip the health bar and icons visually
        setProperty('healthBar.flipX', true)
        setProperty('iconP1.flipX', true)
        setProperty('iconP2.flipX', true)
    else
        -- Restore the health bar and icons to normal state
        setProperty('healthBar.flipX', false)
        setProperty('iconP1.flipX', false)
        setProperty('iconP2.flipX', false)
    end
end

-- Helper function to remap health percentage (adjust this if needed for a better fit)
function remapToRange(value, start1, stop1, start2, stop2)
    return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1))
end
