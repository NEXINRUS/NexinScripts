--== Print Version ==--
local versionURL = "https://raw.githubusercontent.com/NEXINRUS/NexinScripts/refs/heads/main/MicrosoftCMDShowcase/Version.txt"

local versionText = game:HttpGet(versionURL)
print("Version:", versionText)

--== Load Main Script ==--
loadstring(game:HttpGet("https://raw.githubusercontent.com/NEXINRUS/NexinScripts/refs/heads/main/MicrosoftCMDShowcase/Source.lua"))()
