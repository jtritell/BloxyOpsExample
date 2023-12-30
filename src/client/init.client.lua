local DisplayEvents = require(script.DisplayEvents)
local DisplayGamePass = require(script.DisplayGamePass)
local DisplaySidePanel = require(script.SidePanel)
-- DisplayEvents()
-- DisplayGamePass()
DisplaySidePanel()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerConnectFunction = ReplicatedStorage:WaitForChild("PlayerConnectFunction")


-- Assuming you want to call this as soon as the client's game starts
local response = PlayerConnectFunction:InvokeServer()

print(response)  -- Prints the server's response
