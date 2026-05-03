-- ASTRA HUB ZZ - Testing Completo (Sin Intro, Sin KeySystem) + Slider Transparencia
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
-- TAB 1: MAIN (Bienvenida y Componentes Básicos)
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

-- Sección de Bienvenida
local WelcomeSection = MainTab:Section({
    Title = "Bienvenido",
    Description = "Estado del sistema",
    Collapsed = false
})

WelcomeSection:Paragraph({
    Title = "👋 Hola, " .. game.Players.LocalPlayer.DisplayName,
    Desc = "Sistema cargado correctamente.\nModificaciones activas: Sliders Verdes, Dialog Rojo."
})

-- Sección de Controles Básicos
local BasicSection = MainTab:Section({
    Title = "Controles Básicos",
    Description = "Botones, Toggles, Inputs",
    Collapsed = false
})

BasicSection:Toggle({
    Title = "Activar Función A",
    Value = false,
    Callback = function(state)
        print("Función A:", state)
    end
})

BasicSection:Button({
    Title = "Probar Notificación",
    Callback = function()
        WindUI:Notify({
            Title = "Éxito",
            Content = "El hub funciona perfectamente.",
            Duration = 2
        })
    end
})

BasicSection:Input({
    Title = "Nombre de Usuario",
    Placeholder = "Escribe tu nombre...",
    Callback = function(value)
        print("Input:", value)
    end
})

BasicSection:Dropdown({
    Title = "Selecciona Opción",
    Values = {"Opción 1", "Opción 2", "Opción 3"},
    Default = "Opción 1",
    Callback = function(value)
        print("Dropdown:", value)
    end
})

-- Sección de Sliders (Verdes por modificación en main.lua)
local SliderSection = MainTab:Section({
    Title = "Sliders (Verdes)",
    Description = "Prueba de deslizadores",
    Collapsed = true
})

SliderSection:Slider({
    Title = "Velocidad (Verde)",
    Value = { Min = 16, Max = 120, Default = 50 },
    Callback = function(v) 
        print("Speed:", v)
    end
})

SliderSection:Slider({
    Title = "Opacidad ESP (Verde)",
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Increment = 0.1,
    Callback = function(v)
        print("ESP Opacity:", v)
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 2: AVANZADO (Keybinds, Colorpickers, Code)
-- ═══════════════════════════════════════════════════════════════
local AdvancedTab = Window:Tab({ Title = "Avanzado", Icon = "settings" })

-- Sección de Keybinds
local KeybindSection = AdvancedTab:Section({
    Title = "Keybinds",
    Description = "Teclas rápidas",
    Collapsed = false
})

KeybindSection:Keybind({
    Title = "Tecla de Atajo",
    Value = "Q", -- Tecla por defecto
    Callback = function(key)
        print("Keybind Presionado:", key)
        WindUI:Notify({
            Title = "Keybind",
            Content = "Presionaste: " .. key,
            Duration = 1
        })
    end
})

-- Sección de Colorpickers
local ColorSection = AdvancedTab:Section({
    Title = "Colorpickers",
    Description = "Selectores de color",
    Collapsed = false
})

ColorSection:Colorpicker({
    Title = "Color de ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Color Escogido:", color)
    end
})

ColorSection:Colorpicker({
    Title = "Color de Fondo",
    Default = Color3.fromRGB(0, 0, 0),
    Transparency = 0.5, -- Con transparencia
    Callback = function(color, transparency)
        print("Color:", color, "Transparency:", transparency)
    end
})

-- Sección de Código
local CodeSection = AdvancedTab:Section({
    Title = "Código",
    Description = "Bloques de código",
    Collapsed = true
})

CodeSection:Code({
    Title = "Ejemplo Lua",
    Code = [[
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("Hola, " .. LocalPlayer.Name)
    ]],
    OnCopy = function()
        WindUI:Notify({
            Title = "Copiado",
            Content = "Código copiado al portapapeles.",
            Duration = 2
        })
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 3: SETTINGS (Temas, Config y Transparencia)
-- ═══════════════════════════════════════════════════════════════
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "info" })

local SettingsSection = SettingsTab:Section({
    Title = "Apariencia",
    Description = "Personaliza el look del hub",
    Collapsed = false
})

-- Dropdown para cambiar el tema
SettingsSection:Dropdown({
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
SettingsSection:Button({
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

-- ═══════════════════════════════════════════════════════════════
-- NUEVA SECCIÓN: TRANSPARENCIA DEL HUB
-- ═══════════════════════════════════════════════════════════════
local TransparencySection = SettingsTab:Section({
    Title = "Transparencia",
    Description = "Ajusta la opacidad de la ventana",
    Collapsed = false
})

-- Slider para controlar la transparencia del Hub
TransparencySection:Slider({
    Title = "Opacidad del Hub (%)",
    Value = { Min = 10, Max = 100, Default = 100 }, -- 100% = Opaco, 10% = Muy transparente
    Callback = function(value)
        -- Convertir porcentaje (10-100) a transparencia (0.9-0.0)
        local transparency = 1 - (value / 100)
        
        -- Aplicar transparencia al fondo principal de la ventana
        if Window and Window.UIElements and Window.UIElements.Main then
            -- Fondo principal (el frame grande)
            if Window.UIElements.Main.Background then
                Window.UIElements.Main.Background.ImageTransparency = transparency
            end
            
            -- Fondo de la barra lateral (si existe)
            if Window.UIElements.SideBarContainer and Window.UIElements.SideBarContainer.Frame then
                 -- Nota: La estructura exacta puede variar ligeramente según la versión de WindUI
                 -- Pero generalmente el fondo principal controla la mayoría de la transparencia
            end
            
            -- Si usas Acrylic, también ajustamos su transparencia
            if Window.AcrylicPaint and Window.AcrylicPaint.Model then
                Window.AcrylicPaint.Model.Transparency = transparency + 0.1 -- Un poco más transparente para el efecto acrílico
            end
        end
        
        print("Transparencia del Hub:", value .. "%")
    end
})

-- Link de Discord
SettingsSection:Button({
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

SettingsSection:Paragraph({
    Title = "Info",
    Desc = "AstraHub Zz v1.0\nOptimized by ᴄ++ | ʟᴏɪɴɢ..."
})

print("🟢 AstraHub Zz cargado completamente.")
