local Roact = require(script.Parent.Parent.Roact)
local Button = require(script.Parent.Button) -- Adjust the path as necessary

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateTextEvent = ReplicatedStorage:WaitForChild("GamePassUpdate")
local FetchGamePassesFunction = ReplicatedStorage:WaitForChild("FetchGamePassesFunction")

local GamePassStore = Roact.Component:extend("Frame")

function GamePassStore:init(props)
	self:setState({
        passes = {},
        onClose = props.onClose or function() end
    })
end

function GamePassStore:onGamePassUpdate(reply)
    if(self.state ~= nil) then
        self.state.passes = reply
    end
end

function GamePassStore:didMount()
	self.gamePassUpdateConnection = UpdateTextEvent.OnClientEvent:Connect(self.onGamePassUpdate)
	local reply = FetchGamePassesFunction:InvokeServer()
	if self.state == nil then
		self.state = {}
	end

	self:setState({
		passes = reply,
		onClose = self.state.onClose or function() end
	})
	end

function GamePassStore:willUnmount()
	if self.gamePassUpdateConnection then
		self.gamePassUpdateConnection:Disconnect()
	end
end

function GamePassStore:render()
	local items = {}
	if self.state ~= nil then
		items = self.state.passes -- Assuming items is passed as a prop
	end
	
    local elements = {}

    local xpad = 20
    local ypad = 50

    elements["CloseButton"] = Roact.createElement("TextButton", {
        Size = UDim2.new(0, 20, 0, 20), -- Small size for the corner
        Position = UDim2.new(1, -25, 0, 5), -- Positioned in the top-right corner
        Text = "X",
        TextColor3 = Color3.new(1, 1, 1), -- White text
        BackgroundColor3 = Color3.new(1, 0, 0), -- Red background
        ZIndex = 2, -- Ensure it's on top of other elements
        [Roact.Event.Activated] = function()
            self.state.onClose()
        end
    })

    elements["TitleText"] = Roact.createElement("TextLabel", {
        Position = UDim2.new(0.5, 0, 0, 25),
        AnchorPoint = Vector2.new(0.5, -0.5),
        Text = "Game Store",
        TextSize = 24, -- Increase the font size here

    })

    for i, item in ipairs(items) do
        -- Calculate grid position
        local row = math.floor((i-1) / 3) -- Adjust the number 4 to your grid width
        local column = (i-1) % 3 -- Same here for grid width
        local x = xpad + column * 100 -- Adjust spacing and size
        local y = ypad + row * 150 -- Adjust spacing and size
        elements["Item" .. i] = Roact.createElement("TextButton", {
            Size = UDim2.new(0, 90, 0, 140), -- Item frame size
            Position = UDim2.new(0, x, 0, y),
            BackgroundColor3 = Color3.new(1, 1, 1), -- Background color of the item frame
            Text = "No Image"
        }, {
            Image = Roact.createElement("ImageLabel", {
                Size = UDim2.new(0, 80, 0, 80), -- Adjust image size
                Position = UDim2.new(0.5, -40, 0, 10), -- Center the image in the frame
				Image = ("rbxthumb://type=Asset&id=" .. item.imageAsset.robloxAssetId .. "&w=420&h=420"), -- Decal URL
                BackgroundTransparency = 1,
            }),
            Name = Roact.createElement("TextLabel", {
                Size = UDim2.new(0, 80, 0, 50), -- Adjust text size
                Position = UDim2.new(0.5, -40, 0, 100), -- Position below the image
                Text = item.name,
                BackgroundTransparency = 1,
                TextWrapped = true,
            })
        })
    end
    
    return Roact.createElement("Frame", {
        Size = UDim2.new(0, 400, 0, 600), -- Adjust to fit the grid size you want
        BackgroundColor3 = Color3.new(0.8, 0.8, 0.8), -- Background color of the grid
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
    }, elements)
end

return GamePassStore
