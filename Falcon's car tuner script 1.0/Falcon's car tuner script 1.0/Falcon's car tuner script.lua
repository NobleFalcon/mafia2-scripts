-- Version 1.0
function GetCarTuningLevel()
    return game.game:GetActivePlayer():GetOwner():GetActualTuningTable()
end

function SetCarTuningLevel( level )
    function SetTuningLevel( level )
        game.game:GetActivePlayer():GetOwner():SetActualTuningTable( level )
    end

    if GetCarTuningLevel() < 3 then
        SetTuningLevel( GetCarTuningLevel() + 1 )
    else
        SetTuningLevel( 0 )
    end
end

DelayBuffer:Insert( SetCarTuningLevel, _, 250, 1, false )