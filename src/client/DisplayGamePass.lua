local GamePassStore = require(game.ReplicatedStorage:WaitForChild("Shared").GamePassStore) -- Adjust the path to your Button module
local Roact = require(game.ReplicatedStorage:WaitForChild("Roact"))
local StorePanel = Roact.PureComponent:extend('Game')

function StorePanel:init(props)
	self.state = {
		onClose = props.onClose or function() end
	}
end

function StorePanel:render(props)
	return Roact.createElement(GamePassStore, {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0, 200, 0, 150),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		onClose = self.state.onClose
	})
end


return function(props)
	local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

	local Roact = require(game.ReplicatedStorage.Roact)

	local handle

	local function stop()
		Roact.unmount(handle)
	end

	local app = Roact.createElement("ScreenGui", nil, {
		Game = Roact.createElement(StorePanel,
		{
			Position = UDim2.new(0.5, 0, 0.5, 0),
			backgroundColor3 = Color3.fromRGB(216, 142, 134),
			Size = UDim2.new(0, 400, 0, 300),
			onClose = stop
		})
	})

	handle = Roact.mount(app, PlayerGui)

	return stop
end