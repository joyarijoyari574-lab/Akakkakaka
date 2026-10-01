-- DARK HUB | Anti-Lag + Stretch
-- Blue theme version with Font Selector menu

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerGui = localPlayer:WaitForChild("PlayerGui")

-- ==== BLUE THEME PALETTE ====
local THEME = {
    BG          = Color3.fromRGB(20, 35, 70),   -- dark navy
    BG2         = Color3.fromRGB(30, 55, 110),  -- lighter blue
    ACCENT      = Color3.fromRGB(70, 130, 220), -- bright blue
    STROKE      = Color3.fromRGB(60, 110, 190),
    TEXT        = Color3.fromRGB(255, 255, 255),
    TEXT_DIM    = Color3.fromRGB(180, 200, 230),
    TRACK_OFF   = Color3.fromRGB(60, 75, 110),
    TRACK_ON    = Color3.fromRGB(70, 130, 220),
    BTN         = Color3.fromRGB(45, 75, 140),
    BTN_HOVER   = Color3.fromRGB(60, 95, 170),
}

local options = {
    AntiLag = false,
    RemoveAccessories = true,
    RemoveClothes = true,
    MenosEu = true,
    ShowFPS = true,
    Stretch = false,
    FontChanger = false,
    AverageFlagUI = false
}

local stretchConnection = nil

-- Stretch functions
local function enableStretch()
    if stretchConnection then return end
    stretchConnection = RunService.RenderStepped:Connect(function()
        Camera.CFrame = Camera.CFrame * CFrame.new(
            0,0,0,
            1,0,0,
            0,0.65,0,
            0,0,1
        )
    end)
end

local function disableStretch()
    if stretchConnection then
        stretchConnection:Disconnect()
        stretchConnection = nil
    end
end

-- GUI setup (blue theme)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DarkHubAntiLag"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

-- Toggle button (main menu opener)
local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.015, 0, 0.15, 0)
toggleButton.Image = "rbxassetid://99123598026483"
toggleButton.BackgroundTransparency = 0
toggleButton.BackgroundColor3 = THEME.ACCENT
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(35, 1)
toggleCorner.Parent = toggleButton

-- Main menu frame (blue)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 210, 0, 118)
mainFrame.Position = UDim2.new(0.015, 0, 0.25, 0)
mainFrame.BackgroundColor3 = THEME.BG
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = THEME.STROKE
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -70, 0, 28)
titleLabel.Position = UDim2.new(0, 12, 0, 4)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "DARK HUB | Anti-lag"
titleLabel.TextColor3 = THEME.TEXT
titleLabel.Font = Enum.Font.Antique
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

local gearButton = Instance.new("TextButton")
gearButton.Size = UDim2.new(0, 26, 0, 26)
gearButton.Position = UDim2.new(1, -58, 0, 5)
gearButton.BackgroundColor3 = THEME.BTN
gearButton.Text = "⚙️"
gearButton.TextColor3 = THEME.TEXT
gearButton.Font = Enum.Font.Antique
gearButton.TextSize = 14
gearButton.Parent = mainFrame

local gearCorner = Instance.new("UICorner")
gearCorner.CornerRadius = UDim.new(0, 7)
gearCorner.Parent = gearButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -28, 0, 5)
closeButton.BackgroundColor3 = THEME.BTN
closeButton.Text = "X"
closeButton.TextColor3 = THEME.TEXT
closeButton.Font = Enum.Font.Antique
closeButton.TextSize = 16
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = closeButton

-- Anti-Lag toggle (inside mainFrame)
local antiLagContainer = Instance.new("Frame")
antiLagContainer.Size = UDim2.new(0.9, 0, 0, 36)
antiLagContainer.Position = UDim2.new(0.05, 0, 0, 42)
antiLagContainer.BackgroundTransparency = 1
antiLagContainer.Parent = mainFrame

local antiLagLabel = Instance.new("TextLabel")
antiLagLabel.Size = UDim2.new(0.62, 0, 1, 0)
antiLagLabel.BackgroundTransparency = 1
antiLagLabel.Text = "Anti-Lag"
antiLagLabel.TextColor3 = THEME.TEXT
antiLagLabel.Font = Enum.Font.Antique
antiLagLabel.TextSize = 17
antiLagLabel.TextXAlignment = Enum.TextXAlignment.Left
antiLagLabel.Parent = antiLagContainer

local antiLagTrack = Instance.new("Frame")
antiLagTrack.Size = UDim2.new(0, 44, 0, 22)
antiLagTrack.Position = UDim2.new(1, -44, 0.5, -11)
antiLagTrack.BackgroundColor3 = THEME.TRACK_OFF
antiLagTrack.Parent = antiLagContainer

local antiLagTrackCorner = Instance.new("UICorner")
antiLagTrackCorner.CornerRadius = UDim.new(1, 0)
antiLagTrackCorner.Parent = antiLagTrack

local antiLagGradient = Instance.new("UIGradient")
antiLagGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.ACCENT),
    ColorSequenceKeypoint.new(1, THEME.TRACK_ON)
})
antiLagGradient.Enabled = false
antiLagGradient.Parent = antiLagTrack

local antiLagKnob = Instance.new("Frame")
antiLagKnob.Size = UDim2.new(0, 16, 0, 16)
antiLagKnob.Position = UDim2.new(0, 3, 0.5, -8)
antiLagKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
antiLagKnob.Parent = antiLagTrack

local antiLagKnobCorner = Instance.new("UICorner")
antiLagKnobCorner.CornerRadius = UDim.new(1, 0)
antiLagKnobCorner.Parent = antiLagKnob

local antiLagButton = Instance.new("TextButton")
antiLagButton.Size = UDim2.new(1, 0, 1, 0)
antiLagButton.BackgroundTransparency = 1
antiLagButton.Text = ""
antiLagButton.Parent = antiLagTrack

-- Configuration submenu (blue)
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0, 210, 0, 270)
configFrame.Position = UDim2.new(1, 10, 0, 0)
configFrame.BackgroundColor3 = THEME.BG
configFrame.BorderSizePixel = 0
configFrame.Visible = false
configFrame.Parent = mainFrame

local configCorner = Instance.new("UICorner")
configCorner.CornerRadius = UDim.new(0, 12)
configCorner.Parent = configFrame

local configStroke = Instance.new("UIStroke")
configStroke.Color = THEME.STROKE
configStroke.Thickness = 1
configStroke.Parent = configFrame

local configTitle = Instance.new("TextLabel")
configTitle.Size = UDim2.new(1, 0, 0, 24)
configTitle.BackgroundTransparency = 1
configTitle.Text = "Configuracoes"
configTitle.TextColor3 = THEME.TEXT
configTitle.Font = Enum.Font.Antique
configTitle.TextSize = 15
configTitle.Parent = configFrame

-- Helper: create a toggle row inside configFrame (blue style)
local function createConfigToggle(text, yPos, initialValue)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.9, 0, 0, 28)
    container.Position = UDim2.new(0.05, 0, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = configFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = THEME.TEXT
    label.Font = Enum.Font.Antique
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -44, 0.5, -11)
    track.BackgroundColor3 = initialValue and THEME.TRACK_ON or THEME.TRACK_OFF
    track.Parent = container

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, THEME.ACCENT),
        ColorSequenceKeypoint.new(1, THEME.TRACK_ON)
    })
    grad.Enabled = false
    grad.Parent = track

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = initialValue and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = track

    return button, track, knob, grad
end

-- Create toggles in config frame
local accButton, accTrack, accKnob, accGrad = createConfigToggle("Remover Acessorios", 32, options.RemoveAccessories)
local clothButton, clothTrack, clothKnob, clothGrad = createConfigToggle("Remover Roupas", 64, options.RemoveClothes)
local menosButton, menosTrack, menosKnob, menosGrad = createConfigToggle("Menos eu", 96, options.MenosEu)
local fpsButton, fpsTrack, fpsKnob, fpsGrad = createConfigToggle("Contador de FPS", 128, options.ShowFPS)
local stretchButton, stretchTrack, stretchKnob, stretchGrad = createConfigToggle("Stretch Camera", 160, options.Stretch)
local fontButton, fontTrack, fontKnob, fontGrad = createConfigToggle("Font Changer", 192, options.FontChanger)
local flagButton, flagTrack, flagKnob, flagGrad = createConfigToggle("Average Flag UI", 224, options.AverageFlagUI)

--==================================================
-- FONT SELECTOR MENU (kotak pilih font)
-- Muncul saat Font Changer aktif
--==================================================

local FONT_LIST = {
    {Name = "Minecraft (Blocky)", Font = Enum.Font.Arcade},
    {Name = "Helowin", Font = Enum.Font.SourceSansSemibold},
    {Name = "Tebal Tebal", Font = Enum.Font.GothamBlack},
    {Name = "Fantasy", Font = Enum.Font.Fantasy},
    {Name = "Code (Monospace)", Font = Enum.Font.Code},
    {Name = "Antique", Font = Enum.Font.Antique},
    {Name = "Sci-Fi", Font = Enum.Font.SciFi},
    {Name = "Cartoon", Font = Enum.Font.Cartoon}
}

local fontSelector = Instance.new("Frame")
fontSelector.Size = UDim2.new(0, 175, 0, 30 + #FONT_LIST * 30 + 10)
fontSelector.Position = UDim2.new(1, 10, 0, 0)
fontSelector.BackgroundColor3 = THEME.BG
fontSelector.BorderSizePixel = 0
fontSelector.Visible = false
fontSelector.Parent = configFrame

local fsCorner = Instance.new("UICorner")
fsCorner.CornerRadius = UDim.new(0, 12)
fsCorner.Parent = fontSelector

local fsStroke = Instance.new("UIStroke")
fsStroke.Color = THEME.STROKE
fsStroke.Thickness = 1
fsStroke.Parent = fontSelector

local fsTitle = Instance.new("TextLabel")
fsTitle.Size = UDim2.new(1, 0, 0, 24)
fsTitle.BackgroundTransparency = 1
fsTitle.Text = "Pilih Font"
fsTitle.TextColor3 = THEME.TEXT
fsTitle.Font = Enum.Font.Antique
fsTitle.TextSize = 15
fsTitle.Parent = fontSelector

-- List of font buttons
local fontButtons = {}

for i, fontData in ipairs(FONT_LIST) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 26)
    btn.Position = UDim2.new(0.05, 0, 0, 26 + (i - 1) * 30)
    btn.BackgroundColor3 = THEME.BTN
    btn.Text = fontData.Name
    btn.TextColor3 = THEME.TEXT
    btn.Font = Enum.Font.Antique
    btn.TextSize = 13
    btn.AutoButtonColor = true
    btn.Parent = fontSelector

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 6)
    bCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        -- Apply selected font
        applyFontEverywhere(fontData.Font)

        -- Highlight selected
        for _, b in ipairs(fontButtons) do
            b.BackgroundColor3 = THEME.BTN
        end
        btn.BackgroundColor3 = THEME.ACCENT
    end)

    table.insert(fontButtons, btn)
end

--==================================================
-- FONT CHANGER LOGIC
--==================================================

local originalFonts = {}
local currentFont = nil
local fontConnection = nil

local function isTextObject(obj)
    return obj:IsA("TextLabel")
        or obj:IsA("TextButton")
        or obj:IsA("TextBox")
end

local function saveOriginalFont(obj)
    if not originalFonts[obj] then
        originalFonts[obj] = {
            Font = obj.Font,
            FontFace = obj.FontFace
        }
    end
end

local function applyOneFont(obj, font)
    if not obj or not obj.Parent or not isTextObject(obj) then return end
    saveOriginalFont(obj)

    pcall(function()
        obj.Font = font
    end)

    pcall(function()
        obj.FontFace = Font.fromEnum(font)
    end)
end

function applyFontEverywhere(font)
    currentFont = font

    for _, obj in ipairs(PlayerGui:GetDescendants()) do
        if isTextObject(obj) then
            applyOneFont(obj, font)
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if isTextObject(obj) then
            applyOneFont(obj, font)
        end
    end
end

local function restoreOriginalFonts()
    currentFont = nil

    if fontConnection then
        fontConnection:Disconnect()
        fontConnection = nil
    end

    for obj, data in pairs(originalFonts) do
        if obj and obj.Parent then
            pcall(function()
                obj.Font = data.Font
            end)
            pcall(function()
                obj.FontFace = data.FontFace
            end)
        end
    end

    originalFonts = {}
end

local function enableFontChanger()
    if currentFont then return end

    local defaultFont = FONT_LIST[1].Font
    applyFontEverywhere(defaultFont)

    if fontConnection then
        fontConnection:Disconnect()
    end

    fontConnection = game.DescendantAdded:Connect(function(obj)
        if currentFont and isTextObject(obj) then
            task.defer(function()
                if currentFont then
                    applyOneFont(obj, currentFont)
                end
            end)
        end
    end)

    -- Show font selector
    fontSelector.Visible = true
end

local function disableFontChanger()
    restoreOriginalFonts()
    fontSelector.Visible = false
end

--==================================================
-- AVERAGE FLAG UI
--==================================================

local AVERAGE_FLAG_URL =
    "https://raw.githubusercontent.com/AEYSHT/MYSTUFF/refs/heads/main/Scripts/AVERAGEFFLAGUI.lua"

local function enableAverageFlagUI()
    local ok, err = pcall(function()
        local source = game:HttpGet(AVERAGE_FLAG_URL)
        local fn = loadstring(source)
        if not fn then
            error("loadstring gagal membuat fungsi dari source.")
        end
        fn()
    end)

    if not ok then
        warn("DARK HUB | Average Flag UI gagal dijalankan: " .. tostring(err))
    end
end

local function disableAverageFlagUI()
    -- Script eksternal tidak dapat di-unload secara umum dari sini.
end

-- FPS Label (floating)
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 160, 0, 32)
fpsLabel.Position = UDim2.new(0.5, -80, 0, 8)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = Color3.fromRGB(100, 255, 140)
fpsLabel.Font = Enum.Font.Antique
fpsLabel.TextSize = 24
fpsLabel.TextStrokeTransparency = 0.5
fpsLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
fpsLabel.Visible = options.ShowFPS
fpsLabel.Parent = screenGui

-- Helper: update toggle appearance (blue version)
local function updateToggle(track, knob, grad, enabled)
    if enabled then
        track.BackgroundColor3 = THEME.TRACK_ON
        grad.Enabled = false
        knob:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.15, true)
    else
        track.BackgroundColor3 = THEME.TRACK_OFF
        grad.Enabled = false
        knob:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    end
end

-- Anti-Lag functions
local function applyLighting()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9000000000
    Lighting.Brightness = 1.5
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0

    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("PostEffect") or child:IsA("BloomEffect") or child:IsA("BlurEffect")
            or child:IsA("ColorCorrectionEffect") or child:IsA("SunRaysEffect") or child:IsA("DepthOfFieldEffect") then
            child.Enabled = false
        end
    end

    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmosphere then
        atmosphere:Destroy()
    end
end

local function applyTerrain()
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
        pcall(function()
            terrain.Decoration = false
        end)
    end
end

local function applyParts()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("UnionOperation") then
            descendant.Material = Enum.Material.SmoothPlastic
            descendant.Reflectance = 0
            descendant.CastShadow = false
            if descendant:IsA("MeshPart") then
                descendant.RenderFidelity = Enum.RenderFidelity.Performance
            end
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant.Transparency = 1
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam")
            or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
            descendant.Enabled = false
        elseif descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
            descendant.Enabled = false
        end
    end
end

local function processCharacter(character, isLocal)
    if not character then return end

    if options.RemoveAccessories then
        for _, child in pairs(character:GetChildren()) do
            if child:IsA("Accessory") then
                child:Destroy()
            end
        end
    end

    if options.RemoveClothes then
        for _, child in pairs(character:GetChildren()) do
            if child:IsA("Shirt") or child:IsA("Pants") or child:IsA("ShirtGraphic") then
                child:Destroy()
            end
        end
    end
end

local function applyAntiLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    applyLighting()
    applyTerrain()
    applyParts()

    for _, player in pairs(Players:GetPlayers()) do
        processCharacter(player.Character, player == localPlayer)
    end
end

local function setupPlayer(player)
    player.CharacterAdded:Connect(function(character)
        if not options.AntiLag then return end
        task.wait(0.6)
        processCharacter(character, player == localPlayer)
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    setupPlayer(player)
end
Players.PlayerAdded:Connect(setupPlayer)

task.spawn(function()
    while true do
        task.wait(3)
        if options.AntiLag then
            for _, player in pairs(Players:GetPlayers()) do
                processCharacter(player.Character, player == localPlayer)
            end
        end
    end
end)

-- Event connections

antiLagButton.MouseButton1Click:Connect(function()
    options.AntiLag = not options.AntiLag
    updateToggle(antiLagTrack, antiLagKnob, antiLagGradient, options.AntiLag)
    if options.AntiLag then
        applyAntiLag()
    end
end)

accButton.MouseButton1Click:Connect(function()
    options.RemoveAccessories = not options.RemoveAccessories
    updateToggle(accTrack, accKnob, accGrad, options.RemoveAccessories)
end)

clothButton.MouseButton1Click:Connect(function()
    options.RemoveClothes = not options.RemoveClothes
    updateToggle(clothTrack, clothKnob, clothGrad, options.RemoveClothes)
end)

menosButton.MouseButton1Click:Connect(function()
    options.MenosEu = not options.MenosEu
    updateToggle(menosTrack, menosKnob, menosGrad, options.MenosEu)
end)

fpsButton.MouseButton1Click:Connect(function()
    options.ShowFPS = not options.ShowFPS
    updateToggle(fpsTrack, fpsKnob, fpsGrad, options.ShowFPS)
    fpsLabel.Visible = options.ShowFPS
end)

stretchButton.MouseButton1Click:Connect(function()
    options.Stretch = not options.Stretch
    updateToggle(stretchTrack, stretchKnob, stretchGrad, options.Stretch)
    if options.Stretch then
        enableStretch()
    else
        disableStretch()
    end
end)

-- Font Changer toggle (shows font selector)
fontButton.MouseButton1Click:Connect(function()
    options.FontChanger = not options.FontChanger
    updateToggle(fontTrack, fontKnob, fontGrad, options.FontChanger)

    if options.FontChanger then
        enableFontChanger()
    else
        disableFontChanger()
    end
end)

flagButton.MouseButton1Click:Connect(function()
    options.AverageFlagUI = not options.AverageFlagUI
    updateToggle(flagTrack, flagKnob, flagGrad, options.AverageFlagUI)

    if options.AverageFlagUI then
        enableAverageFlagUI()
    else
        disableAverageFlagUI()
    end
end)

-- Gear button
local configVisible = false
gearButton.MouseButton1Click:Connect(function()
    configVisible = not configVisible
    configFrame.Visible = configVisible
    if not configVisible then
        fontSelector.Visible = false
    end
end)

-- Toggle main menu
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Close button
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- FPS counter
local frameCount = 0
local lastTime = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastTime >= 1 then
        if options.ShowFPS then
            fpsLabel.Text = "FPS: " .. frameCount
            if frameCount >= 55 then
                fpsLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
            elseif frameCount >= 40 then
                fpsLabel.TextColor3 = Color3.fromRGB(255, 220, 80)
            else
                fpsLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            end
        end
        frameCount = 0
        lastTime = now
    end
end)

print("DARK HUB | Anti-lag + Stretch + Font Changer (Blue Theme) carregado!")