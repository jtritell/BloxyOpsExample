local Roact = require(game.ReplicatedStorage:WaitForChild("Roact"))

local function Button(props)
    local onClick = props.onClick or function() end
    local text = props.text or "Button"
    local size = props.size or UDim2.new(0, 100, 0, 50)
    local backgroundColor = props.backgroundColor or Color3.fromRGB(0, 150, 255)
    local position = props.position or UDim2.new()
    
    print(position)


    return Roact.createElement("TextButton", {
        Size = size,
        Text = text,
        BackgroundColor3 = backgroundColor,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSans,
        TextSize = 24,
        [Roact.Event.Activated] = onClick,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = position
    })
end

return Button