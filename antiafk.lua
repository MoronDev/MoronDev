wait(0.5)

local gui = Instance.new("ScreenGui")
local mainFrame = Instance.new("TextLabel")
local statusFrame = Instance.new("Frame")
local creditsLabel = Instance.new("TextLabel")
local statusLabel = Instance.new("TextLabel")

gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
mainFrame.Draggable = true
mainFrame.Position = UDim2.new(0.698610067, 0, 0.098096624, 0)
mainFrame.Size = UDim2.new(0, 370, 0, 52)
mainFrame.Font = Enum.Font.SourceSansSemibold
mainFrame.Text = "Anti Afk"
mainFrame.TextColor3 = Color3.new(0, 1, 1)
mainFrame.TextSize = 22

statusFrame.Parent = mainFrame
statusFrame.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
statusFrame.Position = UDim2.new(0, 0, 1.0192306, 0)
statusFrame.Size = UDim2.new(0, 370, 0, 107)

creditsLabel.Parent = statusFrame
creditsLabel.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
creditsLabel.Position = UDim2.new(0, 0, 0.800455689, 0)
creditsLabel.Size = UDim2.new(0, 370, 0, 21)
creditsLabel.Font = Enum.Font.Arial
creditsLabel.Text = "Made by luca#5432"
creditsLabel.TextColor3 = Color3.new(0, 1, 1)
creditsLabel.TextSize = 20

statusLabel.Parent = statusFrame
statusLabel.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
statusLabel.Position = UDim2.new(0, 0, 0.158377, 0)
statusLabel.Size = UDim2.new(0, 370, 0, 44)
statusLabel.Font = Enum.Font.ArialBold
statusLabel.Text = "Status: Active"
statusLabel.TextColor3 = Color3.new(0, 1, 1)
statusLabel.TextSize = 20

local virtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
    statusLabel.Text = "God saved you"
    wait(2)
    statusLabel.Text = "Status: Active"
end)
