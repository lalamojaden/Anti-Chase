-- Create the full-screen black loading GUI programmatically
local players = game:GetService("Players")
local player = players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent duplicates if already running
if playerGui:FindFirstChild("InfiniteLoadGui") then
	playerGui.InfiniteLoadGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InfiniteLoadGui"
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BorderSizePixel = 0
background.Parent = screenGui

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(0, 400, 0, 50)
statusText.AnchorPoint = Vector2.new(0.5, 0.5)
statusText.Position = UDim2.new(0.5, 0, 0.5, 0)
statusText.BackgroundTransparency = 1
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.TextSize = 24
statusText.Font = Enum.Font.SourceSansBold
statusText.Text = "Updating Script..."
statusText.Parent = background

-- Optional: Animate dots for the loading effect
task.spawn(function()
	local dots = ""
	while true do
		dots = dots .. "."
		if #dots > 3 then
			dots = "."
		end
		statusText.Text = "Updating Script" .. dots
		task.wait(0.5)
	end
end)
