local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local existing = player:WaitForChild("PlayerGui"):FindFirstChild("AnimationInspectorUI")
if existing then existing:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "AnimationInspectorUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.25, 0, 0.3, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 3)
frameCorner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 1.5
stroke.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 80)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 30))
}
gradient.Rotation = 90
gradient.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0.2, 0)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Maslluxy's AnimGetter"
title.Font = Enum.Font.Arcade
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0.1, 0)
subtitle.Position = UDim2.new(0, 10, 0.18, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "placeholder text for future"
subtitle.Font = Enum.Font.Arcade
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
subtitle.Parent = frame

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
outputLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
outputLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
outputLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
outputLabel.Text = "Please press \"Get\" to get started..."
outputLabel.Font = Enum.Font.Arcade
outputLabel.TextSize = 14
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = frame

local labelCorner = Instance.new("UICorner")
labelCorner.CornerRadius = UDim.new(0, 3)
labelCorner.Parent = outputLabel

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.25, 0, 0.15, 0)
copyBtn.Position = UDim2.new(0.7, 0, 0.55, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 130)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.Arcade
copyBtn.TextSize = 14
copyBtn.Text = "Copy"
copyBtn.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 3)
copyCorner.Parent = copyBtn

local getBtn = Instance.new("TextButton")
getBtn.Size = UDim2.new(0.6, 0, 0.2, 0)
getBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
getBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getBtn.Font = Enum.Font.Arcade
getBtn.TextSize = 18
getBtn.Text = "Get"
getBtn.Parent = frame

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 10)
getCorner.Parent = getBtn

local canCheck = true
local placeholder = "Please press \"Get\" to get started..."

getBtn.MouseButton1Click:Connect(function()
	if not canCheck then return end
	local tracks = humanoid:GetPlayingAnimationTracks()
	for _, t in ipairs(tracks) do
		if t.IsPlaying then
			outputLabel.Text = t.Animation.AnimationId or "No ID"
			outputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			return
		end
	end
	outputLabel.Text = "No animation playing"
	outputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

copyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(outputLabel.Text)
		outputLabel.Text = "Successfully copied"
		outputLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
		canCheck = false
		task.delay(0.5, function()
			outputLabel.Text = placeholder
			outputLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
			canCheck = true
		end)
	end
end)

outputLabel.Text = placeholder
outputLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
