-- AstraHub Zz - Con KeySystem Nativo de WindUI (Clave: 123)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 [KEYSYSTEM NATIVO] Iniciando...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN PARA ACTIVAR EL KEYSYSTEM NATIVO DE WINDUI
-- ═══════════════════════════════════════════════════════════════

local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZz",
    IgnoreAlerts = false,
    
    -- ✅ ACTIVACIÓN DEL KEYSYSTEM NATIVO DE WINDUI
    KeySystem = {
        Enabled = true, -- Activa el sistema
        Title = "🔒 AstraHub Zz", -- Título de la ventana de clave
        Note = "Ingresa la clave para acceder al hub.", -- Nota opcional
        Key = {"1234"}, -- Tabla de claves válidas (puedes añadir más: {"123", "456"})
        SaveKey = true, -- Guarda la clave en un archivo local para no pedirla de nuevo
        -- KeyValidator = function(key) return key == "123" end -- Opcional: Validación personalizada
    }
})

print("✅ [KEYSYSTEM NATIVO] Ventana creada con KeySystem activado.")

-- ═══════════════════════════════════════════════════════════════
-- TAB PRINCIPAL (Solo visible si la clave es correcta)
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "✅ Acceso Concedido",
    Desc = "Has ingresado la clave correcta usando el sistema nativo de WindUI."
})

MainTab:Button({
    Title = "Probar Función",
    Callback = function()
        WindUI:Notify({
            Title = "Éxito",
            Content = "El Hub nativo con KeySystem está funcionando.",
            Duration = 2
        })
    end
})

print("🟢 [KEYSYSTEM NATIVO] Listo. Debería aparecer la ventana de clave nativa de WindUI.")
