-- TEST FINAL: Dialog Personalizado AstraHub Zz
print("🔄 Cargando WindUI Modificado desde GitHub...")

local success, result = pcall(function()
    -- Carga TU librería modificada desde GitHub
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()
end)

if not success then
    print("❌ Error al cargar WindUI:")
    print(result)
    return
end

print("✅ WindUI cargado correctamente.")

-- Crear una ventana de prueba simple
local Window = WindUI:CreateWindow({
    Title = "TEST DIALOG",
    Theme = "Dark",
    Size = UDim2.fromOffset(400, 300)
})

local MainTab = Window:Tab({ Title = "Prueba", Icon = "home" })

MainTab:Paragraph({
    Title = "Prueba de Dialog de Cierre",
    Desc = "Haz clic en la 'X' de arriba a la derecha para probar el Dialog personalizado."
})

MainTab:Button({
    Title = "Forzar Dialog Manualmente",
    Callback = function()
        Window:Dialog({
            Title = "Close | AstrasHub",
            Content = "Are you sure you want to close the AstrasHub interface?",
            Buttons = {
                {
                    Title = "Cancel",
                    Variant = "Secondary",
                    Callback = function() end
                },
                {
                    Title = "Confirm",
                    Variant = "Primary", 
                    Color = Color3.fromRGB(255, 60, 60), -- Fuerza el color ROJO
                    Callback = function()
                        print("Confirmado manualmente")
                    end
                }
            }
        })
    end
})

print("🟢 Prueba lista. Haz clic en la X de la ventana.")
