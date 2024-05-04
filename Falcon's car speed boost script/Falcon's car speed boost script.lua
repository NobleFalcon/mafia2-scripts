local speedBoost = 30

function setCarSpeed()
    local carSpeed = game.game:GetActivePlayer():GetOwner():GetSpeedFloat() + speedBoost
    game.game:GetActivePlayer():GetOwner():SetSpeed(carSpeed)
end

-- Settings for the delay buffer
local delayMilliseconds = 50
local delayIterations = 1
local delayAsync = false

DelayBuffer:Insert(setCarSpeed, nil, delayMilliseconds, delayIterations, delayAsync)
