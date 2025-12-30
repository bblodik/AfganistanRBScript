local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Импорт ESP
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/bblodik/AfganistanRBScript/main/modules/esp.lua"))()

local gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0.5, -250, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true

-- Категории слева
local categories = Instance.new("Frame", frame)
categories.Size = UDim2.new(0,150,1,0)
categories.BackgroundColor3 = Color3.fromRGB(35,35,35)

local function CreateButton(text, y, callback)
    local btn = Instance.new("TextButton", categories)
    btn.Size = UDim2.new(1,-10,0,40)
    btn.Position = UDim2.new(0,5,0,y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(80,0,140)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(callback)
end

-- Категории
CreateButton("ESP", 0, function() rightPanel:ClearAllChildren(); ESPPanel(rightPanel) end)
CreateButton("Aimbot", 50, function() rightPanel:ClearAllChildren(); AimbotPanel(rightPanel) end)
CreateButton("Bhop", 100, function() rightPanel:ClearAllChildren(); BhopPanel(rightPanel) end)
CreateButton("Misc", 150, function() rightPanel:ClearAllChildren(); MiscPanel(rightPanel) end)

-- Правая часть под функции
local rightPanel = Instance.new("Frame", frame)
rightPanel.Size = UDim2.new(1, -150, 1, 0)
rightPanel.Position = UDim2.new(0,150,0,0)
rightPanel.BackgroundColor3 = Color3.fromRGB(30,30,30)

-- ESP панель
function ESPPanel(parent)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(1,0,0,30)
    label.Position = UDim2.new(0,0,0,0)
    label.Text = "ESP Settings"
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16

    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0,180,0,40)
    btn.Position = UDim2.new(0,10,0,50)
    btn.Text = "Toggle Tracers (G)"
    btn.BackgroundColor3 = Color3.fromRGB(90,0,140)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        ESP.ToggleTracers()
    end)
end

-- Пример заготовки других панелей
function AimbotPanel(parent) end
function BhopPanel(parent) end
function MiscPanel(parent) end

-- INS toggle
UserInputService.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        frame.Visible = not frame.Visible
    end
end)
