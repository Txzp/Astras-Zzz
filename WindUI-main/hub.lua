-- ASTRA HUB ZZ - Con Intro Visual
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
-- 1. INTRO VISUAL (Aparece antes del Hub)
-- ═══════════════════════════════════════════════════════════════

-- Crear Pantalla de Carga
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "AstraIntro"
IntroGui.Parent = game.CoreGui
IntroGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fondo Negro
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = IntroGui

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(0, 300, 0, 50)
IntroText.Position = UDim2.new(0.5, -150, 0.5, -25)
IntroText.BackgroundTransparency = 1
IntroText.Text = "ASTRAS HUB ZZ"
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.TextSize = 40
IntroText.Font = Enum.Font.GothamBold
IntroText.Parent = IntroFrame

-- Animación de Desvanecimiento (Fade Out)
task.spawn(function()
    task.wait(2.5) -- Tiempo que dura la intro visible
    
    -- Desvanecer Texto
    local TweenInfoText = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local GoalText = { TextTransparency = 1 }
    local TweenText = TweenService:Create(IntroText, TweenInfoText, GoalText)
    TweenText:Play()
    
    -- Desvanecer Fondo
    local TweenInfoBg = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local GoalBg = { BackgroundTransparency = 1 }
    local TweenBg = TweenService:Create(IntroFrame, TweenInfoBg, GoalBg)
    TweenBg:Play()
    
    -- Destruir GUI después de la animación
    task.wait(0.6)
    IntroGui:Destroy()
end)

-- ═══════════════════════════════════════════════════════════════
-- 2. CARGAR WINDUI Y CREAR EL HUB
-- ═══════════════════════════════════════════════════════════════

-- Pequeña pausa para asegurar que la intro se vea bien antes de cargar la librería
task.wait(0.5)

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando AstraHub Zz...")

local Window = WindUI:CreateWindow({
    Title = "ASTRA HUB ZZ",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZZ",
    IgnoreAlerts = true, -- Usa nuestro Dialog personalizado
})

print("✅ Ventana cargada.")

-- ═══════════════════════════════════════════════════════════════
-- 3. CONTENIDO DEL HUB (Ejemplo Básico)
-- ═══════════════════════════════════════════════════════════════

local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "Bienvenido",
    Desc = "La intro ha terminado. El Hub está listo."
})

MainTab:Button({
    Title = "Probar Botón",
    Callback = function()
        print("Botón presionado")
    end
})

print("🟢 AstraHub Zz cargado completamente.")
