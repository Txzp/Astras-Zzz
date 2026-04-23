-- ASTRA HUB ZZ - Mini KeySystem Style
-- Carga TU WindUI Modificado desde GitHub
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Configuración de la Clave
local ValidKey = "Testing 2" -- Cambia esto por tu clave real
local IsVerified = false

-- Crear Ventana "Falsa" (Solo para contener el KeySystem visual)
-- Usamos IgnoreAlerts: true para que no salga el dialog de "Close Window" al cerrar la X
local KeyWindow = WindUI:CreateWindow({
    Title = "ASTRA HUB ZZ",
    Theme = "Dark",
    Size = UDim2.fromOffset(400, 250), -- Tamaño pequeño
    IgnoreAlerts = true, -- Importante: Evita el dialog de cierre
    Topbar = {
        Height = 40, -- Barra superior más pequeña
        ButtonsType = "Default"
    }
})

-- Ocultar elementos innecesarios de la ventana estándar para que parezca un mini hub
-- Nota: WindUI no permite ocultar tabs fácilmente sin modificar el source, 
-- así que usaremos un truco: Crear solo una tab y ocultar su título, o usar un Dialog personalizado.

-- MEJOR ESTRATEGIA: Usar un Dialog Personalizado como Ventana Principal
-- Esto es más limpio para un "Mini Hub".

local function CreateMiniKeyHub()
    -- Creamos un Dialog que actuará como nuestra ventana principal
    local KeyDialog = WindUI:Dialog({
        Title = "ASTRA HUB ZZ | Verification",
        Content = "Enter your key to access the hub.",
        Width = 400,
        Buttons = {} -- No ponemos botones aquí, los añadimos manualmente abajo
    })

    -- Ajustar el tamaño y posición del Dialog para que parezca una ventana
    -- Nota: Los Dialogs de WindUI son emergentes. Para hacerlo "estático", necesitamos trucos.
    
    -- ESTRATEGIA FINAL: Usar la ventana normal pero SIN Tabs visibles y con elementos directos.
    -- Como WindUI fuerza las tabs, vamos a crear una Tab única y poner todo ahí.
end

-- REINICIANDO CON LA SOLUCIÓN MÁS SIMPLE Y EFECTIVA PARA WINDUI:
-- Crear una Ventana Normal, pero configurar el KeySystem para que sea lo único visible.

local Window = WindUI:CreateWindow({
    Title = "ASTRA HUB ZZ",
    Theme = "Dark",
    Size = UDim2.fromOffset(420, 280),
    IgnoreAlerts = true, -- Evita el dialog de "Close Window"
    Topbar = {
        Height = 45,
        ButtonsType = "Default"
    }
})

-- Truco: Crear una sola Tab llamada "Key" y ocultar la barra lateral si es posible,
-- o simplemente poner todo en esa tab.
local KeyTab = Window:Tab({ 
    Title = "Verification", 
    Icon = "key",
    ShowTabTitle = false -- Oculta el título de la tab dentro del contenido
})

-- Añadir Elementos Directos a la Tab
KeyTab:Paragraph({
    Title = "🔑 Access Required",
    Desc = "Please enter your license key to continue."
})

KeyTab:Input({
    Title = "License Key",
    Placeholder = "Enter key here...",
    Flag = "KeyInput", -- Para guardar referencia
    Callback = function(Value)
        -- Lógica opcional al escribir
    end
})

KeyTab:Button({
    Title = "Verify Key",
    Callback = function()
        -- Obtener el valor del input (necesitamos referenciarlo, pero WindUI no devuelve el objeto input fácilmente)
        -- Usaremos una variable global temporal para este ejemplo simple
        local InputValue = _G.TempKeyInput or "" 
        
        if InputValue == ValidKey then
            IsVerified = true
            WindUI:Notify({
                Title = "Success",
                Content = "Key verified! Loading Hub...",
                Duration = 2
            })
            
            task.wait(1)
            
            -- Destruir la ventana de Key y cargar el Hub Real
            Window:Destroy()
            LoadMainHub()
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Invalid Key. Please try again.",
                Icon = "x",
                Duration = 2
            })
        end
    end
})

-- Hack para capturar el valor del Input (ya que WindUI no tiene un método .Get() fácil)
-- Modificamos el callback del Input para guardar el valor
local InputElement = nil
-- Nota: En WindUI, los elementos no se devuelven fácilmente. 
-- Para este ejemplo, asumiremos que el usuario escribe la clave y damos un botón de verificar.
-- Si necesitas capturar el texto exacto, necesitas modificar el source de WindUI o usar una variable compartida.

-- SOLUCIÓN ALTERNATIVA SIMPLIFICADA PARA ESTE SCRIPT:
-- Usaremos un Input que guarda el valor en una variable local.

local CurrentKey = ""

-- Sobrescribimos el Input anterior con uno que guarde el valor
-- (Esto requiere editar el script anterior, así que aquí está la versión corregida):

-- [BORRA TODO LO ANTERIOR DESDE 'local Window = ...' HASTA AQUÍ Y USA ESTO:]

--[[
-- ASTRA HUB ZZ - Mini KeySystem Style (CORREGIDO)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

local ValidKey = "Testing 2"
local CurrentKey = ""
local IsVerified = false

local Window = WindUI:CreateWindow({
    Title = "ASTRA HUB ZZ",
    Theme = "Dark",
    Size = UDim2.fromOffset(420, 280),
    IgnoreAlerts = true,
})

local KeyTab = Window:Tab({ Title = "Key", Icon = "key" })

KeyTab:Paragraph({
    Title = "🔑 Verification",
    Desc = "Enter your key below."
})

-- Input que guarda el valor en CurrentKey
KeyTab:Input({
    Title = "Key",
    Placeholder = "Enter key...",
    Callback = function(Value)
        CurrentKey = Value
    end
})

KeyTab:Button({
    Title = "Verify",
    Callback = function()
        if CurrentKey == ValidKey then
            WindUI:Notify({ Title = "✅ Success", Content = "Loading...", Duration = 1 })
            task.wait(1)
            Window:Destroy()
            LoadMainHub()
        else
            WindUI:Notify({ Title = "❌ Error", Content = "Invalid Key", Duration = 2 })
        end
    end
})

function LoadMainHub()
    -- Aquí va tu Hub Real (Speed, ESP, etc.)
    local MainWindow = WindUI:CreateWindow({
        Title = "ASTRA HUB ZZ",
        Theme = "Dark",
        Size = UDim2.fromOffset(500, 400)
    })
    
    local MainTab = MainWindow:Tab({ Title = "Main", Icon = "home" })
    MainTab:Paragraph({ Title = "Welcome!", Desc = "You are verified." })
    -- Añade tus sliders y toggles aquí
end
]]

-- COMO NO PUEDO EDITAR EL ARCHIVO ANTERIOR EN TIEMPO REAL, AQUÍ TIENES EL CÓDIGO COMPLETO Y CORRECTO PARA PEGAR:

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/dist/main.lua"))()

local ValidKey = "Testing 2"
local CurrentKey = ""

local Window = WindUI:CreateWindow({
    Title = "ASTRA HUB ZZ",
    Theme = "Dark",
    Size = UDim2.fromOffset(420, 280),
    IgnoreAlerts = true,
})

local KeyTab = Window:Tab({ Title = "Key", Icon = "key" })

KeyTab:Paragraph({
    Title = "🔑 Verification",
    Desc = "Enter your key below."
})

KeyTab:Input({
    Title = "Key",
    Placeholder = "Enter key...",
    Callback = function(Value)
        CurrentKey = Value
    end
})

KeyTab:Button({
    Title = "Verify",
    Callback = function()
        if CurrentKey == ValidKey then
            WindUI:Notify({ Title = "✅ Success", Content = "Loading...", Duration = 1 })
            task.wait(1)
            Window:Destroy()
            LoadMainHub()
        else
            WindUI:Notify({ Title = "❌ Error", Content = "Invalid Key", Duration = 2 })
        end
    end
})

function LoadMainHub()
    local MainWindow = WindUI:CreateWindow({
        Title = "ASTRA HUB ZZ",
        Theme = "Dark",
        Size = UDim2.fromOffset(500, 400)
    })
    
    local MainTab = MainWindow:Tab({ Title = "Main", Icon = "home" })
    MainTab:Paragraph({ Title = "Welcome!", Desc = "You are verified." })
    
    -- Ejemplo de Slider Verde (tu modificación)
    MainTab:Slider({
        Title = "Speed",
        Value = { Min = 16, Max = 100, Default = 16 },
        Callback = function(v) print(v) end
    })
end
