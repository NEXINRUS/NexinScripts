-- Made By Qrexotwy

--== Generate a random GUI name (letters only) ==--
local function randomName(length)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	local name = ""
	for i = 1, length do
		local rand = math.random(1, #chars)
		name = name .. chars:sub(rand, rand)
	end
	return name
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local username = localPlayer.Name -- Actual username

--== Cleanup old GUIs by name pattern ==--
for _, gui in pairs(game.CoreGui:GetChildren()) do
	if gui:IsA("ScreenGui") and (gui.Name == "FakeCMD" or gui.Name == "CmdHelp") then
		gui:Destroy()
	end
end

--== Check if help GUI already exists ==--
local existingHelpGui = nil
for _, gui in pairs(game.CoreGui:GetChildren()) do
	if gui:IsA("ScreenGui") and gui:FindFirstChild("IsHelpGui") then
		existingHelpGui = gui
		break
	end
end

--== Create Main CMD GUI ==--
local guiName = randomName(10)
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = guiName
gui.ResetOnSpawn = false

--== Main Frame ==--
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 300)
frame.Position = UDim2.new(0.5, -300, 0, -320)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 120, 215)
frame.Active = true
frame.Draggable = true

--== Flash border effect ==--
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
    BorderColor3 = Color3.fromRGB(255, 255, 255)
}):Play()
task.wait(0.6)
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
    BorderColor3 = Color3.fromRGB(0, 120, 215)
}):Play()

--== Slide-in animation ==--
TweenService:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -300, 0.5, -150)
}):Play()

--== Title Bar ==--
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
title.Text = " C:\\Windows\\System32\\cmd.exe - " .. username
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSans
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

--== Scrollable Output ==--
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.Size = UDim2.new(1, -10, 1, -65)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 9999)

local content = Instance.new("TextLabel", scroll)
content.Size = UDim2.new(1, -5, 0, 9999)
content.TextColor3 = Color3.fromRGB(200, 200, 200)
content.Font = Enum.Font.Code
content.TextSize = 16
content.TextXAlignment = Enum.TextXAlignment.Left
content.TextYAlignment = Enum.TextYAlignment.Top
content.BackgroundTransparency = 1
content.TextWrapped = true
content.Text = "Microsoft Windows [Version 10.0.19045.3324]\n(c) NexinRUS Corporation. All rights reserved.\n\nC:\\Users\\" .. username .. ">"

--== Input Bar ==--
local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(1, -10, 0, 25)
input.Position = UDim2.new(0, 5, 1, -28)
input.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
input.TextColor3 = Color3.new(1, 1, 1)
input.Font = Enum.Font.Code
input.TextSize = 16
input.Text = ""
input.ClearTextOnFocus = false
input.TextXAlignment = Enum.TextXAlignment.Left
input.PlaceholderText = "Type a command..."
input.BorderSizePixel = 0

--== Cursor Blinker ==--
task.spawn(function()
	while gui and gui.Parent do
		if input:IsFocused() then
			input.Text = input.Text .. "_"
			wait(0.4)
			input.Text = input.Text:gsub("_$", "")
			wait(0.4)
		else
			wait(0.5)
		end
	end
end)

--== Commands and responses ==--
local responses = {
	help = [[
Available commands:
help             - List all available commands
cls              - Clear the screen
echo [text]      - Print a line of text
whoami           - Display the current user
dir              - Show fake files/folders
walkspeed [num]  - Set your WalkSpeed
jumppower [num]  - Set your JumpPower
vibemode         - Activate Russian words vibemode for 10 seconds
time             - Show local time
tp [placeid]     - Teleport to another Roblox place
sit              - Toggle sit/stand
jump             - Make your character jump
reset            - Reset your character (respawn)
stats            - Show your WalkSpeed and JumpPower
credits          - Show software credits
exit             - Close all command windows
]],
	cls = "CLEAR_SCREEN",
	echo = "ECHO",
	whoami = "C:\\Users\\" .. username,
	dir = [[
 Volume in drive C is OS
 Directory of C:\Users\]] .. username .. [[

07/17/2025  12:00 PM    <DIR>          Desktop
07/17/2025  12:00 PM    <DIR>          Documents
07/17/2025  12:00 PM    <DIR>          Scripts
	]],
	credits = "Software Engineer: qrexotwy",
	exit = "CLOSING_CMD"
}

--== Russian words for vibemode ==--
local vibemodeMessages = {
	"ВИБРОРЕЖИМ",
	"ЖМИ СИЛЬНЕЕ!",
	"УЛЬТРА МЛГ",
	"ПРИВЕТ ИЗ РОССИИ",
	"ДРИП ЧИП",
	"ЛИЛ АЛГОРИТМ",
	"ПРИЗРАЧНЫЙ ШИФР",
	"БЫСТРЕЕ СВЕТА",
	"РОССИЙСКИЙ ВЫЗОВ",
	"ТАНЦУЙ ВИБРОРЕЖИМ"
}

local vibemodeColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(255, 0, 255),
	Color3.fromRGB(255, 127, 0),
	Color3.fromRGB(127, 0, 255),
	Color3.fromRGB(0, 127, 255),
	Color3.fromRGB(127, 255, 0),
}

--== Append output text and scroll smoothly ==--
local function appendOutput(text)
	content.Text = content.Text .. text .. "\nC:\\Users\\" .. username .. ">"
	task.wait()
	local scrollY = content.TextBounds.Y - scroll.AbsoluteSize.Y + 25
	if scrollY > 0 then
		TweenService:Create(scroll, TweenInfo.new(0.25), {
			CanvasPosition = Vector2.new(0, scrollY)
		}):Play()
	end
end

--== Table to keep track of vibemode GUIs ==--
local activeVibeGuis = {}

--== Function to create one vibemode GUI popup ==--
local function createVibeGui(text, color)
	local vibeGui = Instance.new("ScreenGui", game.CoreGui)
	vibeGui.Name = randomName(8)

	local vibeLabel = Instance.new("TextLabel", vibeGui)
	vibeLabel.Size = UDim2.new(0, 150, 0, 40)
	vibeLabel.BackgroundTransparency = 0.3
	vibeLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	vibeLabel.TextColor3 = color
	vibeLabel.Font = Enum.Font.SourceSansBold
	vibeLabel.TextSize = 24
	vibeLabel.Text = text
	vibeLabel.TextStrokeColor3 = Color3.new(0,0,0)
	vibeLabel.TextStrokeTransparency = 0.5
	vibeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	
	-- Random screen position
	local x = math.random(0, workspace.CurrentCamera.ViewportSize.X - 150)
	local y = math.random(50, workspace.CurrentCamera.ViewportSize.Y - 100)
	vibeGui.IgnoreGuiInset = true
	vibeGui.ResetOnSpawn = false
	vibeGui.Enabled = true
	vibeGui.DisplayOrder = 9999

	vibeGui.Parent = game.CoreGui

	vibeLabel.Position = UDim2.new(0, x, 0, y)

	-- Fade in/out animation loop
	local tweenIn = TweenService:Create(vibeLabel, TweenInfo.new(0.5), {TextTransparency = 0})
	local tweenOut = TweenService:Create(vibeLabel, TweenInfo.new(0.5), {TextTransparency = 1})

	vibeLabel.TextTransparency = 1

	-- Start animation loop
	local running = true
	task.spawn(function()
		while running do
			tweenIn:Play()
			tweenIn.Completed:Wait()
			wait(0.7)
			tweenOut:Play()
			tweenOut.Completed:Wait()
		end
	end)

	-- Return a function to stop and clean up
	return function()
		running = false
		vibeGui:Destroy()
	end
end

--== Run entered command ==--
local function runCommand(cmd)
	local args = cmd:split(" ")
	local base = args[1]:lower()

	if responses[base] then
		if responses[base] == "CLEAR_SCREEN" then
			content.Text = ""
			appendOutput("")
		elseif responses[base] == "ECHO" then
			appendOutput(table.concat(args, " ", 2))
		elseif responses[base] == "CLOSING_CMD" then
			-- Destroy both GUIs
			gui:Destroy()
			if existingHelpGui then
				existingHelpGui:Destroy()
			end
		else
			appendOutput(responses[base])
		end
	elseif base == "vibemode" then
		appendOutput("ВИБРОРЕЖИМ ЗАПУЩЕН... (10 секунд)")
		-- Disable input while vibemode runs
		input.ClearTextOnFocus = true
		input.TextEditable = false
		
		-- Create all vibe GUIs
		for i, msg in ipairs(vibemodeMessages) do
			local stopFunc = createVibeGui(msg, vibemodeColors[i] or Color3.new(1,1,1))
			table.insert(activeVibeGuis, stopFunc)
		end
		
		-- After 10 seconds, stop all vibe GUIs and re-enable input
		task.spawn(function()
			task.wait(10)
			for _, stopFunc in ipairs(activeVibeGuis) do
				stopFunc()
			end
			activeVibeGuis = {}
			appendOutput("ВИБРОРЕЖИМ ЗАВЕРШЕН")
			input.ClearTextOnFocus = false
			input.TextEditable = true
			input:CaptureFocus()
		end)
	elseif base == "walkspeed" then
		local val = tonumber(args[2])
		if val and val > 0 then
			local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = val
				appendOutput("WalkSpeed set to " .. val)
			else
				appendOutput("Humanoid not found!")
			end
		else
			appendOutput("Usage: walkspeed [number]")
		end
	elseif base == "jumppower" then
		local val = tonumber(args[2])
		if val and val > 0 then
			local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.JumpPower = val
				appendOutput("JumpPower set to " .. val)
			else
				appendOutput("Humanoid not found!")
			end
		else
			appendOutput("Usage: jumppower [number]")
		end
	elseif base == "time" then
		local timeString = os.date("%Y-%m-%d %H:%M:%S")
		appendOutput("Local time: " .. timeString)
	elseif base == "tp" then
		local placeId = tonumber(args[2])
		if placeId then
			appendOutput("Teleporting to place ID: " .. placeId)
			-- Synapse teleport function
			if syn and syn.request then
				syn.request({Url = "https://www.roblox.com/games/" .. placeId, Method = "GET"})
			end
			-- Roblox teleport
			pcall(function()
				local TeleportService = game:GetService("TeleportService")
				TeleportService:Teleport(placeId, localPlayer)
			end)
		else
			appendOutput("Usage: tp [placeid]")
		end
	elseif base == "sit" then
		local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Sit = not humanoid.Sit
			appendOutput("Sit toggled to " .. tostring(humanoid.Sit))
		else
			appendOutput("Humanoid not found!")
		end
	elseif base == "jump" then
		local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Jump = true
			appendOutput("Jumped!")
		else
			appendOutput("Humanoid not found!")
		end
	elseif base == "reset" then
		appendOutput("Resetting character...")
		localPlayer:LoadCharacter()
	elseif base == "stats" then
		local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			appendOutput(string.format("WalkSpeed: %.2f | JumpPower: %.2f", humanoid.WalkSpeed, humanoid.JumpPower))
		else
			appendOutput("Humanoid not found!")
		end
	elseif base == "credits" then
		appendOutput(responses["credits"])
	else
		appendOutput("'" .. cmd .. "' is not recognized as an internal or external command.")
	end
end

--== On enter key pressed in input box ==--
input.FocusLost:Connect(function(enter)
	if enter then
		-- remove blinking cursor if present
		local cmd = input.Text:gsub("_$", "")
		appendOutput(cmd)
		runCommand(cmd)
		input.Text = ""
	end
end)

wait(0.3)
input:CaptureFocus()

--== HELP WINDOW with random name, replaced if exists ==--
if existingHelpGui then
	existingHelpGui:Destroy()
end

local helpGuiName = randomName(10)
local helpGui = Instance.new("ScreenGui", game.CoreGui)
helpGui.Name = helpGuiName
helpGui.ResetOnSpawn = false

--== Tag to identify this as help GUI ==--
local tag = Instance.new("BoolValue", helpGui)
tag.Name = "IsHelpGui"
tag.Value = true

local helpFrame = Instance.new("Frame", helpGui)
helpFrame.Size = UDim2.new(0, 320, 0, 270)
helpFrame.Position = UDim2.new(1, -330, 0.5, -135)
helpFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
helpFrame.BorderSizePixel = 0
helpFrame.Active = true
helpFrame.Draggable = true
helpFrame.ClipsDescendants = true

local helpTitle = Instance.new("TextLabel", helpFrame)
helpTitle.Size = UDim2.new(1, 0, 0, 30)
helpTitle.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
helpTitle.Text = " Available CMD Commands"
helpTitle.Font = Enum.Font.GothamBold
helpTitle.TextSize = 20
helpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
helpTitle.BorderSizePixel = 0
helpTitle.TextYAlignment = Enum.TextYAlignment.Center

local helpContent = Instance.new("TextLabel", helpFrame)
helpContent.Position = UDim2.new(0, 10, 0, 40)
helpContent.Size = UDim2.new(1, -20, 1, -50)
helpContent.BackgroundTransparency = 1
helpContent.TextColor3 = Color3.fromRGB(210, 210, 210)
helpContent.Font = Enum.Font.Code
helpContent.TextSize = 14
helpContent.TextXAlignment = Enum.TextXAlignment.Left
helpContent.TextYAlignment = Enum.TextYAlignment.Top
helpContent.TextWrapped = true
helpContent.Text = [[
help             - List all available commands
echo [text]      - Print a line of text
whoami           - Display the current user
dir              - Show fake files/folders
walkspeed [num]  - Set your WalkSpeed
jumppower [num]  - Set your JumpPower
vibemode         - Activate Russian MLG vibemode for 10 seconds
time             - Show local time
tp [placeid]     - Teleport to another Roblox place
sit              - Toggle sit/stand
jump             - Make your character jump
reset            - Reset your character (respawn)
stats            - Show your WalkSpeed and JumpPower
credits          - Show software credits
cls              - Clear the screen
exit             - Close all command windows
]]

