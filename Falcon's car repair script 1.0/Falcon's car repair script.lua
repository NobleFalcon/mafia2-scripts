-- Version 1.0
function RepairCar()
    game.game:GetActivePlayer():GetOwner():RepairAndClear()
    game.game:GetActivePlayer():GetOwner():SetMotorDamage( 0 )
end

DelayBuffer:Insert( RepairCar, _, 250, 1, false )