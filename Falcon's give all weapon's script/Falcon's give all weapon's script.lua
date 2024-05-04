-- List does not contain MG42
local mafia_2_weapons = {
    Model_12_Revolver = {
        ID = 2,
        ammo = 42
    },

    Mauser_C96 = {
        ID = 3,
        ammo = 60
    },

    Colt_M1911A1 = {
        ID = 4,
        ammo = 56
    },

    Colt_M1911_Special = {
        ID = 5,
        ammo = 92
    },

    Model_19_Revolver = {
        ID = 6,
        ammo = 42
    },
    
    -- MK2_Dummy_Frag_Grenade = {
    --     ID = 7,
    --     ammo = 5
    -- },

    Remington_Model_870_Field_gun = {
        ID = 8,
        ammo = 56
    },

    M3_Grease_Gun = {
        ID = 9,
        ammo = 120
    },

    MP40 = {
        ID = 10,
        ammo = 128
    },

    Thompson_1928 = {
        ID = 11,
        ammo = 200
    },

    M1A1_Thompson = {
        ID = 12,
        ammo = 120
    },

    Beretta_Model_38A = {
        ID = 13,
        ammo = 120
    },

    -- MG42 = {
    --     ID = 14 ,
    --     ammo = 32
    -- },

    M1_Garand = {
        ID = 15 ,
        ammo = 40
    },

    Kar98k = {
        ID = 17,
        ammo = 35
    },

    MK2_Frag_Grenade = {
        ID = 20,
        ammo = 6
    },

    Molotov_Cocktail = {
        ID = 21,
        ammo = 6
    }
}

function AddWeapon( WeaponID, Ammo )
    game.game:GetActivePlayer():InventoryAddWeapon( WeaponID, Ammo )
    game.game:GetActivePlayer():InventoryReload( WeaponID, Ammo )
end

function giveGuns()
    for _, v in pairs( mafia_2_weapons ) do
        AddWeapon( v["ID"], v["ammo"] )
    end
end


DelayBuffer:Insert( giveGuns, _, 250, 1, false )
