-- ═══════════════════════════════════════════════════════════════
--   ASTRASHUB ZZ - By TzHzk
--   Speed | JumpPower | ESP Highlight
--   Usando Sliders Estables
-- ═══════════════════════════════════════════════════════════════

-- Cargar WindUI desde tu repositorio público
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- Variables Globales
local SpeedEnabled = false
local SpeedValue = 16
local JumpEnabled = false
local JumpValue = 50
local ESPEnabled = false
local ESPFill = 0.5
local ESPObjects = {}
local ToggleKey = Enum.KeyCode.K
local Window = nil

-- ═══════════════════════════════════════════════════════════════
-- FUNCIONES LÓGICAS
-- ═══════════════════════════════════════════════════════════════

local function ApplySpeed()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = SpeedEnabled and SpeedValue or 16
        hum.JumpPower = JumpEnabled and JumpValue or 50
    end
end

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    ApplySpeed()
end)

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
                        hl.FillColor = Color3.fromRGB(255, 50, 50) -- Rojo por defecto
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

-- ═══════════════════════════════════════════════════════════════
-- CREACIÓN DE UI (WINDUI)
-- ═══════════════════════════════════════════════════════════════

Window = WindUI:CreateWindow({
    Title = "ASTRA HUB",
    Icon = "zap",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420)
})

-- Header Tags
Window:Tag({ Title = "AstraHub Zz", Color = Color3.fromHex("#30ff6a") })
Window:Tag({ Title = "v1.0", Color = Color3.fromHex("#315dff") })
Window:Tag({ Title = "by TzHzk", Color = Color3.fromHex("#888888") })

-- Tabs
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })
local ESPTab = Window:Tab({ Title = "ESP", Icon = "eye" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

-- MAIN TAB
MainTab:Paragraph({
    Title = "✨ Bienvenido a AstraHub",
    Desc = "Hub optimizado por TzHzk\nSpeed • Jump • ESP\nEstable y sin errores."
})
MainTab:Divider()
MainTab:Button({
    Title = "Discord Server",
    Icon = "message-circle",
    Callback = function()
        setclipboard("https://discord.gg/drR7ZVKPXe")
        WindUI:Notify({ Title = "Discord", Content = "Link copiado!", Duration = 2 })
    end
})

-- PLAYER TAB (CON SLIDERS)
PlayerTab:Toggle({
    Title = "⚡ Speed Activado",
    Value = false,
    Callback = function(state)
        SpeedEnabled = state
        ApplySpeed()
    end
})

-- Slider de Velocidad (Sintaxis segura)
PlayerTab:Slider({
    Title = "Velocidad",
    Value = { Min = 16, Max = 120, Default = 16 },
    Callback = function(value)
        SpeedValue = value
        if SpeedEnabled then ApplySpeed() end
    end
})

PlayerTab:Divider()

PlayerTab:Toggle({
    Title = "🦘 Jump Power Activado",
    Value = false,
    Callback = function(state)
        JumpEnabled = state
        ApplySpeed()
    end
})

-- Slider de Salto
PlayerTab:Slider({
    Title = "Altura de Salto",
    Value = { Min = 50, Max = 200, Default = 50 },
    Callback = function(value)
        JumpValue = value
        if JumpEnabled then ApplySpeed() end
    end
})

-- ESP TAB (CON SLIDER)
ESPTab:Toggle({
    Title = "👁️ ESP Highlight",
    Value = false,
    Callback = function(state)
        ESPEnabled = state
    end
})

-- Slider de Opacidad (Evitamos Colorpicker para asegurar estabilidad)
ESPTab:Slider({
    Title = "Opacidad del ESP",
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Increment = 0.1, -- Importante para sliders decimales
    Callback = function(value)
        ESPFill = value
    end
})

-- SETTINGS TAB (KEYBIND)
SettingsTab:Keybind({
    Title = "Tecla Abrir/Cerrar",
    Value = "K", -- Valor inicial como string
    Callback = function(key)
        -- WindUI suele devolver el nombre de la tecla, lo convertimos a Enum
        local success, enumKey = pcall(function()
            return Enum.KeyCode[key]
        end)
        if success then
            ToggleKey = enumKey
            WindUI:Notify({ Title = "Keybind", Content = "Tecla cambiada a: " .. key, Duration = 2 })
        end
    end
})

-- Keybind Global para abrir/cerrar
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == ToggleKey then
        Window:Toggle()
    end
end)

print("✅ AstraHub Zz Cargado Correctamente")
print("🔑 Usa la tecla K para abrir/cerrar")
