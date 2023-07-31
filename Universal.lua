-- UI
local Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = {Name = "Yiffy Hub", HidePremium = false, IntroText = "Yiffy Hub", SaveConfig = true, ConfigFolder = "Config"}

-- Values
local InfJump = false
local Noclip = false
local InfJumpConnection
local NoclipConnection

-- Windows
local UniversalWindow = Library:MakeWindow(Window)

-- Tabs
local HomeTab = UniversalWindow:MakeTab({
	Name = "Home",
	Icon = "rbxassetid://7733960981",
	PremiumOnly = false
})

local PlayerTab = UniversalWindow:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://7743871002",
	PremiumOnly = false
})

local ESPTab = UniversalWindow:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://7733774602",
	PremiumOnly = false
})

-- Home Stuff
local AboutSection = HomeTab:AddSection({
	Name = "About"
})

HomeTab:AddParagraph("Yiffy Hub","Welcome, to Yiffy Hub!")
HomeTab:AddLabel("Your Executor is "..getexecutorname() or identifyexecutor() or "Unknown")

local MiscSection = HomeTab:AddSection({
	Name = "Misc"
})

HomeTab:AddButton({
	Name = "Join Discord Server!",
	Callback = function()
      	setclipboard("https://discord.gg/2bw7W39BjW")
        Library:MakeNotification({
            Name = "Yiffy Hub",
            Content = "Discord server invite copied to clipboard!",
            Image = "rbxassetid://8997386648",
            Time = 5
        })
  	end
})

HomeTab:AddButton({
	Name = "Destroy Interface!",
	Callback = function()
        Library:Destroy()
  	end    
})

-- Player Stuff
local PropertiesSection = PlayerTab:AddSection({
	Name = "Properties"
})

PlayerTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 500,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		local Hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        Hum.WalkSpeed = Value
	end
})

PlayerTab:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		local Hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        Hum.JumpPower = Value
	end
})

local CharacterSection = PlayerTab:AddSection({
	Name = "Character"
})

PlayerTab:AddToggle({
	Name = "Infinite Jump",
	Default = false,
	Callback = function(Value)
		InfJump = Value
        if InfJump then
            InfJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                local Hum = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
                if Hum then
                    Hum:ChangeState("Jumping")
                end
            end)
        else
            if InfJumpConnection then
                InfJumpConnection:Disconnect()
            end
        end
	end
})

PlayerTab:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(Value)
		Noclip = Value
		if Noclip then
			NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
				for i, part in pairs(game.Workspace:GetDescendants()) do
					if part:IsA("Part") and part.Name ~= "Baseplate" then
						part.CanCollide = false
					end
				end
			end)
		else
			if NoclipConnection then
				NoclipConnection:Disconnect()
			end
			for i, part in pairs(game.Workspace:GetDescendants()) do
				if part:IsA("Part") then
					part.CanCollide = true
				end
			end
		end
	end
})

-- ESP Stuff
print("coming soon har har har")

-- Initialize
Library:Init()
