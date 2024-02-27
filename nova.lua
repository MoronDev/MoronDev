local ReplicatedStorage = game:GetService("ReplicatedStorage") :: ReplicatedStorage & {Library: ModuleScript; Network: ModuleScript & {Eggs_RequestPurchase: RemoteFunction}}
local Players = game:GetService("Players")
local Player = Players.LocalPlayer :: Player & {PlayerScripts: Folder & {Scripts: Folder & {Game: Folder & {["Egg Opening Frontend"]: LocalScript}}}}
local Library: {Save: {Get: () -> {MaximumAvailableEgg: number; EggHatchCount: number;}}}  = require(ReplicatedStorage.Library)
local EggsUtilMod: {GetIdByNumber: () -> number} = require(ReplicatedStorage.Library.Util.EggsUtil)
local PlayerInfo = Library.Save.Get()
local EggAnim : {PlayEggAnimation: () -> nil} = getsenv(Player.PlayerScripts.Scripts.Game["Egg Opening Frontend"])

hookfunction(EggAnim.PlayEggAnimation, function()
    return
end)

while task.wait(0.1) do
    local BestEggName = EggsUtilMod.GetIdByNumber(113)
    local EggHatchCount = PlayerInfo.EggHatchCount

    repeat
        local success: boolean = ReplicatedStorage.Network.Eggs_RequestPurchase:InvokeServer(BestEggName, EggHatchCount)
    until success       
end
