-- ASTRA HUB ZZ - Testing Completo de TODOS los Componentes
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando Testing Completo...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz",
    Theme = "Dark", -- Tema por defecto
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZZ",
    IgnoreAlerts = false, -- Para que funcione el Dialog de cierre personalizado (Rojo)
})

print("✅ Ventana cargada.")

-- ═══════════════════════════════════════════════════════════════
-- TAB 1: MAIN (Componentes Básicos)
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

-- 1. Paragraph
MainTab:Paragraph({
    Title = "👋 Bienvenido al Testing",
    Desc = "Este hub prueba todos los componentes de WindUI.\nSliders Verdes, Dialog Rojo, Temas."
})

MainTab:Divider() -- Línea divisoria

-- 2. Button
MainTab:Button({
    Title = "Probar Notificación",
    Callback = function()
        WindUI:Notify({
            Title = "Éxito",
            Content = "El botón funciona correctamente.",
            Duration = 2
        })
    end
})

-- 3. Toggle
MainTab:Toggle({
    Title = "Activar Función A",
    Value = false,
    Callback = function(state)
        print("Toggle A:", state)
    end
})

-- 4. Slider (Verde por modificación en main.lua)
MainTab:Slider({
    Title = "Velocidad (Verde)",
    Value = { Min = 16, Max = 120, Default = 50 },
    Callback = function(v) 
        print("Speed:", v)
    end
})

-- 5. Input
MainTab:Input({
    Title = "Nombre de Usuario",
    Placeholder = "Escribe tu nombre...",
    Callback = function(value)
        print("Input:", value)
    end
})

-- 6. Dropdown
MainTab:Dropdown({
    Title = "Selecciona Opción",
    Values = {"Opción 1", "Opción 2", "Opción 3"},
    Default = "Opción 1",
    Callback = function(value)
        print("Dropdown:", value)
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 2: AVANZADO (Keybinds, Colorpickers, Code)
-- ═══════════════════════════════════════════════════════════════
local AdvancedTab = Window:Tab({ Title = "Avanzado", Icon = "settings" })

-- 7. Keybind
AdvancedTab:Keybind({
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

-- 8. Colorpicker
AdvancedTab:Colorpicker({
    Title = "Color de ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Color Escogido:", color)
    end
})

-- 9. Code Block
AdvancedTab:Code({
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
-- TAB 3: VISUAL (Images, Groups, Spaces)
-- ═══════════════════════════════════════════════════════════════
local VisualTab = Window:Tab({ Title = "Visual", Icon = "image" })

-- 10. Image
VisualTab:Image({
    Image = "rbxassetid://1234567890", -- ID de imagen de ejemplo
    AspectRatio = "16:9",
    Radius = 12
})

VisualTab:Space() -- Espacio vacío

-- 11. Group (Horizontal)
VisualTab:Group({
    VisualTab:Button({
        Title = "Botón 1",
        Callback = function() print("Btn 1") end
    }),
    VisualTab:Button({
        Title = "Botón 2",
        Callback = function() print("Btn 2") end
    }),
})

-- 12. Section (Desplegable)
local MySection = VisualTab:Section({
    Title = "Sección Desplegable",
    Description = "Haz clic para expandir",
    Opened = false
})

MySection:Toggle({
    Title = "Toggle dentro de Sección",
    Value = false,
    Callback = function(state) print("Section Toggle:", state) end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 4: SETTINGS (Temas y Config)
-- ═══════════════════════════════════════════════════════════════
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "info" })

-- 13. Theme Selector
SettingsTab:Dropdown({
    Title = "Seleccionar Tema",
    Values = {
        "Dark",       -- Negro/Gris oscuro
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
        WindUI:SetTheme(value)
        WindUI:Notify({
            Title = "Tema Cambiado",
            Content = "El tema ahora es: " .. value,
            Duration = 2
        })
    end
})

-- 14. Dialog Test (Para probar el Dialog Rojo al cerrar)
SettingsTab:Button({
    Title = "Probar Dialog Personalizado",
    Callback = function()
        WindUI:Popup({
            Title = "Dialog de Prueba",
            Content = "Este es un dialog de prueba. Al cerrar la ventana principal, verás el Dialog Rojo personalizado.",
            Buttons = {
                {
                    Title = "Cerrar",
                    Variant = "Primary",
                    Callback = function() end
                }
            }
        })
    end
})

SettingsTab:Paragraph({
    Title = "Info Final",
    Desc = "Testing Completo Finalizado.\nTodos los componentes están presentes."
})

print("🟢 Testing Completo cargado completamente.")
