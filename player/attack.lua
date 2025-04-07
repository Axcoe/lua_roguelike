local attack = {
    bullets = {},
    bulletSpeed = 400,
    fireRate = 0.5,
    lastShot = 0
}

function attack.update(dt)
    attack.lastShot = attack.lastShot + dt

    if love.mouse.isDown(1) and attack.lastShot >= attack.fireRate then
        local mouseX, mouseY = love.mouse.getPosition()
        local px = player.x + player.size / 2
        local py = player.y + player.size / 2

        -- Calcul du vecteur entre joueur et souris
        local dx = mouseX - px
        local dy = mouseY - py

        local direction
        if math.abs(dx) > math.abs(dy) then
            if dx > 0 then
                direction = "right"
            else
                direction = "left"
            end
        else
            if dy > 0 then
                direction = "down"
            else
                direction = "up"
            end
        end

        -- Détermine la position de départ du tir
        local bx, by = px, py
        if direction == "up" then by = player.y end
        if direction == "down" then by = player.y + player.size end
        if direction == "left" then bx = player.x end
        if direction == "right" then bx = player.x + player.size end

        attack.shoot(bx, by, direction)
        attack.lastShot = 0
    end

    -- Update des balles
    for i = #attack.bullets, 1, -1 do
        local bullet = attack.bullets[i]

        if bullet.direction == "up" then
            bullet.y = bullet.y - bullet.speed * dt
        elseif bullet.direction == "down" then
            bullet.y = bullet.y + bullet.speed * dt
        elseif bullet.direction == "left" then
            bullet.x = bullet.x - bullet.speed * dt
        elseif bullet.direction == "right" then
            bullet.x = bullet.x + bullet.speed * dt
        end

        -- Supprimer hors écran
        if bullet.x < 0 or bullet.x > love.graphics.getWidth()
        or bullet.y < 0 or bullet.y > love.graphics.getHeight() then
            table.remove(attack.bullets, i)
        end
    end
end

function attack.shoot(x, y, direction)
    local bullet = {
        x = x,
        y = y,
        size = 10,
        speed = attack.bulletSpeed,
        direction = direction
    }
    table.insert(attack.bullets, bullet)
end

function attack.draw()
    for _, bullet in ipairs(attack.bullets) do
        love.graphics.circle("fill", bullet.x, bullet.y, bullet.size)
    end
end

return attack
