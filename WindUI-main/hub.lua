-- Testing Mínimo Keybind Abrir/Cerrar
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 Iniciando Testing Keybind...")

-- Crear Ventana
local Window = WindUI:CreateWindow({
    Title = "Keybind Test",
    Theme = "Dark",
    Size = UDim2.fromOffset(400, 300),
    Folder = "KeybindTest",
})

print("✅ Ventana cargada.")

-- Tab Principal
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

-- Keybind para Abrir/Cerrar
MainTab:Keybind({
    Title = "Tecla Abrir/Cerrar Hub",
    Value = "RightShift", -- Tecla por defecto
    Callback = function(key)
        -- Esta función se ejecuta al presionar la tecla, pero WindUI maneja el toggle internamente
        -- Solo notificamos para confirmar que se detectó la tecla
        WindUI:Notify({
            Title = "Keybind",
            Content = "Presionaste: " .. key,
            Duration = 1.5
        })
    end
})

-- Botón para cambiar la tecla a 'Q' (Opcional, para probar cambio dinámico)
MainTab:Button({
    Title = "Cambiar Tecla a Q",
    Callback = function()
        Window:SetToggleKey(Enum.KeyCode.Q)
        WindUI:Notify({
            Title = "Config",
            Content = "Tecla cambiada a Q",
            Duration = 2
        })
    end
})

print("🟢 Testing Keybind listo.")
