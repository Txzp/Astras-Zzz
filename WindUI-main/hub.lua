-- ASTRA HUB ZZ - Script Principal
-- Carga TU WindUI Modificado desde GitHub
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando AstraHub Zz...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA Y KEYSYSTEM
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "ASTRA HUB ZZ",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZZ",
    IgnoreAlerts = true, -- Importante para usar nuestro Dialog personalizado
    
    KeySystem = {
        Title = "Verificación de Licencia",
        Note = "Introduce tu clave para acceder.",
        Key = "Testing 2", -- <--- TU CLAVE AQUÍ
        SaveKey = true,    -- Guarda la clave para no pedirla siempre
    }
})

print("✅ Clave correcta. Cargando interfaz...")

-- ═══════════════════════════════════════════════════════════════
-- TAB PRINCIPAL (Usamos Secciones para organizar)
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

-- Sección 1: Bienvenida
local WelcomeSection = MainTab:Section({
    Title = "Bienvenido",
    Description = "Estado del sistema",
    Collapsed = false
})

WelcomeSection:Paragraph({
    Title = "👋 Hola, " .. game.Players.LocalPlayer.DisplayName,
    Desc = "Sistema cargado correctamente.\nModificaciones activas: Sliders Verdes, Dialog Rojo."
})

-- Sección 2: Prueba de Sliders (DEBEN SER VERDES)
local SliderSection = MainTab:Section({
    Title = "Prueba de Sliders",
    Description = "Verifica el color verde",
    Collapsed = false
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

-- Sección 3: Controles Variados
local ControlSection = MainTab:Section({
    Title = "Controles",
    Description = "Botones y Toggles",
    Collapsed = true
})

ControlSection:Toggle({
    Title = "Activar Función A",
    Value = false,
    Callback = function(state)
        print("Función A:", state)
    end
})

ControlSection:Button({
    Title = "Probar Notificación",
    Callback = function()
        WindUI:Notify({
            Title = "Éxito",
            Content = "El hub funciona perfectamente.",
            Duration = 2
        })
    end
})

ControlSection:Dropdown({
    Title = "Selecciona Opción",
    Values = {"Opción 1", "Opción 2", "Opción 3"},
    Default = "Opción 1",
    Callback = function(value)
        print("Selected:", value)
    end
})

-- Sección 4: Info y Links
local InfoSection = MainTab:Section({
    Title = "Info & Links",
    Description = "Recursos útiles",
    Collapsed = true
})

InfoSection:Paragraph({
    Title = "Modificaciones Activas",
    Desc = "✅ Slider Verde\n✅ Dialog Personalizado (Rojo)\n✅ KeySystem Integrado"
})

InfoSection:Button({
    Title = "Copiar Discord",
    Callback = function()
        setclipboard("https://discord.gg/drR7ZVKPXe")
        WindUI:Notify({
            Title = "Discord",
            Content = "Link copiado al portapapeles.",
            Duration = 2
        })
    end
})

print("🟢 AstraHub Zz cargado completamente.")
