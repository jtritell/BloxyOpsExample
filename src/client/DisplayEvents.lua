
local EventFrame = require(game.ReplicatedStorage:WaitForChild("Shared").EventFrame)
local Roact = require(game.ReplicatedStorage:WaitForChild("Roact"))
local EventPanel = Roact.PureComponent:extend('Game')

function EventPanel:init(props)
	Position = UDim2.new(0.5, 0, 0.5, 0)
	self.state = {
		onClose = props.onClose or function() end
	}
end

function EventPanel:render(props)
	local children = {}

	Position = UDim2.new(0.5, 0, 0.5, 0)

	return Roact.createElement(EventFrame, {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0, 400, 0, 300),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		onClose = self.state.onClose
	})
end

return function()
	local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

	local Roact = require(game.ReplicatedStorage.Roact)

	local handle

	local function stop()
		Roact.unmount(handle)
	end

	local app = Roact.createElement("ScreenGui", nil, {
		Game = Roact.createElement(EventPanel,
		{
			Position = UDim2.new(0.5, 0, 0.5, 0),
			backgroundColor3 = Color3.fromRGB(216, 142, 134),
			Size = UDim2.new(0, 200, 0, 300),
			onClose = stop
		})
	})

	handle = Roact.mount(app, PlayerGui)

	return stop
end