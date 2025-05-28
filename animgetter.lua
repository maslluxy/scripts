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
frame.Size = UDim2.new(0.35, 0, 0.4, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 80)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 30))
}
gradient.Rotation = 90
gradient.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0.2, 0)
title.Position = UDim2.new(0, 10, 0, 10)
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

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.65, 0, 0.15, 0)
textBox.Position = UDim2.new(0.05, 0, 0.35, 0)
textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Please press \"Get\" to get started..."
textBox.Font = Enum.Font.Arcade
textBox.TextSize = 14
textBox.ClearTextOnFocus = false
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = textBox

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.25, 0, 0.15, 0)
copyBtn.Position = UDim2.new(0.7, 0, 0.35, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 130)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.Arcade
copyBtn.TextSize = 14
copyBtn.Text = "Copy"
copyBtn.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 8)
copyCorner.Parent = copyBtn

local getBtn = Instance.new("TextButton")
getBtn.Size = UDim2.new(0.9, 0, 0.2, 0)
getBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
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

getBtn.MouseButton1Click:Connect(function()
	if not canCheck then return end
	local tracks = humanoid:GetPlayingAnimationTracks()
	for _, t in ipairs(tracks) do
		if t.IsPlaying then
			textBox.Text = (#t.Name > 0 and t.Name) or t.Animation.AnimationId
			return
		end
	end
	textBox.Text = "No animation playing"
end)

copyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(textBox.Text)
		textBox.Text = "Successfully copied"
		canCheck = false
		task.delay(0.5, function()
			textBox.Text = "Please press \"Get\" to get started..."
			canCheck = true
		end)
	end
end)
