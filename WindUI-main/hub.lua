-- Testing KeySystem NATIVO de WindUI (Usando KeySystem.lua interno)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 [KEYSYSTEM NATIVO] Iniciando test...")

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE LA VENTANA CON KEYSYSTEM NATIVO
-- ═══════════════════════════════════════════════════════════════

local Window = WindUI:CreateWindow({
    Title = "AstraHub Zz",
    Theme = "Dark",
    Size = UDim2.fromOffset(480, 420),
    Folder = "AstraHubZz",
    IgnoreAlerts = false, -- Importante para que los dialogs funcionen bien
    
    -- ✅ ACTIVACIÓN DEL KEYSYSTEM NATIVO
    -- Esto le dice a main.lua que cargue KeySystem.lua antes de mostrar el Hub
    KeySystem = {
        Enabled = true,           -- Activa el sistema
        Title = "🔒 AstraHub Zz", -- Título que aparece en la ventana de clave
        Note = "Ingresa la clave para acceder.", -- Texto pequeño debajo del título
        Key = {"123"},            -- La clave válida (puedes poner más: {"123", "abc"})
        SaveKey = true,           -- Guarda la clave en un archivo local (.key) para no pedirla siempre
        -- Thumbnail = {           -- Opcional: Si quieres una imagen a la izquierda
        --     Image = "rbxassetid://...", 
        --     Width = 200
        -- }
    }
})

print("✅ [KEYSYSTEM NATIVO] Ventana configurada. Esperando interacción con la UI nativa.")

-- ═══════════════════════════════════════════════════════════════
-- TAB PRINCIPAL (Solo se crea si la clave es correcta)
-- ═══════════════════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

MainTab:Paragraph({
    Title = "✅ Acceso Concedido",
    Desc = "Has superado el KeySystem nativo de WindUI.\nLa clave '123' fue aceptada."
})

MainTab:Button({
    Title = "Probar Notificación",
    Callback = function()
        WindUI:Notify({
            Title = "Éxito",
            Content = "El Hub está funcionando correctamente.",
            Duration = 2
        })
    end
})

MainTab:Toggle({
    Title = "Activar Función de Prueba",
    Value = false,
    Callback = function(state)
        print("Función de prueba:", state)
    end
})

print("🟢 [KEYSYSTEM NATIVO] Test completado. Si ves esto, el Hub cargó tras la clave.")
