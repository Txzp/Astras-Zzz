-- Testing KeySystem Nativo de WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 [KEYSYSTEM TEST] Iniciando...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA CON KEYSYSTEM
-- ═══════════════════════════════════════════════════════════════

-- OPCIÓN 1: Usar KeySystem con URL (Recomendado para producción)
-- Necesitas un archivo JSON en GitHub o un servidor que devuelva las claves válidas.
-- Ejemplo de formato JSON: ["123", "456", "789"]

-- OPCIÓN 2: Simulación Local (Si no tienes URL)
-- Algunas versiones de WindUI permiten pasar una tabla de claves localmente.
-- Si tu versión no lo soporta, usaremos un truco simple.

local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz [KEYSYSTEM]",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZz",
    
    -- ACTIVAR KEYSYSTEM
    -- Si tu WindUI soporta 'KeySystem' como booleano, pon true.
    -- Si requiere URL, pon la URL de tu archivo JSON de claves.
    KeySystem = true, 
    
    -- URL de claves (Ejemplo: Un archivo raw de GitHub con ["123"])
    -- Para este test, usaremos una URL de ejemplo que contiene "123".
    -- Si no tienes una, crea un archivo en tu repo llamado 'keys.json' con: ["123"]
    KeyURL = "https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/keys.json", 
})

print("✅ [KEYSYSTEM TEST] Ventana creada con KeySystem.")

-- ═══════════════════════════════════════════════════════════════
-- TAB PRINCIPAL (Solo visible si la clave es correcta)
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "✅ Acceso Concedido",
    Desc = "Has ingresado la clave correcta: 123\nEl KeySystem nativo de WindUI está funcionando."
})

MainTab:Button({
    Title = "Probar Función",
    Callback = function()
        WindUI:Notify({
            Title = "Éxito",
            Content = "El Hub está desbloqueado.",
            Duration = 2
        })
    end
})

print("🟢 [KEYSYSTEM TEST] Listo. Ingresa la clave '123' cuando se solicite.")
