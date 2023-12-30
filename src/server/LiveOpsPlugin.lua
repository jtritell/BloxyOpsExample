--[[ local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

-- Create a new toolbar section titled "Custom Script Tools"
local toolbar = plugin:CreateToolbar("Live Ops")

-- Add a toolbar button named "Create Empty Script"
local newScriptButton = toolbar:CreateButton("Use Current Event", "Use the active event in the game right now", "rbxassetid://14978048121")
-- Add a toolbar button named "Create Empty Script"
local newScriptButton = toolbar:CreateButton("Use Next Event", "Use the upcoming event in the game right now", "rbxassetid://14978048121")

-- Make button clickable even if 3D viewport is hidden
newScriptButton.ClickableWhenViewportHidden = true

local function onNewScriptButtonClicked()
	local selectedObjects = Selection:Get()
	local parent = game:GetService("ServerScriptService")
	if #selectedObjects > 0 then
		parent = selectedObjects[1]
	end

	local newScript = Instance.new("Script")
	newScript.Source = ""
	newScript.Parent = parent
	ChangeHistoryService:SetWaypoint("Added new empty script")
end

newScriptButton.Click:Connect(onNewScriptButtonClicked) ]]