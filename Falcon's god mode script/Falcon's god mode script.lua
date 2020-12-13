function godmode()
    if game.game:GetActivePlayer().invulnerability then
        game.game:GetActivePlayer():SetDemigod(false)
        game.game:GetActivePlayer():EnableInjury(true)
        game.game:GetActivePlayer().invulnerability = false
    else 
        game.game:GetActivePlayer():SetDemigod(true)
        game.game:GetActivePlayer():EnableInjury(false)
        game.game:GetActivePlayer().invulnerability = true
    end 
end

DelayBuffer:Insert( godmode, _, 250, 1, false )