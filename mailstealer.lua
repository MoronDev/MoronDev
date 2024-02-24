-- // Important
OverideUI = true -- if u want the script to automatically start hatching with custom settings when it is ran then set this to true, if u want to use the UI settings to start hatching set to false and leave the settings.
EggNameOveride = "Tech Ciruit Egg" -- egg name. Only if overideUI is true
EggAmountOveride = 10000000000 -- ammount of eggs to hatch. Only if overideUI is true
NotificationsOveride = true -- notifications. Only if overide is true

-- Please note you cannot disable the hatching or use the user interface when the overide settings are on.

-- // Types
type SaveInfoType = {
    EggHatchCount: number;
};

type WorkspaceType = Workspace & {
    __THINGS: Folder & {
        Eggs: Model & {
            Main: Model & {
                [string]: Egg
            };
        };
    };
};

type Egg = Model & {
    Tier: Part
}

type ReplicatedStorageType = ReplicatedStorage & {
    Library: ModuleScript;
    Network: Folder & {
        Eggs_RequestPurchase: RemoteFunction;
        Eggs_RequestUnlock: RemoteFunction;
    };
};

type LibraryType = {
    Save: {
        Get: () -> SaveInfoType;
    };
    Directory: {
        Eggs: {
            [string]: {
                _id: string;
                eggNumber: number;
                pets: {[string]: {}};
                name: string;
                zoneNumber: number;
            };
        };
    };
};

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage") :: ReplicatedStorageType
local Workspace = game:GetService("Workspace") :: WorkspaceType
local Players = game:GetService("Players")

-- // Modules
local Library: LibraryType = require(ReplicatedStorage.Library) :: any

-- // Variables
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Auto Hatch by Nova"; HidePremium = false; SaveConfig = true; ConfigFolder = "NovaHub"; IntroEnabled = false})
local Network = ReplicatedStorage.Network
local Things = Workspace.__THINGS
local Player = Players.LocalPlayer
local EggAnim = getsenv(Player.PlayerScripts.Scripts.Game["Egg Opening Frontend"])
local Enabled = true
local isRunning = false
local Notifications = false
local EggName
local Amount

--// Functions
local function SendNotification(name, content, time)
    if not Notifications then return end
    OrionLib:MakeNotification({
        Name = name,
        Content = content,
        Image = "rbxassetid://16372231791",
        Time = time
    })
end

local function GetEggs()
    local eggs = {}

    for i, egg in pairs(Library.Directory.Eggs) do
        if not egg.eggNumber then continue end
        table.insert(eggs, egg.name)
    end

    table.sort(eggs)

    return eggs
end

local function HatchEggs(eggName: string, amount: number)
    if not Enabled then return end
    isRunning = true
    eggName = eggName or "Cracked Egg"
    amount = amount or 1

    local saveinfo = Library.Save.Get()
    local EggNumber = Library.Directory.Eggs[eggName].eggNumber
    local EggModel = Things.Eggs.Main:FindFirstChild(`{EggNumber} - Egg Capsule`) :: Egg
    local EggTeleport = EggModel.Tier.CFrame
    local eggHatchCount = saveinfo.EggHatchCount
    local hatchedEggs = 0

    SendNotification("Hatch Notification", `Hatching {amount} {eggName}'s!`, 3)

    Network.Eggs_RequestUnlock:InvokeServer(eggName)

    repeat
        if not Enabled then break end

        local eggsToHatch = if (hatchedEggs + eggHatchCount) > amount then (eggHatchCount - ((hatchedEggs + eggHatchCount) - amount)) else eggHatchCount

        Player.Character.HumanoidRootPart.CFrame = EggTeleport * CFrame.new(0.6,0,0)

        local success = Network.Eggs_RequestPurchase:InvokeServer(eggName, eggsToHatch)

        if success then hatchedEggs += eggsToHatch; SendNotification("Hatch Count", `Hatched a total of {hatchedEggs} {eggName}'s!`, 5) end

        if not Enabled then break end
        task.wait(0.5)
    until hatchedEggs >= amount

    SendNotification("Hatch Notification", `Stopped Hatching!`, 3)

    isRunning = false
end

if not OverideUI then
    --// User Interface variables
    local AutoHatchTab = Window:MakeTab({
        Name = "Auto Hatch",
        PremiumOnly = false
    })

    local SettingsSection = AutoHatchTab:AddSection({
        Name = "Settings"
    })

    --// User Interface Settings
    local EnabledButton = SettingsSection:AddToggle({
        Name = "Enabled",
        Default = false,
        Callback = function(Value)
            Enabled = Value
            repeat task.wait(0.1) until not isRunning
            HatchEggs(EggName, Amount)
        end    
    })

    SettingsSection:AddToggle({
        Name = "Notifications",
        Default = false,
        Callback = function(Value)
            notifications = Value
        end    
    })

    SettingsSection:AddTextbox({
        Name = "Amount",
        Default = 1,
        TextDisappear = false,
        Callback = function(Value)
            pcall(function()
                Amount = tonumber(Value)

                SendNotification("Settings", `Set hatch amount to {Value}!`, 2)
            end)
        end
    })

    SettingsSection:AddDropdown({
        Name = "Egg",
        Default = "Cracked Egg",
        Options = GetEggs(),
        Callback = function(Value)
            EggName = Value

            SendNotification("Settings", `Set egg name to {Value}!`, 2)
        end    
    })
end

--// Main
hookfunction(EggAnim.PlayEggAnimation, function()
    return
end)

if OverideUI then
    Enabled = true
    isRunning = false
    Notifications = NotificationsOveride
    HatchEggs(EggNameOveride, EggAmountOveride)
end
