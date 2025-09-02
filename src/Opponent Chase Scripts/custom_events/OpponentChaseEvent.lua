local enabled = false
local barX = 0
local barY = 0
local barWidth = 0
local initialized = false
local enabled2 = false

function onEvent(name, value1, value2)
    if name == "OpponentChaseEvent" then
        if value1 == "true" then
            enabled = true

            if not initialized then
                setProperty('health', 2)
                initialized = true
            end

            barX = getProperty('healthBar.x')
            barY = getProperty('healthBar.y')
            barWidth = getProperty('healthBar.width')

            setProperty('iconP1.flipX', true)
            -- setProperty('iconP1.flipX', false)
            -- setProperty('iconP2.flipX', false)
            -- setProperty('iconP2.flipX', true)
        else
            enabled = false

            if initialized then
                setProperty('health', 1)
                initialized = false
            end

            barX = getProperty('healthBar.x')
            barY = getProperty('healthBar.y')
            barWidth = getProperty('healthBar.width')

            -- setProperty('iconP1.flipX', true)
            setProperty('iconP1.flipX', false)
            -- setProperty('iconP2.flipX', false)
            -- setProperty('iconP2.flipX', true)
        end

        if value2 == "true" then
            enabled2 = true

            if not initialized then
                setProperty('health', 2)
                initialized = true
            end
        
            barX = getProperty('healthBar.x')
            barY = getProperty('healthBar.y')
            barWidth = getProperty('healthBar.width')

            -- setProperty('iconP1.flipX', true)
            -- setProperty('iconP1.flipX', false)
            -- setProperty('iconP2.flipX', false)
            setProperty('iconP2.flipX', true)

            setProperty('healthBar.flipX', true)
            -- setProperty('healthBar.flipX', false)
        else
            enabled2 = false

            if initialized then
                setProperty('health', 1)
                initialized = false
            end
        
            barX = getProperty('healthBar.x')
            barY = getProperty('healthBar.y')
            barWidth = getProperty('healthBar.width')

            -- setProperty('iconP1.flipX', true)
            -- setProperty('iconP1.flipX', false)
            setProperty('iconP2.flipX', false)
            -- setProperty('iconP2.flipX', true)

            -- setProperty('healthBar.flipX', true)
            setProperty('healthBar.flipX', false)
        end
    end
end

function onUpdatePost(elapsed)
    healthPercent = remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)

    if enabled then
        -- setProperty('iconP2.x', barX - 75)
        -- setProperty('iconP2.y', barY - 75)

        setProperty('iconP1.x', barX + barWidth - 135)
        setProperty('iconP1.y', barY - 75)

        setProperty('iconP1.origin.x', 0)
        setProperty('iconP1.origin.y', 0)
        -- setProperty('iconP2.origin.x', 0)
        -- setProperty('iconP2.origin.y', 0)
    end

    if enabled2 then
        setProperty('iconP1.x', -593+getProperty('healthBar.x') + (getProperty('healthBar.width')*(remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)*0.01))-(150 * getProperty('iconP1.scale.x'))/2 - 26*2)
        setProperty('iconP2.x', -593+getProperty('healthBar.x') + (getProperty('healthBar.width')*(remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)*0.01))+(150 * getProperty('iconP2.scale.x')-150)/2 - 26)
        -- setProperty('iconP2.x', barX - 75)
        -- setProperty('iconP2.y', barY - 75)

        setProperty('iconP1.x', barX - 15)
        setProperty('iconP1.y', barY - 75)

        setProperty('iconP1.origin.x', 0)
        setProperty('iconP1.origin.y', 0)
        -- setProperty('iconP2.origin.x', 0)
        -- setProperty('iconP2.origin.y', 0)
    end
end

function remapToRange(value, start1, stop1, start2, stop2)
    return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1))
end