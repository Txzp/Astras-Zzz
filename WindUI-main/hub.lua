-- AstraHub Zz - Script Final Definitivo con Temas
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando AstraHub Zz...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz", -- Título del Hub
    Theme = "Dark", -- Tema por defecto
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZz",
    IgnoreAlerts = false, -- Para que funcione el Dialog de cierre personalizado
})

print("✅ Ventana cargada.")

-- ═══════════════════════════════════════════════════════════════
-- SERVICIOS Y VARIABLES GLOBALES
-- ═══════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

-- Estados de Funciones
local FlyEnabled = false
local FlySpeed = 50
local NoclipEnabled = false
local SpeedEnabled = false
local SpeedValue = 50
local JumpEnabled = false
local JumpPower = 50

-- Variables para Fly
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BodyVelocity.Velocity = Vector3.new(0, 0, 0)
BodyVelocity.Parent = RootPart

local BodyGyro = Instance.new("BodyGyro")
BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BodyGyro.D = 100
BodyGyro.P = 10000
BodyGyro.CFrame = RootPart.CFrame
BodyGyro.Parent = RootPart

-- ═══════════════════════════════════════════════════════════════
-- LÓGICA DE MOVIMIENTO (FLY, NOCLIP, SPEED, JUMP) - CORREGIDA
-- ═══════════════════════════════════════════════════════════════

-- FUNCIÓN CENTRALIZADA PARA ACTUALIZAR ESTADÍSTICAS
local function UpdateStats()
    if Character and Humanoid then
        -- Speed: Se fuerza constantemente si está activo
        if SpeedEnabled then
            Humanoid.WalkSpeed = SpeedValue
        else
            Humanoid.WalkSpeed = 16
        end

        -- Jump: Se fuerza constantemente si está activo
        if JumpEnabled then
            Humanoid.JumpPower = JumpPower
        else
            Humanoid.JumpPower = 50
        end
    end
end

-- FLY LOGIC
RunService.RenderStepped:Connect(function()
    if FlyEnabled and Character and RootPart then
        local MoveDirection = Vector3.new(0, 0, 0)
        
        -- Controles WASD + Espacio/Shift
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection = MoveDirection + RootPart.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection = MoveDirection - RootPart.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection = MoveDirection - RootPart.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection = MoveDirection + RootPart.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDirection = MoveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
            MoveDirection = MoveDirection - Vector3.new(0, 1, 0) 
        end
        
        if MoveDirection.Magnitude > 0 then
            MoveDirection = MoveDirection.Unit * FlySpeed
        end
        
        BodyVelocity.Velocity = MoveDirection
        BodyGyro.CFrame = Camera.CFrame
    else
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- NOCLIP LOGIC
RunService.Stepped:Connect(function()
    if NoclipEnabled and Character then
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") and Part.CanCollide then
                Part.CanCollide = false
            end
        end
    end
end)

-- LOOP CONSTANTE PARA SPEED/JUMP (ANTI-RESET)
RunService.Heartbeat:Connect(UpdateStats)

-- DETECTAR CAMBIO DE PERSONAJE (RESPAWN)
LocalPlayer.CharacterAdded:Connect(function(Char)
    task.wait(0.5) -- Pequeño delay para asegurar carga
    Character = Char
    Humanoid = Char:WaitForChild("Humanoid")
    RootPart = Char:WaitForChild("HumanoidRootPart")
    
    -- Re-parentear objetos de Fly
    BodyVelocity.Parent = RootPart
    BodyGyro.Parent = RootPart
    
    -- Re-aplicar estados inmediatamente
    UpdateStats()
end)

-- ═══════════════════════════════════════════════════════════════
-- INTERFAZ DE USUARIO (HUB) - SIN SECCIONES, TODO SUELTO
-- ═══════════════════════════════════════════════════════════════

-- TAB 1: MAIN (Bienvenida)
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "Astras Hub Welcome - Steal in Peru",
    Desc = "By - ᴄ++ | ʟᴀᴅɪɴɢ..."
})

-- TAB 2: PLAYER & CHEAT (Todo suelto, sin secciones)
local PlayerTab = Window:Tab({ Title = "Player & Cheat", Icon = "user" })

-- Fly
PlayerTab:Toggle({
    Title = "Activar Fly",
    Value = false,
    Callback = function(state)
        FlyEnabled = state
    end
})

PlayerTab:Slider({
    Title = "Velocidad Fly",
    Value = { Min = 10, Max = 200, Default = 50 },
    Callback = function(value)
        FlySpeed = value
    end
})

-- Noclip
PlayerTab:Toggle({
    Title = "Activar Noclip",
    Value = false,
    Callback = function(state)
        NoclipEnabled = state
    end
})

-- Speed
PlayerTab:Toggle({
    Title = "Activar Speed",
    Value = false,
    Callback = function(state)
        SpeedEnabled = state
        UpdateStats() -- Forzar actualización inmediata
    end
})

PlayerTab:Slider({
    Title = "Velocidad Speed",
    Value = { Min = 16, Max = 200, Default = 50 },
    Callback = function(value)
        SpeedValue = value
        -- SOLUCIÓN: Actualizar siempre que cambie el slider
        if SpeedEnabled then UpdateStats() end
    end
})

-- Jump
PlayerTab:Toggle({
    Title = "Activar Jump",
    Value = false,
    Callback = function(state)
        JumpEnabled = state
        UpdateStats() -- Forzar actualización inmediata
    end
})

PlayerTab:Slider({
    Title = "Altura Jump",
    Value = { Min = 50, Max = 300, Default = 50 },
    Callback = function(value)
        JumpPower = value
        -- SOLUCIÓN: Actualizar siempre que cambie el slider
        if JumpEnabled then UpdateStats() end
    end
})

-- TAB 3: CONFIG (Keybind, Discord y TEMAS)
local ConfigTab = Window:Tab({ Title = "Config", Icon = "settings" })

-- Sección de Configuración Básica
local BasicConfigSection = ConfigTab:Section({
    Title = "Configuración Básica",
    Description = "Teclas y Enlaces",
    Collapsed = false
})

-- Keybind para abrir/cerrar el Hub
BasicConfigSection:Keybind({
    Title = "Tecla para Abrir/Cerrar Hub",
    Value = "RightShift", -- Tecla por defecto
    Callback = function(key)
        -- SOLUCIÓN: Configurar la tecla real de WindUI
        Window:SetToggleKey(key)
        WindUI:Notify({
            Title = "Config",
            Content = "Tecla cambiada a: " .. key,
            Duration = 2
        })
    end
})

-- Link de Discord
BasicConfigSection:Button({
    Title = "Copiar Discord",
    Icon = "message-circle",
    Callback = function()
        setclipboard("https://discord.gg/drR7ZVKPXe")
        WindUI:Notify({
            Title = "Discord",
            Content = "Link copiado al portapapeles.",
            Duration = 2
        })
    end
})

-- Sección de Apariencia (Temas)
local AppearanceSection = ConfigTab:Section({
    Title = "Apariencia",
    Description = "Personaliza el look del hub",
    Collapsed = false
})

-- Dropdown para cambiar el tema
AppearanceSection:Dropdown({
    Title = "Seleccionar Tema",
    Values = {
        "Dark",       -- Negro/Gris oscuro (Por defecto)
        "Light",      -- Blanco/Gris claro
        "Red",        -- Rojo oscuro
        "Sky",        -- Azul cielo
        "Violet",     -- Morado
        "Amber",      -- Ámbar/Dorado
        "Emerald",    -- Verde esmeralda
        "Midnight",   -- Azul medianoche
        "Rainbow"     -- Arcoíris animado
    },
    Default = "Dark",
    Callback = function(value)
        -- Esta función cambia el tema globalmente
        WindUI:SetTheme(value)
        
        WindUI:Notify({
            Title = "Tema Cambiado",
            Content = "El tema ahora es: " .. value,
            Duration = 2
        })
    end
})

-- Botón extra para alternar rápido entre Dark/Light (Opcional)
AppearanceSection:Button({
    Title = "Alternar Dark/Light Rápido",
    Callback = function()
        local current = WindUI:GetCurrentTheme()
        if current == "Dark" then
            WindUI:SetTheme("Light")
        else
            WindUI:SetTheme("Dark")
        end
    end
})

ConfigTab:Paragraph({
    Title = "Info",
    Desc = "AstraHub Zz v1.0\nOptimized by ᴄ++ | ʟᴏᴀɪɴɢ..."
})

print("🟢 ᴄ++ | ʟᴀɴɢ... cargado completamente.")
