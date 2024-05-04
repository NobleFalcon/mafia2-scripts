function ToggleGodMode()
    local activePlayer = game.game:GetActivePlayer()
    if activePlayer then
        if activePlayer.invulnerability then
            activePlayer:SetDemigod(false)
            activePlayer:EnableInjury(true)
            activePlayer.invulnerability = false
        else
            activePlayer:SetDemigod(true)
            activePlayer:EnableInjury(false)
            activePlayer.invulnerability = true
        end
    end
end

local delayMilliseconds = 250
local delayIterations = 1
local delayAsync = false

DelayBuffer:Insert(ToggleGodMode, _, delayMilliseconds, delayIterations, delayAsync)
