hookfunction(getsenv(game.Players.LocalPlayer.PlayerScripts.Scripts.Game["Egg Opening Frontend"]).PlayEggAnimation, function()
    return
end)

-- Create a ScreenGui for the UI
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create UI elements
local frame = Instance.new("Frame")
frame.Name = "EggOpenerUI"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32) -- Dark background color
frame.BorderSizePixel = 0
frame.Parent = gui

local eggNameLabel = Instance.new("TextLabel")
eggNameLabel.Size = UDim2.new(1, 0, 0.2, 0)
eggNameLabel.Position = UDim2.new(0, 0, 0, 0)
eggNameLabel.Text = "Egg Name:"
eggNameLabel.TextColor3 = Color3.new(1, 1, 1) -- White text color
eggNameLabel.Font = Enum.Font.GothamSemibold
eggNameLabel.TextSize = 18
eggNameLabel.BackgroundTransparency = 1
eggNameLabel.Parent = frame

local eggNameTextBox = Instance.new("TextBox")
eggNameTextBox.Size = UDim2.new(1, -20, 0, 30)
eggNameTextBox.Position = UDim2.new(0, 10, 0.2, 0)
eggNameTextBox.PlaceholderText = "Enter egg name"
eggNameTextBox.TextColor3 = Color3.new(1, 1, 1)
eggNameTextBox.Font = Enum.Font.Gotham
eggNameTextBox.TextSize = 18
eggNameTextBox.BackgroundColor3 = Color3.fromRGB(51, 51, 51) -- Darker text box color
eggNameTextBox.BorderSizePixel = 0
eggNameTextBox.Parent = frame

local eggCountLabel = Instance.new("TextLabel")
eggCountLabel.Size = UDim2.new(1, 0, 0.2, 0)
eggCountLabel.Position = UDim2.new(0, 0, 0.45, 0)
eggCountLabel.Text = "Egg Count:"
eggCountLabel.TextColor3 = Color3.new(1, 1, 1)
eggCountLabel.Font = Enum.Font.GothamSemibold
eggCountLabel.TextSize = 18
eggCountLabel.BackgroundTransparency = 1
eggCountLabel.Parent = frame

local eggCountTextBox = Instance.new("TextBox")
eggCountTextBox.Size = UDim2.new(1, -20, 0, 30)
eggCountTextBox.Position = UDim2.new(0, 10, 0.65, 0)
eggCountTextBox.PlaceholderText = "Enter egg count"
eggCountTextBox.TextColor3 = Color3.new(1, 1, 1)
eggCountTextBox.Font = Enum.Font.Gotham
eggCountTextBox.TextSize = 18
eggCountTextBox.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
eggCountTextBox.BorderSizePixel = 0
eggCountTextBox.Parent = frame

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(1, -20, 0, 40)
startButton.Position = UDim2.new(0, 10, 0.85, 0)
startButton.Text = "Start"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Font = Enum.Font.GothamSemibold
startButton.TextSize = 18
startButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255) -- Blue button color
startButton.BorderSizePixel = 0
startButton.Parent = frame

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.BackgroundColor3 = Color3.fromRGB(255, 69, 69) -- Red close button color
closeButton.BorderSizePixel = 0
closeButton.Parent = frame

-- Function to start the loop
local function startLoop()
    _G.loop = true
    local eggName = eggNameTextBox.Text
    local eggCount = tonumber(eggCountTextBox.Text) or 0
    local args = { [1] = eggName, [2] = eggCount }

    while _G.loop do
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Eggs_RequestPurchase"):InvokeServer(unpack(args))
        task.wait(_G.loopDelay)
    end
end

-- Event handler for the start button
startButton.MouseButton1Click:Connect(startLoop)

-- Event handler for the close button
closeButton.MouseButton1Click:Connect(function()
    gui:FindFirstChild("EggOpenerUI"):Destroy()
end)

-- Make the UI draggable
local dragging
local dragInput
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
