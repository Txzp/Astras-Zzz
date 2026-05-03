-- ASTRA HUB ZZ - Intro Visual Final (Stroke Directo en Texto)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
-- 1. INTRO VISUAL FINAL (Stroke Directo + Blanco + Sin Fondo)
-- ═══════════════════════════════════════════════════════════════

-- Crear Pantalla de Carga
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "AstraIntroFinal"
IntroGui.Parent = game.CoreGui
IntroGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- NOTA: No creamos ningún Frame de fondo. Solo los textos.

-- Texto Principal (Grande, Elegante y con Borde Negro Directo)
local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(0, 700, 0, 120) -- Grande
IntroText.Position = UDim2.new(0.5, -350, 0.5, -60) -- Centrado
IntroText.BackgroundTransparency = 1 -- Sin fondo
IntroText.Text = "ASTRAS HUB ZZ"
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Blanco Puro
IntroText.TextSize = 90 -- Muy grande
IntroText.Font = Enum.Font.GothamBold

-- CAMBIO CLAVE: Stroke directo en el TextLabel
IntroText.TextStrokeTransparency = 0 -- Visible
IntroText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Negro
-- Nota: El grosor del stroke en TextLabel es fijo por el motor, 
-- pero al ser blanco sobre negro se ve nítido. Si necesitas más grosor visual, 
-- puedes duplicar el texto detrás con un tamaño ligeramente mayor, 
-- pero este método es el estándar limpio.

IntroText.Parent = IntroGui

-- Subtítulo Pequeño (Más Abajo y Visible)
local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(0, 300, 0, 30)
SubText.Position = UDim2.new(0.5, -150, 0.5, 80) -- Bajado a Y=80 (más separado)
SubText.BackgroundTransparency = 1 -- Sin fondo
SubText.Text = "by Tz-hzk | v1.0"
SubText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Blanco Puro
SubText.TextSize = 26
SubText.Font = Enum.Font.GothamMedium

-- CAMBIO CLAVE: Stroke directo en el SubTexto también
SubText.TextStrokeTransparency = 0 -- Visible
SubText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Negro

SubText.Parent = IntroGui

-- Animación Controlada
task.spawn(function()
    -- 1. Estado Inicial: Invisible y pequeño
    IntroText.TextTransparency = 1
    SubText.TextTransparency = 1
    
    local UIScale = Instance.new("UIScale")
    UIScale.Scale = 0.5
    UIScale.Parent = IntroText
    
    -- 2. RETRASO FORZADO DE 0.1 SEGUNDOS (Muy rápido)
    task.wait(0.1)

    -- 3. Animación de Entrada (Zoom-In Suave)
    local TweenInfoIn = TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    -- Aparecer Texto Principal
    TweenService:Create(IntroText, TweenInfoIn, { TextTransparency = 0 }):Play()
    TweenService:Create(UIScale, TweenInfoIn, { Scale = 1.1 }):Play()
    
    -- Aparecer Subtítulo con un poco de retraso
    task.wait(0.1)
    TweenService:Create(SubText, TweenInfoIn, { TextTransparency = 0 }):Play() -- Totalmente opaco

    -- 4. Tiempo de Lectura (Mantener visible)
    task.wait(1.2) -- Se queda visible 1.2 segundos

    -- 5. Animación de Salida (Desvanecimiento Rápido)
    local TweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    
    TweenService:Create(IntroText, TweenInfoOut, { TextTransparency = 1 }):Play()
    TweenService:Create(SubText, TweenInfoOut, { TextTransparency = 1 }):Play()
    TweenService:Create(UIScale, TweenInfoOut, { Scale = 1.5 }):Play() -- Se agranda al desaparecer

    -- 6. Destruir GUI
    task.wait(0.6)
    IntroGui:Destroy()
end)

-- ═══════════════════════════════════════════════════════════════
-- 2. CARGAR WINDUI Y CREAR EL HUB
-- ═══════════════════════════════════════════════════════════════

-- Pequeña pausa extra para asegurar estabilidad visual
task.wait(0.2)

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
