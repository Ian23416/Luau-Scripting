local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LevelingModule = require(ReplicatedStorage:WaitForChild("LevelingModule"))

local TweenService = game:GetService("TweenService")

local Player = game.Players.LocalPlayer
local leaderstats = Player:WaitForChild("leaderstats")
local Level = leaderstats:WaitForChild("Level")
local XP = leaderstats:WaitForChild("XP")

local LevelUpRemote = ReplicatedStorage:WaitForChild("LevelUpRemote")
local SoundsFolder = ReplicatedStorage:WaitForChild("Sounds")
local LevelUpSound = SoundsFolder:WaitForChild("Level Up")
local LevelTweenInfo = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Back,
	Enum.EasingDirection.In,
	0,
	false,
	0
)
local ProgressbarTweenInfo = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)


local XPPerLevel = LevelingModule.XPPerLevel
local LevelUpGoal = {Size = UDim2.new(0.229, 0,0.127, 0)}


local LevelUpLabel = script.Parent:WaitForChild("LevelLabel")
local Currentlabels = script.Parent:WaitForChild("CurrentLabels")
local Backgroundframe = script.Parent:WaitForChild("Backgroundframe")
local ProgressBar = Backgroundframe:WaitForChild("ProgressBar")
local ProgressBackground = Backgroundframe:WaitForChild("Progressbackroundbar")
local LevelLabel = Backgroundframe:WaitForChild("Level")
LevelLabel.Text = Level.Value

local ProgressBarlength = ProgressBar.Size.X.Scale
local NewSize = {Size = UDim2.new(ProgressBarlength / XPPerLevel * XP.Value, 0, ProgressBar.Size.Y.Scale, 0)}
local tween = TweenService:Create(ProgressBar, ProgressbarTweenInfo, NewSize)
tween:Play()

LevelUpRemote.OnClientEvent:Connect(function()
	local CloneUI = LevelUpLabel:Clone()
	CloneUI.Visible = true
	CloneUI.Parent = Currentlabels
	local Tween = TweenService:Create(CloneUI, LevelTweenInfo, LevelUpGoal)
	Tween:Play()
	LevelUpSound:Play()
	Tween.Completed:Connect(function()
		task.delay(2, function()
			CloneUI:Destroy()
		end)
	end)
end)

Level.Changed:Connect(function(val)
	LevelLabel.Text = val
end)

XP.Changed:Connect(function(val)
	local NewSize = {Size = UDim2.new(ProgressBarlength / XPPerLevel * val, 0, ProgressBar.Size.Y.Scale, 0)}
	local tween = TweenService:Create(ProgressBar, ProgressbarTweenInfo, NewSize)
	tween:Play()
end)