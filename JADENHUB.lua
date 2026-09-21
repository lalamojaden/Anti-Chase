-- JADENHUB [INSTANT TELEPORT HOLD + DRAGGABLE UI]
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Clean up existing JADENHUB if already running
if CoreGui:FindFirstChild("JADENHUB") then
    CoreGui.JADENHUB:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JADENHUB"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- LoadScreen Sound Effect
local LoadSound = Instance.new("Sound")
LoadSound.Name = "LoadSound"
LoadSound.SoundId = "rbxassetid://106806057419587"
LoadSound.Volume = 1
LoadSound.Parent = ScreenGui

-- Unmain Button (Grabbable)
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "UnmainButton"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.02, 0, 0.04, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleButton.Image = "rbxassetid://114467920615660"
ToggleButton.AutoButtonColor = false
ToggleButton.Active = true
ToggleButton.ZIndex = 100
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 255, 200)
ToggleStroke.Thickness = 2.5
ToggleStroke.Parent = ToggleButton

-- Dragging Logic para sa UnmainButton
local btnDragging, btnDragInput, btnDragStart, btnStartPos

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = ToggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                btnDragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        btnDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == btnDragInput and btnDragging then
        local delta = input.Position - btnDragStart
        ToggleButton.Position = UDim2.new(
            btnStartPos.X.Scale, 
            btnStartPos.X.Offset + delta.X, 
            btnStartPos.Y.Scale, 
            btnStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Main Hub Frame (Grabbable)
local MainFrame = Instance.new("ImageLabel")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 220)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.3
MainFrame.Image = "rbxassetid://114467920615660"
MainFrame.ImageTransparency = 0.4
MainFrame.ScaleType = Enum.ScaleType.Slice
MainFrame.SliceCenter = Rect.new(100, 100, 100, 100)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(138, 43, 226)
MainStroke.Thickness = 2.5
MainStroke.Parent = MainFrame

-- Top Title Bar
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TitleLabel.BackgroundTransparency = 0.4
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Text = "⚡ JADENHUB ⚡ | Tiktok: lalamojaden2"
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.ZIndex = 11
TitleLabel.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleLabel

-- Dragging Logic para sa MainFrame
local dragging, dragInput, dragStart, startPos

TitleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- 1. Instant Egg Hold Button
local EggButton = Instance.new("TextButton")
EggButton.Size = UDim2.new(0.9, 0, 0, 42)
EggButton.Position = UDim2.new(0.05, 0, 0, 55)
EggButton.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
EggButton.BackgroundTransparency = 0.3
EggButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EggButton.Text = "⚡ Instant Egg: [ OFF ]"
EggButton.TextSize = 15
EggButton.Font = Enum.Font.GothamBold
EggButton.AutoButtonColor = true
EggButton.Active = true
EggButton.ZIndex = 20
EggButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = EggButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(100, 100, 130)
ButtonStroke.Thickness = 2
ButtonStroke.Parent = EggButton

-- 2. Instant Teleport Button (Hinabol at ginawang Instant Teleport kapag pinindot/hinawakan)
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.9, 0, 0, 42)
TeleportButton.Position = UDim2.new(0.05, 0, 0, 105)
TeleportButton.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
TeleportButton.BackgroundTransparency = 0.3
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "⚡ Instant Teleport"
TeleportButton.TextSize = 15
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.AutoButtonColor = true
TeleportButton.Active = true
TeleportButton.ZIndex = 20
TeleportButton.Parent = MainFrame

local TeleportCorner = Instance.new("UICorner")
TeleportCorner.CornerRadius = UDim.new(0, 8)
TeleportCorner.Parent = TeleportButton

local TeleportStroke = Instance.new("UIStroke")
TeleportStroke.Color = Color3.fromRGB(0, 255, 120)
TeleportStroke.Thickness = 2
TeleportStroke.Parent = TeleportButton

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.9, 0, 0, 32)
StatusLabel.Position = UDim2.new(0.05, 0, 0, 155)
StatusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
StatusLabel.BackgroundTransparency = 0.4
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
StatusLabel.Text = "Status: Ready to use!"
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.ZIndex = 15
StatusLabel.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusLabel

-- Full Screen Black Screen
local LoadScreen = Instance.new("Frame")
LoadScreen.Name = "LoadScreen"
LoadScreen.Size = UDim2.new(2, 0, 2, 0)
LoadScreen.Position = UDim2.new(-0.5, 0, -0.5, 0)
LoadScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadScreen.BackgroundTransparency = 0
LoadScreen.BorderSizePixel = 0
LoadScreen.Visible = false
LoadScreen.ZIndex = 1
LoadScreen.Parent = ScreenGui

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 60)
LoadTitle.Position = UDim2.new(0, 0, 0.45, -30)
LoadTitle.BackgroundTransparency = 1
LoadTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
LoadTitle.Text = "JADENHUB ON TOP"
LoadTitle.TextSize = 32
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.ZIndex = 2
LoadTitle.Parent = LoadScreen

-- Neon Border Effect
task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 2) % 360
        MainStroke.Color = Color3.fromHSV(hue / 360, 0.8, 1)
        task.wait(0.1)
    end
end)

-- Variables & Logic
local fixedCFrame = CFrame.new(368.3, 70.3, -362.0)
local isTeleporting = false

local function executeInstantTeleport()
    if isTeleporting then return end
    isTeleporting = true
    
    StatusLabel.Text = "Status: Teleporting..."
    
    LoadScreen.ZIndex = 99999
    LoadTitle.ZIndex = 100000
    LoadScreen.Visible = true
    
    LoadSound:Play()
    
    for i = 1, 5 do
        local char = localPlayer.Character
        local rootPart = char and char:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Anchored = false
            rootPart.Velocity = Vector3.new(0, 0, 0)
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            rootPart.CFrame = fixedCFrame
        end
        if i < 5 then
            task.wait(0.05)
        end
    end
    
    task.delay(0.8, function()
        LoadScreen.Visible = false
        LoadScreen.ZIndex = 1
        StatusLabel.Text = "Status: Teleported successfully!"
        isTeleporting = false
    end)
end

-- 1. Instant Egg Hold Button Click
local originalHoldDurations = {}
local isInstantHoldActive = false
local eggConnection

EggButton.MouseButton1Click:Connect(function()
    isInstantHoldActive = not isInstantHoldActive
    if isInstantHoldActive then
        EggButton.Text = "⚡ Instant Egg: [ ON ]"
        EggButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonStroke.Color = Color3.fromRGB(0, 255, 150)
        TweenService:Create(EggButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 60, 35)}):Play()
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                if originalHoldDurations[obj] == nil then
                    originalHoldDurations[obj] = obj.HoldDuration
                end
                obj.HoldDuration = 0
            end
        end
        
        eggConnection = workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                task.wait(0.05)
                if originalHoldDurations[obj] == nil then
                    originalHoldDurations[obj] = obj.HoldDuration
                end
                obj.HoldDuration = 0
            end
        end)
    else
        EggButton.Text = "⚡ Instant Egg: [ OFF ]"
        EggButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonStroke.Color = Color3.fromRGB(100, 100, 130)
        TweenService:Create(EggButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 38)}):Play()
        
        if eggConnection then
            eggConnection:Disconnect()
            eggConnection = nil
        end
        
        for obj, originalDuration in pairs(originalHoldDurations) do
            if obj and obj.Parent then
                obj.HoldDuration = originalDuration
            end
        end
        table.clear(originalHoldDurations)
    end
end)

-- 2. Instant Teleport Button Click (Gagana agad tuwing pipindutin mo)
TeleportButton.MouseButton1Click:Connect(function()
    executeInstantTeleport()
end)

-- Toggle Main UI Visibility via Unmain Button
local isOpen = true
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end)
