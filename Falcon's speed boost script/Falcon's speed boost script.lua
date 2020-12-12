local speedBoost = 50

function setCarSpeed()
    local carSpeed = game.game:GetActivePlayer():GetOwner():GetSpeedFloat() + speedBoost
    game.game:GetActivePlayer():GetOwner():SetSpeed(carSpeed)
end

DelayBuffer:Insert( setCarSpeed, _, 250, 1, false )