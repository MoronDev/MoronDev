local Webhook = "https://discord.com/api/webhooks/1214353053805977710/KsjARk-ci7xSJD0_q2GVzjzOlt7oenIhITM0YNFgo0RN7XYQMIGgl1OglAxtj31GaKY3"
local Content = "<@!1202699896235360386>"

repeat wait() until game:IsLoaded()

task.spawn(function()
    pcall(function()
        game:GetService("CoreGui").DescendantAdded:Connect(function(child)
            if child.Name == "ErrorPrompt" then
                local GrabError = child:FindFirstChild("ErrorMessage", true)
                repeat wait() until GrabError.Text ~= "Label"
                local Reason = GrabError.Text

                local url = Webhook
                local data = {
                    ["content"] = Content,
                    ["embeds"] = {
                        {
                            ["title"] = "*Kick Alert**",
                            ["description"] = "**" .. game.Players.LocalPlayer.Name .. "** got kicked from the game! ```Ping ▶ " .. game.Players.LocalPlayer:GetNetworkPing() * (1000) .. "ms``` ```Kick Reason ▶ " .. Reason .. "```",

                            ["url"] = "https://pornhub.com",
                            ["type"] = "rich",
                            ["color"] = tonumber(0x7269da),
                            ["image"] = {
                                ["url"] = "https://media.discordapp.net/attachments/1139104594899779655/1144166976655196191/family-guy-animated-sitcom.gif"
                            }
                        }
                    }
                }
                local newdata = game:GetService("HttpService"):JSONEncode(data)

                local headers = {
                    ["content-type"] = "application/json"
                }
                request = http_request or request or HttpPost or syn.request
                local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }

                if Reason:find("kick") or Reason:find("You") or Reason:find("conn") or Reason:find("rejoin") then
                    wait(1)
                    request(abcdef)
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/fdvll/pet-simulator-99/main/serverhop.lua"))()
                end
            end
        end)
    end)
end)

print("Webhook Enabled")
