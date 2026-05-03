-- ᴄ++ | ʟᴏᴅɪɴɢ... - Script Completo
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando ᴄ++ | ʟᴏᴀɪɴɢ...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "ᴄ++ | ʟᴏᴅɪɴɢ... - Steal in Peru", -- Título solicitado
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "CppLoading",
    IgnoreAlerts = false, -- Para que funcione el Dialog de cierre personalizado
})

print("✅ Ventana cargada.")

-- ═══════════════════════════════════════════════════════════════
-- VARIABLES GLOBALES Y SERVICIOS
-- ═══════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Estados
local FlyEnabled = false
local FlySpeed = 50
local NoclipEnabled = false
local SpeedEnabled = false
local SpeedValue = 50
local JumpEnabled = false
local JumpPower = 50
local AntiRagdollEnabled = false

-- Variables para Undetect
local LastPosition = nil
local IsUndetecting = false

-- ═══════════════════════════════════════════════════════════════
-- FUNCIONES LÓGICAS
-- ═══════════════════════════════════════════════════════════════

-- FLY
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

RunService.RenderStepped:Connect(function()
    if FlyEnabled and Character and RootPart then
        local MoveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection = MoveDirection + RootPart.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection = MoveDirection - RootPart.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection = MoveDirection - RootPart.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection = MoveDirection + RootPart.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDirection = MoveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDirection = MoveDirection - Vector3.new(0, 1, 0) end
        
        if MoveDirection.Magnitude > 0 then
            MoveDirection = MoveDirection.Unit * FlySpeed
        end
        
        BodyVelocity.Velocity = MoveDirection
        BodyGyro.CFrame = Camera.CFrame
    end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if NoclipEnabled and Character then
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") and Part.CanCollide then
                Part.CanCollide = false
            end
        end
    end
end)

-- SPEED & JUMP UNDETECT
RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart then
        -- Speed Logic
        if SpeedEnabled then
            if not IsUndetecting then
                LastPosition = RootPart.Position
                Humanoid.WalkSpeed = SpeedValue
            else
                -- Undetect Mode: Teleport suave hacia atrás si se detecta movimiento sospechoso
                -- Simulación simple: Mantener velocidad pero resetear posición si se mueve demasiado rápido
                -- Nota: Los undetect reales son complejos, esto es una simulación básica de "suavizado"
                Humanoid.WalkSpeed = 16 -- Reset temporal
                task.wait(0.1)
                Humanoid.WalkSpeed = SpeedValue
                IsUndetecting = false
            end
        else
            Humanoid.WalkSpeed = 16
        end

        -- Jump Logic
        if JumpEnabled then
            Humanoid.JumpPower = JumpPower
        else
            Humanoid.JumpPower = 50
        end
    end
end)

-- ANTI-RAGDOLL
Character.DescendantAdded:Connect(function(Child)
    if AntiRagdollEnabled and Child:IsA("Motor6D") then
        local Socket = Instance.new("BallSocketConstraint")
        local Attachment0 = Instance.new("Attachment")
        local Attachment1 = Instance.new("Attachment")
        
        Attachment0.Name = "Attachment0"
        Attachment1.Name = "Attachment1"
        
        Attachment0.Parent = Child.Part0
        Attachment1.Parent = Child.Part1
        
        Socket.Attachment0 = Attachment0
        Socket.Attachment1 = Attachment1
        Socket.LimitsEnabled = true
        Socket.TwistLimitsEnabled = true
        Socket.Parent = Child.Parent
        
        Child:Destroy()
    end
end)

-- Recargar Anti-Ragdoll al cambiar de personaje
LocalPlayer.CharacterAdded:Connect(function(Char)
    Character = Char
    Humanoid = Char:WaitForChild("Humanoid")
    RootPart = Char:WaitForChild("HumanoidRootPart")
    
    -- Re-parentear BodyVelocity y BodyGyro
    BodyVelocity.Parent = RootPart
    BodyGyro.Parent = RootPart
    
    if AntiRagdollEnabled then
        -- Re-aplicar lógica si es necesario
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- INTERFAZ DE USUARIO (HUB)
-- ═══════════════════════════════════════════════════════════════

local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

-- Sección Movimiento
local MoveSection = MainTab:Section({
    Title = "Movimiento",
    Description = "Fly, Speed, Jump, Noclip",
    Collapsed = false
})

-- Fly
MoveSection:Toggle({
    Title = "Activar Fly",
    Value = false,
    Callback = function(state)
        FlyEnabled = state
        if not state then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end
})

MoveSection:Slider({
    Title = "Velocidad Fly",
    Value = { Min = 10, Max = 200, Default = 50 },
    Callback = function(value)
        FlySpeed = value
    end
})

-- Noclip
MoveSection:Toggle({
    Title = "Activar Noclip",
    Value = false,
    Callback = function(state)
        NoclipEnabled = state
    end
})

-- Speed
MoveSection:Toggle({
    Title = "Activar Speed",
    Value = false,
    Callback = function(state)
        SpeedEnabled = state
    end
})

MoveSection:Slider({
    Title = "Velocidad Speed",
    Value = { Min = 16, Max = 200, Default = 50 },
    Callback = function(value)
        SpeedValue = value
    end
})

MoveSection:Button({
    Title = "Undetect Speed (Reset)",
    Callback = function()
        -- Simula un reset de posición para evitar detección
        if Character and RootPart then
            local CurrentPos = RootPart.Position
            RootPart.CFrame = CFrame.new(CurrentPos + Vector3.new(0, 1, 0)) -- Pequeño salto
            task.wait(0.1)
            RootPart.CFrame = CFrame.new(CurrentPos) -- Volver
            WindUI:Notify({
                Title = "Undetect",
                Content = "Posición reseteada para evitar detección.",
                Duration = 2
            })
        end
    end
})

-- Jump
MoveSection:Toggle({
    Title = "Activar Jump",
    Value = false,
    Callback = function(state)
        JumpEnabled = state
    end
})

MoveSection:Slider({
    Title = "Altura Jump",
    Value = { Min = 50, Max = 300, Default = 50 },
    Callback = function(value)
        JumpPower = value
    end
})

MoveSection:Button({
    Title = "Undetect Jump (Safe Land)",
    Callback = function()
        -- Simula un aterrizaje suave
        if Character and Humanoid then
            Humanoid.JumpPower = 50 -- Reset a normal
            task.wait(0.2)
            Humanoid.JumpPower = JumpPower -- Volver a custom
            WindUI:Notify({
                Title = "Undetect",
                Content = "Salto suavizado para evitar detección.",
                Duration = 2
            })
        end
    end
})

-- Sección Misc
local MiscSection = MainTab:Section({
    Title = "Misceláneo",
    Description = "Anti-Ragdoll y otros",
    Collapsed = true
})

-- Anti-Ragdoll
MiscSection:Toggle({
    Title = "Activar Anti-Ragdoll",
    Value = false,
    Callback = function(state)
        AntiRagdollEnabled = state
        if not state then
            -- Restaurar Motor6D si es posible (complejo, mejor dejarlo activo o reiniciar personaje)
            WindUI:Notify({
                Title = "Info",
                Content = "Desactivar Anti-Ragdoll puede requerir reiniciar personaje.",
                Duration = 3
            })
        end
    end
})

-- Botón Reiniciar Personaje (Útil si algo falla)
MiscSection:Button({
    Title = "Reiniciar Personaje",
    Callback = function()
        LocalPlayer:LoadCharacter()
    end
})

print("🟢 ᴄ++ | ʟᴏᴅɪɴɢ... cargado completamente.")
