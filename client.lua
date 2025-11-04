local ESX = exports['es_extended']:getSharedObject()
local playerPlaytime = 0
local lastWeapon = `WEAPON_UNARMED`

-- Fetch playtime from server
CreateThread(function()
    Wait(2000)
    ESX.TriggerServerCallback('xpider-playtime:getPlaytime', function(hours)
        playerPlaytime = hours
    end)
end)

-- Get player identifier when loaded
AddEventHandler('esx:playerLoaded', function(playerData)
    TriggerServerEvent('xpider-playtime:playerLoaded', playerData.identifier)
end)

-- Check if weapon is ignored
local function isWeaponIgnored(weapon)
    for _, w in ipairs(Config.IgnoreWeapons) do
        if GetHashKey(w) == weapon then
            return true
        end
    end
    return false
end

-- Forcefully remove restricted weapons if playtime not met
CreateThread(function()
    while true do
        Wait(300)
        local ped = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(ped)

        if currentWeapon ~= lastWeapon then
            lastWeapon = currentWeapon

            -- If player equipped a new weapon
            if currentWeapon ~= `WEAPON_UNARMED` and not isWeaponIgnored(currentWeapon) then
                if playerPlaytime < Config.RequiredHours then
                    -- Force unarmed and clear tasks to stop weapon holding
                    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                    ClearPedTasks(ped)
                    RemoveAllPedWeapons(ped, false)

                    TriggerEvent('chat:addMessage', {
                        args = {"^1You may not pull out a weapon until you have reached " .. Config.RequiredHours .. " hours of playtime."}
                    })
                end
            end
        end
    end
end)

-- /playtime command
RegisterCommand('playtime', function()
    local name = ESX.GetPlayerData().name or "Unknown"
    TriggerEvent('chat:addMessage', {
        args = {"^2Your total time played as " .. name .. ": ^7" .. string.format("%.2f", playerPlaytime) .. " hours"}
    })
end)
