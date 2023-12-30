-- fire event to all clients
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventUpdate = game:GetService("ReplicatedStorage"):WaitForChild("EventUpdate")
local GamePassUpdate = game:GetService("ReplicatedStorage"):WaitForChild("GamePassUpdate")

-- Server-side script (in ServerScriptService)
local ServerScript = game:GetService("ServerScriptService"):FindFirstChild("Server")
local RobloxLiveOpsModule = require(ServerScript:FindFirstChild("RobloxLiveOps"))

-- Refresh events when a player connects
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerConnectFunction = ReplicatedStorage:WaitForChild("PlayerConnectFunction")
PlayerConnectFunction.OnServerInvoke = RobloxLiveOpsModule.FetchLiveOps

local PlayerConnectFunction = ReplicatedStorage:WaitForChild("FetchEventsFunction")
PlayerConnectFunction.OnServerInvoke = RobloxLiveOpsModule.FetchEvents

local PlayerConnectFunction = ReplicatedStorage:WaitForChild("FetchGamePassesFunction")
PlayerConnectFunction.OnServerInvoke = RobloxLiveOpsModule.FetchGamePasses
