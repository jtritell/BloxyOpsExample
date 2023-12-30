local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function InitializeEvents(toolbar)
	print(toolbar)
	local evtUpdate = ReplicatedStorage:FindFirstChild("RemoteEvent")
    if (evtUpdate == nil) then
        local UpdatedEvt = Instance.new("RemoteEvent")
        UpdatedEvt.Parent = game.ReplicatedStorage
    end

    local ChangeHistoryService = game:GetService("ChangeHistoryService")

    -- Add a toolbar button named "Create Empty Script"
    local currentEventBtn = toolbar:CreateButton("Use Current Event", "Use the active event in the game right now", "rbxassetid://14978048121")
    -- Add a toolbar button named "Create Empty Script"
    local nextEventBtn = toolbar:CreateButton("Use Next Event", "Use the upcoming event in the game right now", "rbxassetid://14978048121")

    -- Make button clickable even if 3D viewport is hidden
    currentEventBtn.ClickableWhenViewportHidden = true

    local function onCurrentEventClicked()
        -- Toggle force the event to be the current event
        currentEventBtn.Icon = "rbxassetid://2778270261"
    end
    local function onNextEventClicked()
        -- Toggle force the event to be the current event
        nextEventBtn.Icon = "rbxassetid://2778270261"
    end

    currentEventBtn.Click:Connect(onCurrentEventClicked)
    nextEventBtn.Click:Connect(onNextEventClicked)
end


print("module is loaded!!!")

return InitializeEvents