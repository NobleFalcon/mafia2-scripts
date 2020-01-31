-- Version 1.0
function removeWarrant()
    ai.police:ClearKnownCars()
    ai.police:SetKnownPerson( game.game:GetActivePlayer() )
    ai.police:IgnorePerson( game.game:GetActivePlayer():GetGuid(), true )
end

DelayBuffer:Insert( removeWarrant, _, 250, 1, false )