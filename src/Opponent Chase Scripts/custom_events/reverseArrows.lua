local playerPositions = {}
local opponentPositions = {}
local reverse = false -- Reverse starts inactive and only changes via the event

function onCreatePost()
    -- Save original positions
    for i = 0, 3 do
        playerPositions[i] = {
            x = getPropertyFromGroup('playerStrums', i, 'x'),
            y = getPropertyFromGroup('playerStrums', i, 'y')
        }
        opponentPositions[i] = {
            x = getPropertyFromGroup('strumLineNotes', i, 'x'),
            y = getPropertyFromGroup('strumLineNotes', i, 'y')
        }
    end
end

function onEvent(name, value1, value2)
    if name == "reverseArrows" then
        if value1 == "true" then
            reverse = true -- Enable reverse
        elseif value1 == "false" then
            reverse = false -- Disable reverse
            resetPositions() -- Immediately reset positions when turned off
        end
    end
end

function onUpdate(elapsed)
    if reverse then
        for i = 0, 3 do
            -- Swap player and opponent arrow positions
            setPropertyFromGroup('playerStrums', i, 'x', opponentPositions[i].x)
            setPropertyFromGroup('playerStrums', i, 'y', opponentPositions[i].y)

            setPropertyFromGroup('strumLineNotes', i, 'x', playerPositions[i].x)
            setPropertyFromGroup('strumLineNotes', i, 'y', playerPositions[i].y)
        end
    end
end

function resetPositions()
    -- Reset all arrows to their original positions
    for i = 0, 3 do
        setPropertyFromGroup('playerStrums', i, 'x', playerPositions[i].x)
        setPropertyFromGroup('playerStrums', i, 'y', playerPositions[i].y)

        setPropertyFromGroup('strumLineNotes', i, 'x', opponentPositions[i].x)
        setPropertyFromGroup('strumLineNotes', i, 'y', opponentPositions[i].y)
    end
end
