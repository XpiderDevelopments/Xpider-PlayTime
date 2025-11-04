local ESX = exports['es_extended']:getSharedObject()
local oxmysql = exports['oxmysql']
local playtimeData = {}

-- Create table if not exists
CreateThread(function()
    oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS xpider_playtime (
            identifier VARCHAR(60) NOT NULL,
            hours FLOAT DEFAULT 0,
            PRIMARY KEY (identifier)
        )
    ]])
end)

-- Load player playtime
RegisterNetEvent('xpider-playtime:playerLoaded', function(identifier)
    local src = source
    oxmysql:single('SELECT hours FROM xpider_playtime WHERE identifier = ?', {identifier}, function(result)
        if result then
            playtimeData[src] = result.hours
        else
            oxmysql:insert('INSERT INTO xpider_playtime (identifier, hours) VALUES (?, ?)', {identifier, 0})
            playtimeData[src] = 0
        end
    end)
end)

-- Save player playtime
RegisterNetEvent('xpider-playtime:savePlaytime', function(identifier, hours)
    oxmysql:update('UPDATE xpider_playtime SET hours = ? WHERE identifier = ?', {hours, identifier})
end)

-- Get playtime
ESX.RegisterServerCallback('xpider-playtime:getPlaytime', function(source, cb)
    cb(playtimeData[source] or 0)
end)

-- Increment playtime every few minutes
CreateThread(function()
    while true do
        Wait(Config.SaveInterval * 60000)
        for src, hours in pairs(playtimeData) do
            local newHours = hours + (Config.SaveInterval / 60)
            playtimeData[src] = newHours
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer then
                local identifier = xPlayer.identifier
                TriggerEvent('xpider-playtime:savePlaytime', identifier, newHours)
            end
        end
    end
end)

-- Clean up on disconnect
AddEventHandler('playerDropped', function()
    local src = source
    playtimeData[src] = nil
end)
