local Roact = require(script.Parent.Parent.Roact)
local Button = require(script.Parent.Button) -- Adjust the path as necessary

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateTextEvent = ReplicatedStorage:WaitForChild("EventUpdate")
local UpdateFunction = ReplicatedStorage:WaitForChild("FetchEventsFunction")

local EventFrame = Roact.Component:extend("Frame")

function EventFrame:init(props)
	self:setState({
		text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Risus nec feugiat in fermentum posuere urna nec tincidunt. Nulla at volutpat diam ut. Dolor sit amet consectetur adipiscing elit ut aliquam purus. Tortor condimentum lacinia quis vel. Purus sit amet luctus venenatis lectus magna. Aliquam sem fringilla ut morbi tincidunt augue interdum velit. Consequat semper viverra nam libero justo laoreet sit amet. Scelerisque mauris pellentesque pulvinar pellentesque habitant. Consectetur adipiscing elit duis tristique sollicitudin. Sit amet cursus sit amet.",
        assetId = "",
		onClose = props.onClose or function() end
    })
end

function EventFrame:onTextUpdate(reply)
    if(self.state ~= nil) then
		self.state.assetId = reply[1].imageAsset.robloxAssetId
		self.state.text = reply[1].storyText
	end
end

function EventFrame:didMount()
	-- subscribe to server event updates
	self.textUpdateConnection = UpdateTextEvent.OnClientEvent:Connect(self.onTextUpdate)
	-- Query data from server
	local reply = UpdateFunction:InvokeServer()

	if self.state == nil then
		self.state = {}
	end

	self:setState({
		text = reply[1].storyText,
        assetId = reply[1].imageAsset.robloxAssetId,
		onClose = self.state.onClose or function() end
	})
end

function EventFrame:willUnmount()
	if self.textUpdateConnection then
		self.textUpdateConnection:Disconnect()
	end
end

function EventFrame:render()
	local handleButtonClick = function()
		print("Button clicked!")
		-- Your click handling logic here
	end

	if self.state == nil then
		print "nil state!"
	end
	
	return Roact.createElement("Frame", {
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(49, 26, 26),
		Size = UDim2.new(0, 400, 0, 200),
		AnchorPoint = Vector2.new(0.5, 0.5),
	}, {
		Description = Roact.createElement("TextLabel", {
			Text = self.state.text,
			Position = UDim2.fromScale(0.6, 0.1),
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(.75, 0.2, 1, -100), -- Leave room for buttons
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
		}),
        Roact.createElement("Frame", {
            Size = UDim2.new(0.3, 0, 0.3, 0), -- Size of the ImageLabel
            Position = UDim2.new(0, 20, 0.5, -25), -- Position of the ImageLabel
            BackgroundTransparency = 1, -- Optionally make the frame background transparent
            AnchorPoint = Vector2.new(0, 0.5), -- AnchorPoint to align the image
        }, {
            DecalImage = Roact.createElement("ImageLabel", {
                Size = UDim2.new(1, 0, 1, 0), -- Fill Size
				Image = ("rbxthumb://type=Asset&id=" .. self.state.assetId .. "&w=420&h=420"), -- Replace with your decal's asset id
                BackgroundTransparency = 1, -- Hide the background
            }),
            AspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1, -- Ensures the ImageLabel remains square
            }),
        }),
		PrevButton = Roact.createElement(Button, {
			text = "Previous",
			onClick = handleButtonClick,
			size = UDim2.new(0, 100, 0, 50),
			backgroundColor = Color3.fromRGB(20, 17, 17),
			position = UDim2.fromScale(0.2, 0.8),
		}),
		NextButton = Roact.createElement(Button, {
			text = "Next",
			onClick = handleButtonClick,
			size = UDim2.new(0, 100, 0, 50),
			backgroundColor = Color3.fromRGB(0, 255, 0),
			position = UDim2.fromScale(0.8, 0.8),
		}),
		CloseButton = Roact.createElement("TextButton", {
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
	})
end

return EventFrame
