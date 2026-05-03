-- AstraHub Zz - Script Final con Fix REAL de Transparencia de Frames
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando AstraHub Zz...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZZ",
    IgnoreAlerts = false, -- Para que funcione el Dialog de cierre personalizado
})

print("✅ Ventana cargada.")

-- ═══════════════════════════════════════════════════════════════
-- TAB 1: MAIN
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "Astras Hub Welcome",
    Desc = "By - ᴄ++ | ʟᴏᴀɴɢ..."
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 2: PLAYER & CHEAT
-- ═══════════════════════════════════════════════════════════════
local PlayerTab = Window:Tab({ Title = "Player & Cheat", Icon = "user" })

PlayerTab:Toggle({
    Title = "Activar Fly",
    Value = false,
    Callback = function(state) print("Fly:", state) end
})

PlayerTab:Slider({
    Title = "Velocidad Fly",
    Value = { Min = 10, Max = 200, Default = 50 },
    Callback = function(value) print("Fly Speed:", value) end
})

PlayerTab:Toggle({
    Title = "Activar Noclip",
    Value = false,
    Callback = function(state) print("Noclip:", state) end
})

PlayerTab:Toggle({
    Title = "Activar Speed",
    Value = false,
    Callback = function(state) print("Speed:", state) end
})

PlayerTab:Slider({
    Title = "Velocidad Speed",
    Value = { Min = 16, Max = 200, Default = 50 },
    Callback = function(value) print("Speed Value:", value) end
})

PlayerTab:Toggle({
    Title = "Activar Jump",
    Value = false,
    Callback = function(state) print("Jump:", state) end
})

PlayerTab:Slider({
    Title = "Altura Jump",
    Value = { Min = 50, Max = 300, Default = 50 },
    Callback = function(value) print("Jump Power:", value) end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 3: SETTINGS (Temas, Config y Transparencias REALES)
-- ═══════════════════════════════════════════════════════════════
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

-- Sección de Configuración Básica
local BasicConfigSection = SettingsTab:Section({
    Title = "Configuración Básica",
    Description = "Teclas y Enlaces",
    Collapsed = false
})

-- Keybind para abrir/cerrar el Hub
BasicConfigSection:Keybind({
    Title = "Tecla para Abrir/Cerrar Hub",
    Value = "RightShift",
    Callback = function(key)
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
local AppearanceSection = SettingsTab:Section({
    Title = "Apariencia",
    Description = "Personaliza el look del hub",
    Collapsed = false
})

-- Dropdown para cambiar el tema
AppearanceSection:Dropdown({
    Title = "Seleccionar Tema",
    Values = {
        "Dark", "Light", "Red", "Sky", "Violet", "Amber", "Emerald", "Midnight", "Rainbow"
    },
    Default = "Dark",
    Callback = function(value)
        WindUI:SetTheme(value)
        WindUI:Notify({
            Title = "Tema Cambiado",
            Content = "El tema ahora es: " .. value,
            Duration = 2
        })
    end
})

-- Botón extra para alternar rápido entre Dark/Light
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

-- Sección de Transparencias
local TransparencySection = SettingsTab:Section({
    Title = "Transparencias",
    Description = "Ajusta la opacidad del Hub y los Frames",
    Collapsed = false
})

-- Slider para controlar la transparencia general del Hub (Fondo Principal)
TransparencySection:Slider({
    Title = "Opacidad del Hub (%)",
    Value = { Min = 10, Max = 100, Default = 100 },
    Callback = function(value)
        local transparency = 1 - (value / 100)
        
        -- Aplicar transparencia al fondo principal de la ventana
        if Window and Window.UIElements and Window.UIElements.Main then
            if Window.UIElements.Main.Background then
                Window.UIElements.Main.Background.ImageTransparency = transparency
            end
            
            -- Si usas Acrylic, también ajustamos su transparencia
            if Window.AcrylicPaint and Window.AcrylicPaint.Model then
                Window.AcrylicPaint.Model.Transparency = transparency + 0.1
            end
        end
        
        print("Transparencia del Hub:", value .. "%")
    end
})

-- NUEVO: Slider para controlar la transparencia de los FRAMES internos (REAL)
TransparencySection:Slider({
    Title = "Opacidad de Frames Internos (%)",
    Value = { Min = 0, Max = 100, Default = 100 }, -- 100% = Opaco, 0% = Invisible
    Callback = function(value)
        local frameTransparency = 1 - (value / 100)
        
        -- Recorrer todos los elementos creados en todas las tabs
        for _, tab in pairs(Window.TabModule.Tabs) do
            if tab.Elements then
                for _, element in pairs(tab.Elements) do
                    -- Buscar el frame principal del elemento (usualmente llamado "Main" o similar)
                    if element.ElementFrame then
                        -- WindUI usa ImageLabels con nombre "Frame" o "Main" para los fondos de los elementos
                        local mainFrame = element.ElementFrame:FindFirstChild("Main") or element.ElementFrame:FindFirstChild("Frame")
                        
                        if mainFrame and mainFrame:IsA("ImageLabel") then
                            -- Ajustar la transparencia del fondo del elemento
                            mainFrame.ImageTransparency = math.clamp(frameTransparency, 0, 1)
                        end
                        
                        -- También ajustar el borde si existe (Outline)
                        local outline = element.ElementFrame:FindFirstChild("Outline")
                        if outline and outline:IsA("ImageLabel") then
                            outline.ImageTransparency = math.clamp(frameTransparency + 0.2, 0, 1) -- Un poco más visible para mantener definición
                        end
                    end
                end
            end
        end
        
        print("Transparencia de Frames Internos:", value .. "%")
    end
})

SettingsTab:Paragraph({
    Title = "Info",
    Desc = "AstraHub Zz v1.0\nOptimized by ᴄ++ | ʟᴏɴɢ..."
})

print("🟢 AstraHub Zz cargado completamente.")
