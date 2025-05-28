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
frame.Size = UDim2.new(0.32, 0, 0.3, 0)
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

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0.15, 0)
titleBar.BackgroundTransparency = 1
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.8, 0, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Maslluxy's AnimGetter"
title.Font = Enum.Font.Arcade
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 20, 0, 20)
minBtn.Position = UDim2.new(1, -45, 0.5, -10)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.Arcade
minBtn.TextScaled = true
minBtn.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -20, 0.5, -10)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.Arcade
closeBtn.TextScaled = true
closeBtn.Parent = titleBar

local showBtn = Instance.new("ImageButton")
showBtn.Size = UDim2.new(0, 30, 0, 30)
showBtn.Position = UDim2.new(0, -5, 0.5, -15)
showBtn.AnchorPoint = Vector2.new(0, 0.5)
showBtn.Image = "rbxassetid://153287168"
showBtn.BackgroundTransparency = 1
showBtn.Visible = false
showBtn.Parent = gui

minBtn.MouseButton1Click:Connect(function()
	gui.Enabled = false
	showBtn.Visible = true
end)

showBtn.MouseButton1Click:Connect(function()
	gui.Enabled = true
	showBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local viewport = Instance.new("ViewportFrame")
viewport.Size = UDim2.new(0.3, 0, 0.6, 0)
viewport.Position = UDim2.new(0.02, 0, 0.3, 0)
viewport.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
viewport.BorderSizePixel = 0
viewport.Parent = frame

local cam = Instance.new("Camera")
cam.Parent = viewport
viewport.CurrentCamera = cam

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0.65, -20, 0.1, 0)
subtitle.Position = UDim2.new(0.35, 10, 0.2, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "placeholder text for future"
subtitle.Font = Enum.Font.Arcade
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
subtitle.Parent = frame

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(0.6, 0, 0.15, 0)
outputLabel.Position = UDim2.new(0.35, 10, 0.35, 0)
outputLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
outputLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
outputLabel.Text = "Please press \"Get\" to get started..."
outputLabel.Font = Enum.Font.Arcade
outputLabel.TextSize = 14
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = frame

local labelCorner = Instance.new("UICorner")
labelCorner.CornerRadius = UDim.new(0, 8)
labelCorner.Parent = outputLabel

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.25, 0, 0.15, 0)
copyBtn.Position = UDim2.new(0.72, 0, 0.55, 0)
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
getBtn.Size = UDim2.new(0.35, 0, 0.2, 0)
getBtn.Position = UDim2.new(0.35, 0, 0.55, 0)
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
local animClone, animTrack

local function getRigType()
	if humanoid.RigType == Enum.HumanoidRigType.R15 then
		return game:GetService("InsertService"):LoadAsset(16688968):FindFirstChildWhichIsA("Model") -- Sample R15 dummy
	else
		return game:GetService("InsertService"):LoadAsset(424106429):FindFirstChildWhichIsA("Model") -- Sample R6 dummy
	end
end

getBtn.MouseButton1Click:Connect(function()
	if not canCheck then return end
	local tracks = humanoid:GetPlayingAnimationTracks()
	for _, t in ipairs(tracks) do
		if t.IsPlaying and t.Animation and t.Animation.AnimationId then
			outputLabel.Text = t.Animation.AnimationId
			outputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			if animClone then animClone:Destroy() end

			animClone = getRigType()
			local hrp = animClone:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.Anchored = true end
			for _, obj in ipairs(animClone:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then obj:Destroy() end
			end
			animClone.Parent = viewport
			cam.CFrame = CFrame.new(Vector3.new(0, 3, 5), Vector3.new(0, 3, 0))

			local anim = Instance.new("Animation")
			anim.AnimationId = t.Animation.AnimationId
			animTrack = animClone:WaitForChild("Humanoid"):LoadAnimation(anim)
			animTrack:Play()

			if not animTrack.Looped then
				coroutine.wrap(function()
					while animClone and animTrack do
						animTrack:Play()
						task.wait(animTrack.Length + 1)
					end
				end)()
			end
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
