-- 🔍 TEST DE CARGA Y TEMAS
-- Este script demuestra EXACTAMENTE qué archivo lee Roblox y cómo verificar tus cambios.

local GITHUB_URL = "https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"
print(" [TEST] Roblox intentará cargar desde: " .. GITHUB_URL)

-- 1. Cargar la librería (igual que tu loader real)
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet(GITHUB_URL))()
end)

if not success then
    print("❌ [ERROR] No se pudo descargar o ejecutar el archivo de GitHub.")
    print("   Mensaje: " .. tostring(WindUI))
    return
end
print("✅ [ÉXITO] WindUI cargado desde GitHub correctamente.")

-- 2. Crear ventana FORZANDO el tema Dark
local Window = WindUI:CreateWindow({
    Title = "Diagnóstico de Carga",
    Theme = "Dark",          -- Forzamos Dark para probar tus cambios
    Size = UDim2.fromOffset(460, 320),
    Folder = "WindUI_Diag",
    IgnoreAlerts = false
})

local DiagTab = Window:Tab({ Title = "Verificación", Icon = "search" })

-- 3. Botón de prueba visual y en consola
DiagTab:Button({
    Title = "🔍 Verificar si el tema Dark se aplicó",
    Callback = function()
        print("═══════════════════════════════════════════════════")
        print("📊 REPORTE DE CARGA DE TEMAS")
        print("═══════════════════════════════════════════════════")
        print("📂 Archivo leído por Roblox: dist/main.lua (en GitHub)")
        print("🎨 Tema solicitado: Dark")
        print("")
        print("👀 OBSERVA LA VENTANA AHORA:")
        print("   - Fondo principal: ¿Es casi negro (#050505)?")
        print("   - Contenido/Tabs: ¿Es un gris muy oscuro (#0F0F0F)?")
        print("   - Bordes: ¿Son sutiles y oscuros (#191919)?")
        print("")
        print("✅ Si ves estos colores: TUS CAMBIOS YA ESTÁN EN GITHUB.")
        print("❌ Si ves los colores viejos (grises claros): SUBISTE EL ARCHIVO EQUIVOCADO.")
        print("═══════════════════════════════════════════════════")
        
        WindUI:Notify({
            Title = "Diagnóstico",
            Content = "Revisa la consola F9 y compara los colores visuales.",
            Duration = 4
        })
    end
})

DiagTab:Paragraph({
    Title = "¿Por qué no basta con subir 'src/themes/Init.lua'?",
    Desc = [[
🔴 Roblox NO lee tu carpeta 'src'. 
🔴 Roblox SOLO ejecuta lo que está en:
   .../WindUI-main/dist/main.lua

🛠️ Flujo correcto:
1. Editas en src/ (en tu PC)
2. Ejecutas tu script de 'Build/Compile' (genera un nuevo dist/main.lua)
3. Subes a GitHub SOLO el archivo dist/main.lua ACTUALIZADO
4. Roblox lee ese archivo nuevo y aplica tus colores.

Si solo subes src/, GitHub lo guarda, pero Roblox sigue leyendo el viejo dist/main.lua.
]]
})

print(" [TEST] Listo. Presiona el botón y observa la ventana + consola F9.")
