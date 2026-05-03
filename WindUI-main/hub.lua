-- AstraHub Zz - Script con Consola de Logs Funcional
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

print("🔄 Iniciando AstraHub Zz con Debug Console...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz [DEBUG]",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZz",
    IgnoreAlerts = false,
})

print("✅ Ventana cargada.")

-- ═══════════════════════════════════════════════════════════════
-- CONSOLA DE LOGS VISUAL (Funcional)
-- ═══════════════════════════════════════════════════════════════
local DebugTab = Window:Tab({ Title = "Debug Console", Icon = "terminal" })

-- Creamos un ScrollingFrame manual para los logs
local LogContainer = Instance.new("ScrollingFrame")
LogContainer.Size = UDim2.new(1, 0, 1, 0)
LogContainer.BackgroundTransparency = 1
LogContainer.ScrollBarThickness = 4
LogContainer.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
LogContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
LogContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
LogContainer.ClipsDescendants = true
LogContainer.Parent = DebugTab.ContainerFrame -- Añadimos directamente al contenedor de la tab

-- Layout para organizar los logs verticalmente
local LogLayout = Instance.new("UIListLayout")
LogLayout.Padding = UDim.new(0, 4)
LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogLayout.Parent = LogContainer

-- Función para agregar logs a la consola visual
local function AddLog(message, type)
    local color = Color3.fromRGB(255, 255, 255)
    if type == "ERROR" then color = Color3.fromRGB(255, 50, 50) end
    if type == "SUCCESS" then color = Color3.fromRGB(50, 255, 50) end
    if type == "WARN" then color = Color3.fromRGB(255, 165, 0) end
    
    print("[" .. type .. "] " .. message) -- También imprime en la consola F9
    
    -- Creamos un Label para el log
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, -10, 0, 20) -- Un poco de margen horizontal
    LogLabel.BackgroundTransparency = 0.8
    LogLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    LogLabel.Text = "[" .. os.date("%H:%M:%S") .. "] " .. message
    LogLabel.TextColor3 = color
    LogLabel.TextSize = 14
    LogLabel.Font = Enum.Font.Code
    LogLabel.TextXAlignment = "Left"
    LogLabel.TextYAlignment = "Center"
    LogLabel.BorderSizePixel = 0
    LogLabel.Parent = LogContainer
    
    -- Auto-scroll al final
    task.spawn(function()
        task.wait()
        LogContainer.CanvasPosition = Vector2.new(0, LogContainer.AbsoluteCanvasSize.Y)
    end)
end

AddLog("Consola de Debug iniciada...", "SUCCESS")

-- ═══════════════════════════════════════════════════════════════
-- MONITOREO DE TECLAS (RAW INPUT) PARA DEBUGGING
-- ═══════════════════════════════════════════════════════════════

-- Monitoreamos TODAS las teclas presionadas para ver si Roblox las detecta
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local keyName = input.KeyCode.Name
        
        -- Solo logueamos teclas relevantes para no saturar
        if keyName == "RightShift" or keyName == "Q" or keyName == "Insert" or keyName == "Home" then
            AddLog("Tecla Detectada: " .. keyName .. " | GameProcessed: " .. tostring(gameProcessed), "WARN")
            
            -- Verificamos si WindUI tiene la tecla configurada
            if Window and Window.ToggleKey then
                if Window.ToggleKey == input.KeyCode then
                    AddLog("✅ MATCH: La tecla coincide con Window.ToggleKey (" .. Window.ToggleKey.Name .. ")", "SUCCESS")
                else
                    AddLog("❌ NO MATCH: Window.ToggleKey es " .. (Window.ToggleKey and Window.ToggleKey.Name or "NIL"), "ERROR")
                end
            else
                AddLog("❌ ERROR CRÍTICO: Window.ToggleKey es NIL", "ERROR")
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- TAB PRINCIPAL Y KEYBIND TEST
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "Prueba de Keybind",
    Desc = "Usa la consola de Debug para ver qué ocurre cuando presionas la tecla."
})

-- Keybind de WindUI
local kb = MainTab:Keybind({
    Title = "Tecla Abrir/Cerrar (WindUI)",
    Value = "RightShift",
    Callback = function(key)
        AddLog("Callback del Keybind ejecutado: " .. key, "SUCCESS")
    end
})

-- Botón para forzar cambio de tecla y ver si se actualiza
MainTab:Button({
    Title = "Forzar ToggleKey a 'Q'",
    Callback = function()
        Window:SetToggleKey(Enum.KeyCode.Q)
        AddLog("Se ha ejecutado Window:SetToggleKey(Enum.KeyCode.Q)", "WARN")
        AddLog("Nuevo valor de Window.ToggleKey: " .. (Window.ToggleKey and Window.ToggleKey.Name or "NIL"), "SUCCESS")
    end
})

MainTab:Button({
    Title = "Forzar ToggleKey a 'RightShift'",
    Callback = function()
        Window:SetToggleKey(Enum.KeyCode.RightShift)
        AddLog("Se ha ejecutado Window:SetToggleKey(Enum.KeyCode.RightShift)", "WARN")
        AddLog("Nuevo valor de Window.ToggleKey: " .. (Window.ToggleKey and Window.ToggleKey.Name or "NIL"), "SUCCESS")
    end
})

-- Mostrar el estado actual al inicio
task.wait(1)
AddLog("Estado Inicial Window.ToggleKey: " .. (Window.ToggleKey and Window.ToggleKey.Name or "NIL"), "WARN")

print("🟢 AstraHub Zz con Debug cargado completamente.")
