-- Cargar la librería GnsysHub Zz
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txzp/Astras-Zzz/main/WindUI-main/hub.lua"))()

-- Crear ventana principal
local Window = WindUI:CreateWindow({
    Title = "GnsysHub Zz - ESP Avanzado",
    Theme = "Dark",
    Size = UDim2.fromOffset(550, 500),
    Folder = "GnsysHub"
})

-- Crear tab para ESP
local ESPTab = Window:Tab({
    Title = "Visual ESP",
    Icon = "eye"
})

-- Variables de control
local espEnabled = false
local maxDistance = 100
local filterTeam = "Todos"
local showNames = false
local showBoxes = false

-- Variables para almacenar conexiones y objetos
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera

-- Almacenar objetos Drawing
local espObjects = {}
local heartbeatConnection = nil

-- Función para obtener el color según equipo
local function getTeamColor(player)
    if player.Team == nil then
        return Color3.fromRGB(200, 200, 200) -- Blanco/gris sin equipo
    end
    if localPlayer.Team == nil then
        return Color3.fromRGB(200, 200, 200)
    end
    if player.Team == localPlayer.Team then
        return Color3.fromRGB(0, 255, 0) -- Verde para aliados
    else
        return Color3.fromRGB(255, 0, 0) -- Rojo para enemigos
    end
end

-- Función para filtrar jugadores por equipo
local function shouldDrawPlayer(player)
    if player == localPlayer then return false end
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return false end
    if player.Character.Humanoid.Health <= 0 then return false end
    
    local distance = (player.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
    if distance > maxDistance then return false end
    
    if filterTeam == "Aliados" and player.Team ~= localPlayer.Team then return false end
    if filterTeam == "Enemigos" and player.Team == localPlayer.Team then return false end
    
    return true
end

-- Función para actualizar ESP
local function updateESP()
    if not espEnabled then return end
    
    for _, player in pairs(players:GetPlayers()) do
        if shouldDrawPlayer(player) then
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and humanoid.Health > 0 then
                local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                
                if onScreen then
                    -- Crear o actualizar objetos ESP
                    if not espObjects[player] then
                        espObjects[player] = {}
                    end
                    
                    local playerESP = espObjects[player]
                    local teamColor = getTeamColor(player)
                    
                    -- Caja ESP
                    if showBoxes then
                        local size = character:GetExtentsSize()
                        local height = size.Y
                        local width = size.X
                        local topPos = camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, height/2, 0))
                        local bottomPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, height/2, 0))
                        local leftPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(width/2, 0, 0))
                        local rightPos = camera:WorldToViewportPoint(rootPart.Position + Vector3.new(width/2, 0, 0))
                        
                        if not playerESP.Box then
                            playerESP.Box = Drawing.new("Square")
                            playerESP.Box.Thickness = 2
                            playerESP.Box.Filled = false
                        end
                        
                        playerESP.Box.Visible = true
                        playerESP.Box.Color = teamColor
                        playerESP.Box.Position = Vector2.new(leftPos.X, topPos.Y)
                        playerESP.Box.Size = Vector2.new(rightPos.X - leftPos.X, bottomPos.Y - topPos.Y)
                    elseif espObjects[player] and espObjects[player].Box then
                        espObjects[player].Box.Visible = false
                    end
                    
                    -- Nombre ESP
                    if showNames then
                        if not playerESP.NameText then
                            playerESP.NameText = Drawing.new("Text")
                            playerESP.NameText.Size = 14
                            playerESP.NameText.Center = true
                            playerESP.NameText.Outline = true
                            playerESP.NameText.OutlineColor = Color3.fromRGB(0, 0, 0)
                        end
                        
                        playerESP.NameText.Visible = true
                        playerESP.NameText.Color = teamColor
                        playerESP.NameText.Text = player.Name .. " [" .. math.floor((screenPos.Z * 100)) .. "m]"
                        playerESP.NameText.Position = Vector2.new(screenPos.X, screenPos.Y - 30)
                    elseif espObjects[player] and espObjects[player].NameText then
                        espObjects[player].NameText.Visible = false
                    end
                    
                    -- Distancia ESP (info adicional)
                    if not playerESP.DistanceText then
                        playerESP.DistanceText = Drawing.new("Text")
                        playerESP.DistanceText.Size = 11
                        playerESP.DistanceText.Center = true
                        playerESP.DistanceText.Outline = true
                        playerESP.DistanceText.OutlineColor = Color3.fromRGB(0, 0, 0)
                    end
                    
                    playerESP.DistanceText.Visible = true
                    playerESP.DistanceText.Color = Color3.fromRGB(255, 255, 255)
                    playerESP.DistanceText.Text = math.floor(screenPos.Z) .. "m"
                    playerESP.DistanceText.Position = Vector2.new(screenPos.X, screenPos.Y + 10)
                    
                else
                    -- Limpiar objetos si el jugador está fuera de pantalla
                    if espObjects[player] then
                        if espObjects[player].Box then espObjects[player].Box.Visible = false end
                        if espObjects[player].NameText then espObjects[player].NameText.Visible = false end
                        if espObjects[player].DistanceText then espObjects[player].DistanceText.Visible = false end
                    end
                end
            end
        else
            -- Limpiar objetos si el jugador no debe ser dibujado
            if espObjects[player] then
                if espObjects[player].Box then espObjects[player].Box.Visible = false end
                if espObjects[player].NameText then espObjects[player].NameText.Visible = false end
                if espObjects[player].DistanceText then espObjects[player].DistanceText.Visible = false end
            end
        end
    end
end

-- Función para limpiar todos los objetos ESP
local function cleanupESP()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
    
    for _, playerESP in pairs(espObjects) do
        if playerESP.Box then playerESP.Box:Remove() end
        if playerESP.NameText then playerESP.NameText:Remove() end
        if playerESP.DistanceText then playerESP.DistanceText:Remove() end
    end
    espObjects = {}
end

-- Función para iniciar ESP
local function startESP()
    if heartbeatConnection then cleanupESP() end
    heartbeatConnection = runService.RenderStepped:Connect(updateESP)
    WindUI:Notify({ Title = "ESP Activado", Content = "Visualización iniciada", Duration = 2 })
end

-- Función para detener ESP
local function stopESP()
    cleanupESP()
    WindUI:Notify({ Title = "ESP Desactivado", Content = "Visualización detenida", Duration = 2 })
end

-- --- COMPONENTES UI --- --

-- Toggle principal ESP
ESPTab:Toggle({
    Title = "Activar ESP",
    Value = false,
    Callback = function(state)
        espEnabled = state
        if state then
            startESP()
        else
            stopESP()
        end
    end
})

-- Slider para distancia máxima
ESPTab:Slider({
    Title = "Distancia Máxima",
    Value = { Min = 50, Max = 500, Default = 100 },
    Callback = function(value)
        maxDistance = value
    end
})

-- Dropdown para filtrar por equipo
ESPTab:Dropdown({
    Title = "Filtrar por Equipo",
    Values = {"Todos", "Aliados", "Enemigos"},
    Default = "Todos",
    Callback = function(selected)
        filterTeam = selected
    end
})

-- Separador visual
ESPTab:Paragraph({
    Title = "Opciones de Visualización",
    Desc = "Configura qué elementos mostrar"
})

-- Toggle para mostrar nombres
ESPTab:Toggle({
    Title = "Mostrar Nombres",
    Value = false,
    Callback = function(state)
        showNames = state
        if not state and espEnabled then
            -- Limpiar textos de nombres inmediatamente
            for _, playerESP in pairs(espObjects) do
                if playerESP.NameText then
                    playerESP.NameText.Visible = false
                end
            end
        end
    end
})

-- Toggle para mostrar cajas
ESPTab:Toggle({
    Title = "Mostrar Cajas (Box ESP)",
    Value = false,
    Callback = function(state)
        showBoxes = state
        if not state and espEnabled then
            -- Limpiar cajas inmediatamente
            for _, playerESP in pairs(espObjects) do
                if playerESP.Box then
                    playerESP.Box.Visible = false
                end
            end
        end
    end
})

-- Info adicional
ESPTab:Paragraph({
    Title = "Información",
    Desc = "ESP Avanzado - GnsysHub Zz\n• Verde: Aliados\n• Rojo: Enemigos\n• Blanco: Sin equipo"
})

-- Botón para limpiar memoria manualmente
ESPTab:Button({
    Title = "Limpiar Memoria ESP",
    Callback = function()
        cleanupESP()
        WindUI:Notify({ Title = "Memoria Limpiada", Content = "Objetos ESP eliminados", Duration = 2 })
        if espEnabled then
            startESP() -- Reiniciar ESP si estaba activo
        end
    end
})

-- Notificación inicial
WindUI:Notify({ 
    Title = "GnsysHub Zz", 
    Content = "ESP Avanzado cargado correctamente", 
    Duration = 3 
})
