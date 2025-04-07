local w, h = love.window.getDesktopDimensions()

player = {
    x = (w / 2) - 15,
    y = (h / 2) - 15,
    speed = 200,
    size = 30,
    hp = 100,
    xp = 0,
    level = 1,
    xpToNextLevel = 10,
    showLevelUp = false,
    levelUpTimer = 3
}

function player.drawHealthBar()
    local barWidth = 200  -- Largeur de la barre de vie
    local barHeight = 20   -- Hauteur de la barre de vie
    local x, y = 10, 10    -- Position en haut à gauche
    local hpRatio = player.hp / 100  -- Ratio de vie (0 à 1)

    -- Déterminer la couleur en fonction du % de vie (vert -> rouge)
    local r = math.min(1, (1 - hpRatio) * 2)  -- Rouge augmente quand la vie baisse
    local g = math.min(1, hpRatio * 2)        -- Vert diminue quand la vie baisse

    -- Dessiner le fond de la barre (noir)
    love.graphics.setColor(0, 0, 0)
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

function player.drawXpBar()
    local barWidth = 200  -- Largeur de la barre de vie
    local barHeight = 20   -- Hauteur de la barre de vie
    local x, y = 10, 40    -- Position en haut à gauche
    local xpLevel = player.xp / player.xpToNextLevel    -- Ratio de vie (0 à 1)

    -- Dessiner le fond de la barre (noir)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x, y, barWidth, barHeight, 5, 5) -- Arrondi

    -- Dessiner l'xp actuelle en bleu
    love.graphics.setColor(0, 0, 1)  -- Rouge → Orange → Vert
    if player.xp > 0 then
        love.graphics.rectangle("fill", x, y, barWidth * xpLevel, barHeight, 5, 5)
    end
    -- Dessiner le contour de la barre (blanc)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, barWidth, barHeight, 5, 5)

    -- Afficher la valeur de la vie au centre de la barre
    love.graphics.setColor(1, 1, 1)  -- Blanc
    love.graphics.setFont(love.graphics.newFont(14)) -- Taille de police
    love.graphics.printf(math.floor(player.xp) .. " /" .. player.xpToNextLevel, x, y + 2, barWidth, "center")

    -- Réinitialiser la couleur
    love.graphics.setColor(1, 1, 1)
end

function player.xpLevelUp()
    player.level = player.level + 1
    player.xp = player.xp - player.xpToNextLevel
    player.xpToNextLevel = player.level * 10
    player.showLevelUp = true
    player.levelUpTimer = 3
end

function player.xpLogic()
    if player.xp >= player.xpToNextLevel then
        player.xpLevelUp()
    end
end

function player.load()
end

function player.update(dt)
    local dx, dy = 0, 0

    if love.keyboard.isDown("z") then
        dy = dy - 1
    end
    if love.keyboard.isDown("s") then
        dy = dy + 1
    end
    if love.keyboard.isDown("q") then
        dx = dx - 1
    end
    if love.keyboard.isDown("d") then
        dx = dx + 1
    end

    -- Normalisation si nécessaire
    if dx ~= 0 or dy ~= 0 then
        local length = math.sqrt(dx * dx + dy * dy)
        dx = dx / length
        dy = dy / length

        player.x = player.x + dx * player.speed * dt
        player.y = player.y + dy * player.speed * dt
    end

    if love.keyboard.isDown("space") then
        player.hp = math.max(0, player.hp - 20 * dt)
    end

    player.xpLogic()

    if player.showLevelUp then
        player.levelUpTimer = player.levelUpTimer - dt
        if player.levelUpTimer <= 0 then
            player.showLevelUp = false
        end
    end
end


function player.gameOver()
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(love.graphics.newFont(64))
    love.graphics.printf("Game Over", 0, love.graphics.getHeight() / 2 - 64, love.graphics.getWidth(), "center")
end

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
    player.drawHealthBar()
    player.drawXpBar()

    if player.showLevelUp then
        love.graphics.setColor(1, 1, 0)
        love.graphics.print("Level UP !", player.x - 15, player.y - 20)
        love.graphics.setColor(1, 1, 1)
    end
end

return player