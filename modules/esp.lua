-- modules/esp.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local TracersEnabled = true
local ESPObjects = {}

-- TEAM CHECK
local function IsEnemy(player)
    if not LocalPlayer.Team or not player.Team then return true end
    return player.Team ~= LocalPlayer.Team
end

-- VISIBILITY CHECK
local function IsVisible(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local origin = Camera.CFrame.Position
    local direction = (hrp.Position - origin)

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character, character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local ray = workspace:Raycast(origin, direction, params)
    return ray and ray.Instance:IsDescendantOf(character)
end

-- CREATE ESP
local function CreateESP(player)
    if player == LocalPlayer then return end

    local tracer = Drawing.new("Line")
    tracer.Thickness = 1
    tracer.Transparency = 1

    ESPObjects[player] = {Tracer = tracer}

    local function Apply(character)
        if not IsEnemy(player) then return end

        local highlight = Instance.new("Highlight")
        highlight.Name = "GlowESP"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = character

        RunService.RenderStepped:Connect(function()
            if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
                tracer.Visible = false
                return
            end

            local visible = IsVisible(character)
            if visible then
                highlight.FillColor = Color3.fromRGB(0,255,0)
                highlight.OutlineColor = Color3.fromRGB(0,255,0)
                tracer.Color = Color3.fromRGB(0,255,0)
            else
                highlight.FillColor = Color3.fromRGB(255,0,0)
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                tracer.Color = Color3.fromRGB(255,0,0)
            end

            if TracersEnabled then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(pos.X, pos.Y)
                    tracer.Visible = true
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end
        end)
    end

    if player.Character then Apply(player.Character) end
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        Apply(char)
    end)
end

-- INIT
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end
Players.PlayerAdded:Connect(CreateESP)

-- TOGGLE TRACERS
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.G then
        TracersEnabled = not TracersEnabled
    end
end)

-- RETURN
return {
    ToggleTracers = function() TracersEnabled = not TracersEnabled end
}
