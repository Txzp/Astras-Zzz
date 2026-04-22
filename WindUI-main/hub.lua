local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- Variables
local SpeedEnabled = false
local SpeedValue = 16
local ESPEnabled = false
local ESPFill = 0.5
local ESPObjects = {}
local ToggleKey = Enum.KeyCode.K
local Window = nil

-- Speed
local function ApplySpeed()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = SpeedEnabled and SpeedValue or 16
    end
end

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    ApplySpeed()
end)

-- ESP
local function UpdateESP()
    if not ESPEnabled then
        for _, obj in pairs(ESPObjects) do
            pcall(function() obj:Destroy() end)
        end
        ESPObjects = {}
        return
    end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    if not ESPObjects[plr] then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = char
                        hl.FillColor = Color3.fromRGB(255, 50, 50)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = ESPFill
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = char
                        ESPObjects[plr] = hl
                    else
                        ESPObjects[plr].FillTransparency = ESPFill
                    end
                elseif ESPObjects[plr] then
                    pcall(function() ESPObjects[plr]:Destroy() end)
                    ESPObjects[plr] = nil
                end
            elseif ESPObjects[plr] then
                pcall(function() ESPObjects[plr]:Destroy() end)
                ESPObjects[plr] = nil
            end
        end
    end
end

RunService.Heartbeat:Connect(UpdateESP)

-- Ventana
Window = WindUI:CreateWindow({
    Title = "ASTRA HUB",
    Theme = "Dark",
    Size = UDim2.fromOffset(450, 420)
})

Window:Tag({ Title = "AstraHub", Color = Color3.fromHex("#30ff6a") })
Window:Tag({ Title = "v1.0", Color = Color3.fromHex("#315dff") })
Window:Tag({ Title = "by TzHzk", Color = Color3.fromHex("#888888") })

-- Tabs
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })
local ESPTab = Window:Tab({ Title = "ESP", Icon = "eye" })
local KeysTab = Window:Tab({ Title = "Keybinds", Icon = "command" })

-- Main
MainTab:Paragraph({
    Title = "ASTRA HUB",
    Desc = "Speed | ESP | Keybinds\n\nPresiona K para abrir/cerrar"
})

MainTab:Button({
    Title = "Discord",
    Callback = function()
        setclipboard("https://discord.gg/drR7ZVKPXe")
        WindUI:Notify({ Title = "Discord", Content = "Link copiado!", Duration = 2 })
    end
})

MainTab:Button({
    Title = "GitHub",
    Callback = function()
        setclipboard("https://github.com/TzHzk")
        WindUI:Notify({ Title = "GitHub", Content = "Link copiado!", Duration = 2 })
    end
})

-- Player
PlayerTab:Toggle({
    Title = "Speed",
    Value = false,
    Callback = function(state)
        SpeedEnabled = state
        ApplySpeed()
        WindUI:Notify({ Title = "Speed", Content = state and "Activado" or "Desactivado", Duration = 1 })
    end
})

PlayerTab:Slider({
    Title = "Velocidad",
    Value = { Min = 16, Max = 100, Default = 16 },
    Callback = function(value)
        SpeedValue = value
        if SpeedEnabled then ApplySpeed()
    end
})

-- ESP
ESPTab:Toggle({
    Title = "ESP Highlight",
    Value = false,
    Callback = function(state)
        ESPEnabled = state
        WindUI:Notify({ Title = "ESP", Content = state and "Activado" or "Desactivado", Duration = 1 })
    end
})

ESPTab:Slider({
    Title = "Opacidad",
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Increment = 0.1,
    Callback = function(value)
        ESPFill = value
    end
})

-- Keybinds (corregido - sin Flag)
KeysTab:Keybind({
    Title = "Abrir/Cerrar Hub",
    Value = "K",
    Callback = function(key)
        ToggleKey = Enum.KeyCode[key]
    end
})

-- Keybind global
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == ToggleKey then
        Window:Toggle()
    end
end)

print("✅ AstraHub cargado - Tecla K para abrir/cerrar")
