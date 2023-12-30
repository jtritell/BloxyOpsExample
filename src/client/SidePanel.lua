local Roact = require(game.ReplicatedStorage.Roact)

local RunService = game:GetService("RunService")
local SidePanel = Roact.Component:extend("SidePanel")

function SidePanel:init(props)
    self:setState({
        -- Assuming the event ends in 1 hour from now
        -- This is just an example, adjust the endTime for your use case
        endTime = os.time() + 3600
        
    })
end

function SidePanel:render()
    local currentTime = os.time()
    local timeLeft = self.state.endTime - currentTime
    local hours = math.floor(timeLeft / 3600)
    local minutes = math.floor((timeLeft % 3600) / 60)
    local seconds = timeLeft % 60

    local countdownText = string.format("%02d:%02d:%02d", hours, minutes, seconds)

    return Roact.createElement("Frame", {
        Size = UDim2.new(0, 100, 1, 0), -- 100 pixels wide, full height
        Position = UDim2.new(1, -100, 0, 0), -- Positioned on the right side
        BackgroundTransparency = 1, -- Transparent background
    }, {
        EventsButton = Roact.createElement("TextButton", {
            Size = UDim2.new(1, 0, 0, 50), -- Full width, 50 pixels tall
            Position = UDim2.new(0, 0, 0, 50),
            Text = "Events",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            [Roact.Event.Activated] = function()
                local DisplayEvents = require(script.Parent.DisplayEvents)
                DisplayEvents()
            end,
        }),
        StoreButton = Roact.createElement("TextButton", {
            Size = UDim2.new(1, 0, 0, 50),
            Position = UDim2.new(0, 0, 0, 110),
            Text = "Store",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            [Roact.Event.Activated] = function()
                local DisplayGamePass = require(script.Parent.DisplayGamePass)
                DisplayGamePass()
            end,
        }),
        EventCountdown = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 50),
            Position = UDim2.new(0, 0, 0, 170),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        }, {
            CountdownLabel = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Text = "Event: " .. countdownText,
                BackgroundTransparency = 1,
                TextColor3 = Color3.fromRGB(0, 0, 0),
            })
        }),
    })
end


function SidePanel:didMount()
    -- Store the connection to disconnect it later
    self.updateTimer = RunService.Stepped:Connect(function()
        if os.time() >= self.state.endTime then
            if self.updateTimer then
                self.updateTimer:Disconnect()
            end
            return
        end
        -- Trigger a re-render by updating the state
        self:setState({})
    end)
end

function SidePanel:willUnmount()
    if self.updateTimer then
        self.updateTimer:Disconnect()
    end
end

return function()
	local Roact = require(game.ReplicatedStorage.Roact)
	local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

	local app = Roact.createElement("ScreenGui", nil, {
		Game = Roact.createElement(SidePanel,
		{
			Position = UDim2.new(0.5, 0, 0.5, 0),
			backgroundColor3 = Color3.fromRGB(216, 211, 134),
			Size = UDim2.new(0,400,0,300)
		})
	})

	local handle = Roact.mount(app, PlayerGui)

	local function stop()
		Roact.unmount(handle)
	end

	return stop
end