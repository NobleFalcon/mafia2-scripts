-- List does not contain MG42
-- ID Source https://wiki.mafia2-online.com/index.php?title=Weapons
local mafia_2_weapons = {
    Model_12_Revolver = {
        ID = 2,
        ammo = 36
    },

    Mauser_C96 = {
        ID = 3,
        ammo = 50
    },

    Colt_M1911A1 = {
        ID = 4,
        ammo = 49
    },

    Colt_M1911_Special = {
        ID = 5,
        ammo = 69
    },

    Model_19_Revolver = {
        ID = 6,
        ammo = 36
    },
    
    MK2_Frag_Grenade = {
        ID = 7,
        ammo = 5
    },

    Remington_Model_870_Field_gun = {
        ID = 8,
        ammo = 48
    },

    M3_Grease_Gun = {
        ID = 9,
        ammo = 90
    },

    MP40 = {
        ID = 10,
        ammo = 96
    },

    Thompson_1928 = {
        ID = 11,
        ammo = 150
    },

    M1A1_Thompson = {
        ID = 12,
        ammo = 90
    },

    Beretta_Model_38A = {
        ID = 13,
        ammo = 90
    },

    MG42 = {
        ID = 14 ,
        ammo = 32
    },

    M1_Garand = {
        ID = 15 ,
        ammo = 32
    },

    Kar98k = {
        ID = 17,
        ammo = 30
    },

    Molotov_Cocktail = {
        ID = 21,
        ammo = 5
    }
}

function AddWeapon( WeaponID, Ammo )
    game.game:GetActivePlayer():InventoryAddWeapon( WeaponID, Ammo )
end

function GetAndGiveGuns( table )
    for _, v in pairs( table ) do
        AddWeapon( v["ID"], v["ammo"] )
    end
end

function RunWithDelay()
    GetAndGiveGuns( mafia_2_weapons )
end

DelayBuffer:Insert( RunWithDelay, _, 250, 1, false )