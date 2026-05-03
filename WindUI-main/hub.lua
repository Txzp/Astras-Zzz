-- Testing Mínimo Keybind Abrir/Cerrar
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

print("🔄 [TEST] Iniciando Testing Keybind...")

-- Crear Ventana
local Window = WindUI:CreateWindow({
    Title = "Keybind Test",
    Theme = "Dark",
    Size = UDim2.fromOffset(400, 300),
    Folder = "KeybindTest",
})

print("✅ [TEST] Ventana creada.")

-- Tab Principal
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })

-- Keybind para Abrir/Cerrar
MainTab:Keybind({
    Title = "Tecla Abrir/Cerrar Hub",
    Value = "RightShift", -- Tecla por defecto
    Callback = function(key)
        -- Esta función se ejecuta AL PRESIONAR la tecla configurada
        print("⚡ [TEST] Keybind Callback ejecutado. Tecla presionada: " .. key)
        
        -- Opcional: Notificación visual para confirmar
        WindUI:Notify({
            Title = "Keybind Detectado",
            Content = "Presionaste: " .. key,
            Duration = 1.5
        })
    end
})

print("🟢 [TEST] Script cargado. Prueba presionar 'RightShift' para abrir/cerrar.")
