local barX = 0
local barY = 0
local barWidth = 0

function onCreatePost()
    barX = getProperty('healthBar.x')
    barY = getProperty('healthBar.y')
    barWidth = getProperty('healthBar.width')

    setProperty('health', 2)

    -- setProperty('iconP1.flipX', true)
    -- setProperty('iconP1.flipX', false)
    -- setProperty('iconP2.flipX', false)
    setProperty('iconP2.flipX', true)
end

function onUpdatePost(elapsed)
    setProperty('iconP2.x', barX + barWidth - 135)
    setProperty('iconP2.y', barY - 75)

    -- setProperty('iconP1.x', barX + barWidth - 135)
    -- setProperty('iconP1.y', barY - 75)

    -- setProperty('iconP1.origin.x', 0)
    -- setProperty('iconP1.origin.y', 0)
    setProperty('iconP2.origin.x', 0)
    setProperty('iconP2.origin.y', 0)
end
