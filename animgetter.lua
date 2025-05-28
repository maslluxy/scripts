-- Animation Inspector GUI for Roblox
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Remove existing instance
local existing = player:WaitForChild("PlayerGui"):FindFirstChild("AnimationInspectorUI")
if existing then existing:Destroy() end

-- Screen GUI setup
local gui = Instance.new("ScreenGui")
gui.Name = "AnimationInspectorUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.36, 0, 0.48, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 6)
frameCorner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 1.5
stroke.Parent = frame

-- Gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 80)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 30))
}
gradient.Rotation = 90
gradient.Parent = frame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0.12, 0)
titleBar.BackgroundTransparency = 1
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Maslluxy's AnimGetter"
title.Font = Enum.Font.Arcade
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Minimize & close buttons
local function makeTitleBtn(text, posX, bgColor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 24, 0, 24)
    btn.Position = UDim2.new(1, posX, 0.5, -12)
    btn.Text = text
    btn.BackgroundColor3 = bgColor
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Arcade
    btn.TextScaled = true
    btn.Parent = titleBar
    return btn
end

local minBtn = makeTitleBtn("-", -60, Color3.fromRGB(70, 70, 90))
local closeBtn = makeTitleBtn("X", -28, Color3.fromRGB(100, 50, 50))

-- Show button when minimized
local showBtn = Instance.new("ImageButton")
showBtn.Size = UDim2.new(0, 32, 0, 32)
showBtn.Position = UDim2.new(0, 8, 0.5, -16)
showBtn.Image = "rbxassetid://153287168"
showBtn.BackgroundTransparency = 1
showBtn.Visible = false
showBtn.Parent = gui

-- Minimize/restore
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

-- Viewport for rig preview
local viewport = Instance.new("ViewportFrame")
viewport.Size = UDim2.new(0.45, 0, 0.65, 0)
viewport.Position = UDim2.new(0.025, 0, 0.18, 0)
viewport.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
viewport.BorderSizePixel = 0
viewport.Parent = frame

local cam = Instance.new("Camera")
cam.Parent = viewport
viewport.CurrentCamera = cam

-- Adjust camera to frame rig nicely
cam.FieldOfView = 70

-- Subtitle under title
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0.62, -20, 0.08, 0)
subtitle.Position = UDim2.new(0.475, 10, 0.14, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Preview your playing animation"
subtitle.Font = Enum.Font.Arcade
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
subtitle.Parent = frame

-- Output label
local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(0.55, 0, 0.12, 0)
outputLabel.Position = UDim2.new(0.475, 10, 0.24, 0)
outputLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
outputLabel.BorderSizePixel = 0
outputLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
outputLabel.Text = "Please press \"Get\" to get started..."
outputLabel.Font = Enum.Font.Arcade
outputLabel.TextSize = 14
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = frame

local labelCorner = Instance.new("UICorner")
labelCorner.CornerRadius = UDim.new(0, 8)
labelCorner.Parent = outputLabel

-- Copy and Get buttons aligned
local btnHeight = 0.1
local spacing = 0.015

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.28, 0, btnHeight, 0)
copyBtn.Position = UDim2.new(0.48, 0, 0.38, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 130)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.Arcade
copyBtn.Text = "Copy"
copyBtn.TextSize = 16
copyBtn.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 8)
copyCorner.Parent = copyBtn

local getBtn = Instance.new("TextButton")
getBtn.Size = UDim2.new(0.28, 0, btnHeight, 0)
getBtn.Position = UDim2.new(0.77, 0, 0.38, 0)
getBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getBtn.Font = Enum.Font.Arcade
getBtn.Text = "Get"
getBtn.TextSize = 16
getBtn.Parent = frame

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 8)
getCorner.Parent = getBtn

-- Animation handling
local canCheck = true
local placeholder = outputLabel.Text
local animClone, animTrack

local function getRigType()
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        return game:GetService("InsertService"):LoadAsset(16688968):FindFirstChildWhichIsA("Model")
    else
        return game:GetService("InsertService"):LoadAsset(424106429):FindFirstChildWhichIsA("Model")
    end
end

getBtn.MouseButton1Click:Connect(function()
    if not canCheck then return end
    for _, t in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if t.IsPlaying and t.Animation and t.Animation.AnimationId then
            outputLabel.Text = t.Animation.AnimationId
            outputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            if animClone then animClone:Destroy() end

            animClone = getRigType()
            local hrp = animClone:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Anchored = true end
            animClone.Parent = viewport

            cam.CFrame = CFrame.new(Vector3.new(0, 3, 8), Vector3.new(0, 3, 0))

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
        outputLabel.Text = "Copied!"
        outputLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        canCheck = false
        task.delay(1, function()
            outputLabel.Text = placeholder
            outputLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
            canCheck = true
        end)
    end
end)
