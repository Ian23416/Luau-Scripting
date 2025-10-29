local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LevelUpRemote = ReplicatedStorage:WaitForChild("LevelUpRemote")

local LevelingModule = {
	XPPerLevel = 200, -- at what xp to add a lvl
}



function LevelingModule:AddXp(Player : Player, Amount: number) -- adds xp
	local Leaderstats = Player:FindFirstChild("leaderstats")
	if not Leaderstats then return end
	local XPValue = Leaderstats:FindFirstChild("XP")
	if not XPValue then return end 
	local Level = Leaderstats:FindFirstChild("Level")
	if not Level then return end
	XPValue.Value = XPValue.Value + Amount
	if XPValue.Value >= LevelingModule.XPPerLevel then
		local LevelUps = math.floor(XPValue.Value / LevelingModule.XPPerLevel)
		if LevelUps > 0 then
			XPValue.Value -= LevelUps * LevelingModule.XPPerLevel
			Level.Value += LevelUps
			for x = 1, LevelUps, 1 do
				LevelUpRemote:FireClient(Player)
			end
		end

	end
end

return LevelingModule
