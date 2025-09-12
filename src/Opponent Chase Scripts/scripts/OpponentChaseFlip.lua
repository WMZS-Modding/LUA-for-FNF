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

    setProperty('healthBar.flipX', true)
    -- setProperty('healthBar.flipX', false)

end

function onUpdatePost(elapsed)

    setProperty('iconP1.x', - 110 + getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26))
    setProperty('iconP2.x', 110 + getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2))
    -- setProperty('iconP2.x', barX - 75)
    -- setProperty('iconP2.y', barY - 75)

    setProperty('iconP1.x', barX - 15)
    setProperty('iconP1.y', barY - 75)

    setProperty('iconP1.origin.x', 0)
    setProperty('iconP1.origin.y', 0)
    -- setProperty('iconP2.origin.x', 0)
    -- setProperty('iconP2.origin.y', 0)
end
