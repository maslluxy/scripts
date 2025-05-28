local Players = game:GetService("Players")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local gui = player:WaitForChild("PlayerGui"):FindFirstChild("MaslluxyAnimGetter")
if gui then gui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MaslluxyAnimGetter"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.28, 0, 0.32, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 5)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 1.5
stroke.Parent = frame

local dropShadow = Instance.new("ImageLabel")
dropShadow.Name = "DropShadow"
dropShadow.Parent = frame
dropShadow.BackgroundTransparency = 1
dropShadow.Size = UDim2.new(1, 18, 1, 18)
dropShadow.Position = UDim2.new(0, -9, 0, -9)
dropShadow.ZIndex = 0
dropShadow.Image = "rbxassetid://1316045217"
dropShadow.ImageColor3 = Color3.fromRGB(20, 20, 40)
dropShadow.ImageTransparency = 0.7

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -28, 0.14, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Maslluxy's Anim Getter"
title.Font = Enum.Font.Arcade
title.TextScaled = false
title.TextSize = 20  -- slightly smaller than before
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 1
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0.06, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.Arcade
closeBtn.TextScaled = false
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
closeBtn.ZIndex = 1
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
	for i = 0, 1, 0.05 do
		frame.BackgroundTransparency = i
		title.TextTransparency = i
		closeBtn.TextTransparency = i
		task.wait(0.02)
	end
	screenGui:Destroy()
end)

local output = Instance.new("TextLabel")
output.Size = UDim2.new(0.9, 0, 0.14, 0)
output.Position = UDim2.new(0.05, 0, 0.26, 0)
output.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
output.TextColor3 = Color3.fromRGB(160, 160, 160)
output.Text = "Press 'Get'"
output.Font = Enum.Font.Arcade
output.TextScaled = false
output.TextSize = 17  -- tiny bit smaller
output.TextXAlignment = Enum.TextXAlignment.Left
output.ZIndex = 1
output.Parent = frame

Instance.new("UICorner", output).CornerRadius = UDim.new(0, 6)

local getBtn = Instance.new("TextButton")
getBtn.Size = UDim2.new(0.4, 0, 0.14, 0)
getBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
getBtn.Text = "Get"
getBtn.Font = Enum.Font.Arcade
getBtn.TextScaled = false
getBtn.TextSize = 18
getBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
getBtn.ZIndex = 1
getBtn.Parent = frame

Instance.new("UICorner", getBtn).CornerRadius = UDim.new(0, 6)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.4, 0, 0.14, 0)
copyBtn.Position = UDim2.new(0.55, 0, 0.52, 0)
copyBtn.Text = "Copy"
copyBtn.Font = Enum.Font.Arcade
copyBtn.TextScaled = false
copyBtn.TextSize = 18
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 130)
copyBtn.ZIndex = 1
copyBtn.Parent = frame

Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(0.6, 0, 0.14, 0)
playBtn.Position = UDim2.new(0.2, 0, 0.73, 0)
playBtn.Text = "Play"
playBtn.Font = Enum.Font.Arcade
playBtn.TextScaled = false
playBtn.TextSize = 19
playBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 60)
playBtn.TextColor3 = Color3.new(1, 1, 1)
playBtn.ZIndex = 1
playBtn.Parent = frame

Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0, 6)

local placeholderText = output.Text
local ready = true

local currentAnimId = nil
local currentTrack = nil
local isLooping = false

local function stopCurrentAnim()
	if currentTrack then
		currentTrack:Stop()
		currentTrack:Destroy()
		currentTrack = nil
	end
	playBtn.Text = "Play"
	playBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 60)
	playBtn.TextColor3 = Color3.new(1, 1, 1)
end

getBtn.MouseButton1Click:Connect(function()
	if not ready then return end
	local foundNew = false
	for _, animTrack in ipairs(humanoid:GetPlayingAnimationTracks()) do
		if animTrack.IsPlaying and animTrack.Animation and animTrack.Animation.AnimationId ~= currentAnimId then
			currentAnimId = animTrack.Animation.AnimationId
			isLooping = animTrack.Looped
			output.Text = currentAnimId
			output.TextColor3 = Color3.new(1, 1, 1)
			stopCurrentAnim()
			currentTrack = nil
			foundNew = true
			break
		end
	end
	if not foundNew then
		output.Text = "No new animation"
		output.TextColor3 = Color3.fromRGB(160, 160, 160)
	end
end)

copyBtn.MouseButton1Click:Connect(function()
	if setclipboard then setclipboard(output.Text) end
	output.Text = "Copied!"
	output.TextColor3 = Color3.new(0, 1, 0)
	ready = false
	task.delay(1, function()
		output.Text = currentAnimId or placeholderText
		output.TextColor3 = Color3.new(1, 1, 1)
		ready = true
	end)
end)

playBtn.MouseButton1Click:Connect(function()
	if not currentAnimId then return end
	if currentTrack and currentTrack.IsPlaying then
		stopCurrentAnim()
		return
	end

	local anim = Instance.new("Animation")
	anim.AnimationId = currentAnimId
	local newTrack = humanoid:LoadAnimation(anim)
	currentTrack = newTrack

	currentTrack:Play()
	playBtn.Text = "Stop"
	playBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	playBtn.TextColor3 = Color3.new(1, 1, 1)

	if not isLooping then
		task.spawn(function()
			currentTrack.Stopped:Wait()
			if currentTrack == newTrack then
				stopCurrentAnim()
			end
		end)
	end
end)
