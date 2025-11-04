XPider Playtime

A lightweight and optimized ESX 1.9+ script for tracking player playtime and restricting weapon access based on total hours played.
Perfect for RP servers that want realistic player progression or training systems for new players.

✨ Features

✅ ESX 1.9+ Ready – built with the latest ESX and oxmysql structure

⏱️ Live Playtime Tracking – updates every minute, synced from the database every 10 minutes

🔫 Weapon Restriction System – restricts weapon usage until players reach a configured number of hours

🧍 Shared Playtime – playtime is tracked by identifier (shared across all characters)

🛠️ Fully Configurable – customize required hours, ignored weapons, and save interval

💬 Chat-Based Messages – no notifications, all feedback shown in chat

💾 Automatic Database Handling – creates table if not found and saves progress automatically

⚡ Optimized Performance – 0.00–0.01ms idle usage

⚙️ Configuration
Config.RequiredHours = 5 -- hours required to use restricted weapons

Config.IgnoreWeapons = {
    'WEAPON_KNIFE',
    'WEAPON_FLASHLIGHT',
    'WEAPON_BAT',
    'WEAPON_SNOWBALL'
}

Config.SaveInterval = 5 -- how often (in minutes) playtime saves to DB

💬 Commands
Command	Description
/playtime	Shows your total time played and your character’s name

Example Output:

Your total time played as John Doe: 3.45 hours


If a player tries to pull a restricted weapon before reaching the required hours:

You may not pull out a weapon until you have reached 5 hours of playtime.

🧠 How It Works

Playtime is tracked in real time every minute.

Every 10 minutes, the client re-syncs with the database for accuracy.

The server auto-saves playtime progress every few minutes (configurable).

When a player pulls a restricted weapon before meeting the required time, it is forcefully unequipped.

🧱 Requirements

ESX 1.9+

oxmysql

📦 Installation

Drag the folder xpider-playtime into your resources directory

Add this line to your server.cfg:

ensure xpider-playtime


Configure config.lua to your liking

Restart your server and you’re done!

🔋 Ideal For

Roleplay or Training Servers

Whitelist or Gang RP Environments

Progressive Gameplay Servers

🧑‍💻 Credits

Script Author: XPider

Optimized and built with ❤️ for the FiveM ESX community.
