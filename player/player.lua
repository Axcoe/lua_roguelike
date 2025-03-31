local w, h = love.window.getDesktopDimensions()

player = {
    x = (w / 2) - 15,
    y = (h / 2) - 15,
    speed = 200,
    size = 30,
    hp = 100
}

function player.drawHealthBar()
    local barWidth = 200  -- Largeur de la barre de vie
    local barHeight = 20   -- Hauteur de la barre de vie
    local x, y = 10, 10    -- Position en haut à gauche
    local hpRatio = player.hp / 100  -- Ratio de vie (0 à 1)

    -- Déterminer la couleur en fonction du % de vie (vert -> rouge)
    local r = math.min(1, (1 - hpRatio) * 2)  -- Rouge augmente quand la vie baisse
    local g = math.min(1, hpRatio * 2)        -- Vert diminue quand la vie baisse

    -- Dessiner le fond de la barre (gris foncé)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", x, y, barWidth, barHeight, 5, 5) -- Arrondi

    -- Dessiner la vie actuelle avec une couleur dynamique
    love.graphics.setColor(r, g, 0)  -- Rouge → Orange → Vert
    love.graphics.rectangle("fill", x, y, barWidth * hpRatio, barHeight, 5, 5)

    -- Dessiner le contour de la barre (blanc)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, barWidth, barHeight, 5, 5)

    -- Afficher la valeur de la vie au centre de la barre
    love.graphics.setColor(1, 1, 1)  -- Blanc
    love.graphics.setFont(love.graphics.newFont(14)) -- Taille de police
    love.graphics.printf(math.floor(player.hp) .. " / 100", x, y + 2, barWidth, "center")

    -- Réinitialiser la couleur
    love.graphics.setColor(1, 1, 1)
end

function player.load()
end

function player.update(dt)
    if love.keyboard.isDown("z") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown("q") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("space") then
        player.hp = math.max(0, player.hp - 20 * dt) -- Diminue la vie
    end
    
end

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
    player.drawHealthBar()
end

return player