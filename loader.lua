-- ===== CONFIG =====
local CORRECT_KEY = "123DEMO123"
local MENU_URL = "https://raw.githubusercontent.com/bblodik/AfganistanRBScript/main/Menu.lua"
-- ==================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 160)
Frame.Position = UDim2.new(0.5, -150, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,35)
Title.Text = "Afganistan Script | Key System"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local KeyBox = Instance.new("TextBox", Frame)
KeyBox.Size = UDim2.new(1,-40,0,35)
KeyBox.Position = UDim2.new(0,20,0,55)
KeyBox.PlaceholderText = "Введите ключ"
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1,-40,0,35)
Button.Position = UDim2.new(0,20,0,105)
Button.Text = "Проверить ключ"
Button.BackgroundColor3 = Color3.fromRGB(80,0,120)
Button.TextColor3 = Color3.fromRGB(255,255,255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14

Button.MouseButton1Click:Connect(function()
	if KeyBox.Text == CORRECT_KEY then
		ScreenGui:Destroy()
		loadstring(game:HttpGet(MENU_URL))()
	else
		Button.Text = "Неверный ключ"
		wait(1)
		Button.Text = "Проверить ключ"
	end
end)
