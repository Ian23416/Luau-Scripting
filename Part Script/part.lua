local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LevelingModule = require(ReplicatedStorage:WaitForChild("LevelingModule"))

local ClickDetector = script.Parent:WaitForChild("ClickDetector")

local XpAmount = 50

ClickDetector.MouseClick:Connect(function(Player)
	LevelingModule:AddXp(Player, XpAmount)
end)

