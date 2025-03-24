local attack = {
    bullets = {},
    bulletSpeed = 400,
    fireRate = 0.3,
    lastShot = 0
}

local direction = "right"

function attack.update(dt)

    if love.keyboard.isDown("z") then
        direction = "up"
    end
    if love.keyboard.isDown("s") then
        direction = "down"
    end
    if love.keyboard.isDown("q") then
        direction = "left"
    end
    if love.keyboard.isDown("d") then
        direction = "right"
    end

    -- Auto-shoot bullets
    attack.lastShot = attack.lastShot + dt
    if attack.lastShot >= attack.fireRate then
        if direction == "up" then
            attack.shoot(player.x + player.size / 2 - 5, player.y)
        elseif direction == "down" then
            attack.shoot(player.x + player.size / 2 - 5, player.y + player.size)
        elseif direction == "left" then
            attack.shoot(player.x, player.y + player.size / 2 - 5)
        elseif direction == "right" then
            attack.shoot(player.x + player.size, player.y + player.size / 2 - 5)
        end
        attack.lastShot = 0 -- Reset timer
    end

    -- Update bullets
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

        -- Remove bullets when off-screen
        if bullet.x > love.graphics.getWidth() then
            table.remove(attack.bullets, i)
        end
    end
end

function attack.shoot(x, y)
    local bullet = {
        x = x,
        y = y,
        width = 10,
        height = 5,
        speed = attack.bulletSpeed,
        direction = direction
    }
    table.insert(attack.bullets, bullet)
end

function attack.draw()
    for _, bullet in ipairs(attack.bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.width, bullet.height)
    end
end

return attack
