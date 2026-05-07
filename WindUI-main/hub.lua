-- Diagnóstico de Fallo de KeySystem Nativo
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

print("🔄 [DIAGNOSTIC] Iniciando diagnóstico profundo...")

-- ═══════════════════════════════════════════════════════════════
-- CONSOLA DE DIAGNÓSTICO VISUAL
-- ═══════════════════════════════════════════════════════════════

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DiagnosticConsole"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Background.BackgroundTransparency = 0.05
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local ConsoleFrame = Instance.new("ScrollingFrame")
ConsoleFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
ConsoleFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ConsoleFrame.BackgroundTransparency = 0.2
ConsoleFrame.BorderSizePixel = 0
ConsoleFrame.ClipsDescendants = true
ConsoleFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ConsoleFrame.ScrollBarThickness = 6
ConsoleFrame.Parent = Background

local LogLayout = Instance.new("UIListLayout")
LogLayout.Padding = UDim.new(0, 4)
LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogLayout.Parent = ConsoleFrame

local function Log(message, type)
    local color = Color3.fromRGB(200, 200, 200)
    if type == "ERROR" then color = Color3.fromRGB(255, 50, 50) end
    if type == "SUCCESS" then color = Color3.fromRGB(50, 255, 50) end
    if type == "WARN" then color = Color3.fromRGB(255, 165, 0) end
    if type == "INFO" then color = Color3.fromRGB(100, 200, 255) end
    
    print("[" .. type .. "] " .. message) -- También en F9
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.BackgroundTransparency = 0.9
    Label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Label.Text = "[" .. os.date("%H:%M:%S") .. "] " .. message
    Label.TextColor3 = color
    Label.TextSize = 14
    Label.Font = Enum.Font.Code
    Label.TextXAlignment = "Left"
    Label.TextYAlignment = "Center"
    Label.BorderSizePixel = 0
    Label.Parent = ConsoleFrame
    
    task.spawn(function()
        task.wait()
        ConsoleFrame.CanvasPosition = Vector2.new(0, ConsoleFrame.AbsoluteCanvasSize.Y)
    end)
end

Log("Consola de Diagnóstico Iniciada...", "SUCCESS")

-- ═══════════════════════════════════════════════════════════════
-- PASO 1: VERIFICAR ACCESO A LA URL DE CLAVES
-- ═══════════════════════════════════════════════════════════════

local KEY_URL = "https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/keys.json"

Log("Paso 1: Verificando acceso a la URL de claves...", "INFO")
Log("URL: " .. KEY_URL, "INFO")

local success, result = pcall(function()
    return game:HttpGet(KEY_URL)
end)

if success then
    Log("✅ Conexión a la URL exitosa.", "SUCCESS")
    Log("Contenido recibido: " .. string.sub(result, 1, 100), "INFO") -- Muestra los primeros 100 caracteres
    
    -- Verificar si es JSON válido
    local jsonSuccess, jsonTable = pcall(function()
        return HttpService:JSONDecode(result)
    end)
    
    if jsonSuccess then
        Log("✅ JSON decodificado correctamente.", "SUCCESS")
        Log("Claves encontradas: " .. #jsonTable, "INFO")
        for i, key in ipairs(jsonTable) do
            Log("  - Clave #" .. i .. ": " .. tostring(key), "INFO")
        end
    else
        Log("❌ ERROR: El contenido NO es un JSON válido.", "ERROR")
        Log("Error de decodificación: " .. tostring(jsonTable), "ERROR")
    end
else
    Log("❌ ERROR: No se pudo conectar a la URL.", "ERROR")
    Log("Mensaje de error: " .. tostring(result), "ERROR")
end

-- ═══════════════════════════════════════════════════════════════
-- PASO 2: INTENTAR CARGAR WINDUI CON KEYSYSTEM
-- ═══════════════════════════════════════════════════════════════

Log("", "INFO")
Log("Paso 2: Intentando cargar WindUI con KeySystem...", "INFO")

local WindUILoaded = false
local Window = nil

local loadSuccess, loadError = pcall(function()
    local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()
    
    Log("✅ Librería WindUI cargada.", "SUCCESS")
    
    -- Intentar crear ventana con KeySystem
    Window = WindUI:CreateWindow({
        Title = "AstraHub Zz [DIAGNOSTIC]",
        Theme = "Dark",
        Size = UDim2.fromOffset(480, 420),
        Folder = "AstraHubZz",
        
        -- Configuración de KeySystem Nativo
        KeySystem = {
            Enabled = true,
            KeyURL = KEY_URL,
            Description = "Diagnóstico de KeySystem"
        }
    })
    
    Log("✅ Ventana creada sin errores inmediatos.", "SUCCESS")
    WindUILoaded = true
end)

if not loadSuccess then
    Log("❌ ERROR CRÍTICO al crear la ventana con KeySystem.", "ERROR")
    Log("Mensaje de error: " .. tostring(loadError), "ERROR")
    Log("Posible causa: El módulo de KeySystem en main.lua está roto o falta.", "WARN")
else
    Log("✅ Proceso completado. Si ves esta consola, el KeySystem NO mostró su UI.", "WARN")
    Log("Esto significa que la función CreateWindow no lanzó error, pero tampoco renderizó la pantalla de clave.", "WARN")
    Log("Causa probable: La lógica de renderizado del KeySystem en main.lua está comentada o eliminada.", "ERROR")
end

-- Botón para cerrar diagnóstico
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 100, 0, 30)
CloseBtn.Position = UDim2.new(0.5, -50, 0.9, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "Cerrar Diagnóstico"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Background

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("🟢 Diagnóstico completado. Revisa la consola visual en pantalla.")
