-- Animation Inspector GUI for Roblox
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Remove existing instance
local existing = player:WaitForChild("PlayerGui"):FindFirstChild("AnimationInspectorUI")
if existing then existing:Destroy() end

-- Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AnimationInspectorUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main container frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.34, 0, 0.5, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Styling
local frameCorner = Instance.new("UICorner") frameCorner.CornerRadius = UDim.new(0, 6) frameCorner.Parent = frame
local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(100,100,255) stroke.Thickness = 1.5 stroke.Parent = frame
local gradient = Instance.new("UIGradient") gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,80)), ColorSequenceKeypoint.new(1,Color3.fromRGB(10,10,30))}) gradient.Rotation = 90 gradient.Parent = frame

-- Title bar and controls
local titleBar = Instance.new("Frame") titleBar.Size = UDim2.new(1,0,0.12,0) titleBar.BackgroundTransparency = 1 titleBar.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7,0,1,0)
title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1
title.Text = "Anim Inspector"
title.Font = Enum.Font.Arcade
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local function createBtn(text, posOffset, bg)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,22,0,22)
    btn.Position = UDim2.new(1,posOffset,0.5,-11)
    btn.Text = text
    btn.Font = Enum.Font.Arcade
    btn.TextScaled = true
    btn.BackgroundColor3 = bg
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = titleBar
    return btn
end

local minBtn = createBtn("-", -54, Color3.fromRGB(70,70,90))
local closeBtn = createBtn("X", -28, Color3.fromRGB(150,50,50))

-- Minimize/close behavior
local showBtn = Instance.new("ImageButton")
showBtn.Size = UDim2.new(0,28,0,28)
showBtn.Position = UDim2.new(0,8,0.5,-14)
showBtn.Image = "rbxassetid://153287168"
showBtn.BackgroundTransparency = 1
showBtn.Visible = false
showBtn.Parent = gui
minBtn.MouseButton1Click:Connect(function() gui.Enabled=false showBtn.Visible=true end)
showBtn.MouseButton1Click:Connect(function() gui.Enabled=true showBtn.Visible=false end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- ViewportFrame for rig
local viewport = Instance.new("ViewportFrame")
viewport.Size = UDim2.new(0.62,0,0.6,0)
viewport.Position = UDim2.new(0.02,0,0.16,0)
viewport.BackgroundColor3 = Color3.fromRGB(20,20,40)
viewport.BorderSizePixel = 0
viewport.Parent = frame
local cam = Instance.new("Camera") cam.Parent = viewport viewport.CurrentCamera = cam cam.FieldOfView = 70

-- Output section
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0.64,0,0.08,0)
subtitle.Position = UDim2.new(0.38,10,0.14,0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Preview current animation"
subtitle.Font = Enum.Font.Arcade
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(200,200,255)
subtitle.Parent = frame

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(0.58,0,0.12,0)
outputLabel.Position = UDim2.new(0.38,10,0.24,0)
outputLabel.BackgroundColor3 = Color3.fromRGB(35,35,60)
outputLabel.BorderSizePixel = 0
outputLabel.TextColor3 = Color3.fromRGB(160,160,160)
outputLabel.Text = "Press Get"
outputLabel.Font = Enum.Font.Arcade
outputLabel.TextScaled = false
outputLabel.TextSize = 14
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = frame
local labelCorner = Instance.new("UICorner") labelCorner.CornerRadius = UDim.new(0,8) labelCorner.Parent = outputLabel

-- Buttons aligned & same size
local btnSize = UDim2.new(0.25,0,0.08,0)
local btnY = 0.40
local copyBtn = Instance.new("TextButton")
copyBtn.Size = btnSize
copyBtn.Position = UDim2.new(0.38,0,btnY,0)
copyBtn.Text = "Copy"
copyBtn.Font = Enum.Font.Arcade
copyBtn.TextSize = 16
copyBtn.BackgroundColor3 = Color3.fromRGB(80,80,130)
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.Parent = frame
local copyCor = Instance.new("UICorner") copyCor.CornerRadius = UDim.new(0,6) copyCor.Parent = copyBtn

local getBtn = Instance.new("TextButton")
getBtn.Size = btnSize
getBtn.Position = UDim2.new(0.65,0,btnY,0)
getBtn.Text = "Get"
getBtn.Font = Enum.Font.Arcade
getBtn.TextSize = 16
getBtn.BackgroundColor3 = Color3.fromRGB(50,100,200)
getBtn.TextColor3 = Color3.new(1,1,1)
getBtn.Parent = frame
local getCor = Instance.new("UICorner") getCor.CornerRadius = UDim.new(0,6) getCor.Parent = getBtn

-- Animation logic
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
    for _,t in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if t.IsPlaying and t.Animation and t.Animation.AnimationId then
            outputLabel.Text = t.Animation.AnimationId
            outputLabel.TextColor3 = Color3.new(1,1,1)
            if animClone then animClone:Destroy() end
            animClone = getRigType()
            local hrp = animClone:FindFirstChild("HumanoidRootPart") if hrp then hrp.Anchored=true end
            animClone.Parent = viewport
            -- Center rig in view
            local bbMin, bbMax = animClone:GetBoundingBox()
            local size = (bbMax - bbMin).Magnitude
            cam.CFrame = CFrame.new(bbMin + (bbMax-bbMin)/2 + Vector3.new(0,size*0.6,size*1.2), bbMin + (bbMax-bbMin)/2)
            animTrack = animClone:WaitForChild("Humanoid"):LoadAnimation(Instance.new("Animation",animClone){AnimationId = t.Animation.AnimationId})
            animTrack:Play()
            if not animTrack.Looped then
                coroutine.wrap(function() while animClone and animTrack do animTrack:Play() task.wait(animTrack.Length+1) end end)()
            end
            return
        end
    end
    outputLabel.Text = "No animation playing"
    outputLabel.TextColor3 = Color3.new(1,1,1)
end)

copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(outputLabel.Text) end
    outputLabel.Text = "Copied to clipboard"
    outputLabel.TextColor3 = Color3.fromRGB(0,255,0)
    canCheck=false
    task.delay(1,function() outputLabel.Text=placeholder outputLabel.TextColor3=Color3.fromRGB(160,160,160) canCheck=true end)
end)
