Config = {}

-- Minimum hours required to use restricted weapons
Config.RequiredHours = 4 -- change this to whatever you want

-- Weapons that are ignored by playtime restriction
Config.IgnoreWeapons = {
    'WEAPON_FLASHLIGHT',
    'WEAPON_SNOWBALL',
    'WEAPON_PETROLCAN'
}

-- How often (in minutes) to save playtime to the database
Config.SaveInterval = 5
