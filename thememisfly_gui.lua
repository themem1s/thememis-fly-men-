
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()



local player = game.Players.LocalPlayer


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SupportGui"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Position = UDim2.new(0, 0, 0, 0)

local textLabel = Instance.new("TextLabel")
textLabel.Parent = frame
textLabel.BackgroundTransparency = 1
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.Font = Enum.Font.SourceSans
textLabel.Text = "Support Servers:\n\nhttps://discord.gg/gbs5e867\nhttps://discord.gg/WMH8bheV"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextScaled = true
textLabel.TextWrapped = true
textLabel.TextStrokeTransparency = 0.5
textLabel.TextSize = 24


local function closeGui()
    wait(5)
    screenGui:Destroy()
end


closeGui()




local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyAndWallPassGui"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.0685602352, 0, 0.168769717, 0)
frame.Size = UDim2.new(0.264544547, 0, 0.100000024, 0)

local flyButton = Instance.new("TextButton")
flyButton.Parent = frame
flyButton.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
flyButton.BorderSizePixel = 0
flyButton.Position = UDim2.new(0.06324628, 0, 0.400667697, 0)
flyButton.Size = UDim2.new(0.871157169, 0, 0.495614201, 0)
flyButton.Font = Enum.Font.ArialBold
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextScaled = true
flyButton.TextSize = 14.000
flyButton.TextStrokeTransparency = 0.000
flyButton.TextWrapped = true

local wallPassButton = Instance.new("TextButton")
wallPassButton.Parent = frame
wallPassButton.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
wallPassButton.BorderSizePixel = 0
wallPassButton.Position = UDim2.new(0.06324628, 0, 0.100667697, 0)
wallPassButton.Size = UDim2.new(0.871157169, 0, 0.295614201, 0)
wallPassButton.Font = Enum.Font.ArialBold
wallPassButton.Text = "NO CLIP"
wallPassButton.TextColor3 = Color3.fromRGB(255, 255, 255)
wallPassButton.TextScaled = true
wallPassButton.TextSize = 14.000
wallPassButton.TextStrokeTransparency = 0.000
wallPassButton.TextWrapped = true

local textLabel = Instance.new("TextLabel")
textLabel.Parent = frame
textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Size = UDim2.new(0, 86, 0, 24)
textLabel.Font = Enum.Font.Oswald
textLabel.Text = "My Owner thememis"
textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
textLabel.TextScaled = true
textLabel.TextSize = 14.000
textLabel.TextWrapped = true


local canPassThroughWalls = false


local function setCollisionState(state)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide ~= nil then
            part.CanCollide = state
        end
    end
end


local function toggleWallPass()
    canPassThroughWalls = not canPassThroughWalls
    setCollisionState(not canPassThroughWalls)
    
    if canPassThroughWalls then
        wallPassButton.Text = "NO CLIP: Açık"
    else
        wallPassButton.Text = "NO CLIP: Kapalı"
    end
end


local flying = false
local speed = 50
local maxSpeed = 1000
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastCtrl = {f = 0, b = 0, l = 0, r = 0}

local function fly()
    local bg = Instance.new("BodyGyro", humanoidRootPart)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = humanoidRootPart.CFrame
    
    local bv = Instance.new("BodyVelocity", humanoidRootPart)
    bv.velocity = Vector3.new(0, 0.1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    repeat
        wait()
        player.Character.Humanoid.PlatformStand = true
        
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speed = speed + 0.5 + (speed / maxSpeed)
            if speed > maxSpeed then
                speed = maxSpeed
            end
        elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
            speed = speed - 1
            if speed < 0 then
                speed = 0
            else
                speed = 50
            end
        end
        
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
            lastCtrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
        elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastCtrl.f + lastCtrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastCtrl.l + lastCtrl.r, (lastCtrl.f + lastCtrl.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
        else
            bv.velocity = Vector3.new(0, 0.1, 0)
        end
        
        bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxSpeed), 0, 0)
    until not flying
    
    bg:Destroy()
    bv:Destroy()
    player.Character.Humanoid.PlatformStand = false
    speed = 50
end


flyButton.MouseButton1Click:Connect(function()
    if flying then
        flying = false
        speed = 50
    else
        flying = true
        fly()
    end
end)

wallPassButton.MouseButton1Click:Connect(toggleWallPass)


mouse.KeyDown:Connect(function(key)
    if key:lower() == "e" then
        if flying then
            flying = false
            speed = 50
        else
            flying = true
            fly()
        end
    elseif key:lower() == "w" then
        ctrl.f = 1
    elseif key:lower() == "s" then
        ctrl.b = -1
    elseif key:lower() == "a" then
        ctrl.l = -1
    elseif key:lower() == "d" then
        ctrl.r = 1
    end
end)

mouse.KeyUp:Connect(function(key)
    if key:lower() == "w" then
        ctrl.f = 0
    elseif key:lower() == "s" then
        ctrl.b = 0
    elseif key:lower() == "a" then
        ctrl.l = 0
    elseif key:lower() == "d" then
        ctrl.r = 0
    end
end)


character:WaitForChild("Humanoid").Died:Connect(function()
    setCollisionState(true)
end)

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)


game:GetService("RunService").Heartbeat:Connect(function()
    if canPassThroughWalls then
        setCollisionState(false)
    end
end)
