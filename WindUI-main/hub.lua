-- Testing KeySystem NATIVO de WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 [KEYSYSTEM NATIVO] Iniciando...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN PARA ACTIVAR EL KEYSYSTEM NATIVO
-- ═══════════════════════════════════════════════════════════════

-- WindUI espera una URL que devuelva un JSON con las claves válidas.
-- Para este test, usaremos un archivo raw de GitHub que contiene ["123"].
-- Asegúrate de haber creado el archivo 'keys.json' en tu repo con: ["123"]

local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz [NATIVE KEY]",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZz",
    
    -- ACTIVACIÓN DEL KEYSYSTEM NATIVO
    KeySystem = {
        Enabled = true,
        -- Esta es la URL que WindUI consultará. Debe devolver un array JSON: ["clave1", "clave2"]
        KeyURL = "https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/keys.json",
        -- Mensaje opcional que aparece en la UI nativa
        Description = "Ingresa la clave para acceder al AstraHub Zz."
    }
})

print("✅ [KEYSYSTEM NATIVO] Ventana creada. Debería aparecer la UI nativa de WindUI.")

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

print("🟢 [KEYSYSTEM NATIVO] Listo. Ingresa la clave '123' en la ventana emergente.")
