local DatastoreService = game:GetService("DataStoreService")
local LeaderStore = DatastoreService:GetDataStore("LeaderStore")

local function LoadData(player) -- loads data 
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end 
	local Coins = leaderstats:FindFirstChild("Coins")
	if not Coins then return end
	local Level = leaderstats:FindFirstChild("Level")
	if not Level then return end
	local success, data = pcall(function()
		return LeaderStore:GetAsync(player.UserId)
	end)
	if success then
		if data then
			Coins.Value = data.Coins
			Level.Value = data.Level
		else
			warn("No data found")
			Coins.Value = 0
			Level.Value = 0
		end
	else
		warn(data)
	end
end

local function SaveData(player) -- saves data
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end 
	local Coins = leaderstats:FindFirstChild("Coins")
	if not Coins then return end
	local Level = leaderstats:FindFirstChild("Level")
	if not Level then return end
	local PlayerData = {
		Coins = Coins.Value,
		Level = Level.Value
	}
	local success, error = pcall(function()
		return LeaderStore:SetAsync(player.UserId, PlayerData)
	end)
	if success then
		print("Successfully saved Data!")
	else
		warn(error)
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	local Coins = Instance.new("IntValue")
	Coins.Name = "Coins"
	Coins.Parent = leaderstats
	local Level = Instance.new("IntValue")
	Level.Name = "Level"
	Level.Parent = leaderstats
	LoadData(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	SaveData(player)
end)