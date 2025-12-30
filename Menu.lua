local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Afganistan Script MENU"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1,0,0,30)
info.Position = UDim2.new(0,0,0,50)
info.Text = "INS — открыть / закрыть меню"
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(180,180,180)
info.Font = Enum.Font.Gotham
info.TextSize = 12

-- пример кнопки
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,180,0,40)
btn.Position = UDim2.new(0.5,-90,0,100)
btn.Text = "ТЕСТ КНОПКА"
btn.BackgroundColor3 = Color3.fromRGB(90,0,140)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14

btn.MouseButton1Click:Connect(function()
	print("Кнопка нажата")
end)

-- INS toggle
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Insert then
		frame.Visible = not frame.Visible
	end
end)
