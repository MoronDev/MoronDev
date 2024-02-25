_G.loop = true
_G.loopDelay = 1 -- in seconds

print("Hidden Presents By Neezie")

while _G.loop do
local function round(number)
    return string.format("%.6f", number)
end

for _, present in pairs(game:GetService("Workspace").__THINGS.HiddenPresents:GetChildren()) do
    if present.Name ~= "Highlight" then
        local args = {
            [1] = "ID_" .. round(present.Position.X) .. "_" .. round(present.Position.Y) .. "_" .. round(present.Position.Z)
        }

        game:GetService("ReplicatedStorage").Network:FindFirstChild("Hidden Presents: Found"):InvokeServer(unpack(args))
        present:Destroy()
        task.wait()
    end
end

game:GetService("Workspace").__THINGS.HiddenPresents.ChildAdded:Connect(function(present)
    if present.Name ~= "Highlight" then
        local args = {
            [1] = "ID_" .. round(present.Position.X) .. "_" .. round(present.Position.Y) .. "_" .. round(present.Position.Z)
        }

        game:GetService("ReplicatedStorage").Network:FindFirstChild("Hidden Presents: Found"):InvokeServer(unpack(args))
        present:Destroy()
        task.wait()
    end
end)
    task.wait(loopDelay)
end
