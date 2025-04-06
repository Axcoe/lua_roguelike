local attack = require("player/attack")
local player = require("player/player")
local target = {
    x = 600,
    y = 300,
    width = 40,
    height = 40,
    health = 5,
    xpValue = 12
}

function target.keypressed(key)
    if key == "r" then
        target.health = 5
    end
end

function target.update(dt)
    -- Is hit target ? --
    for i = #attack.bullets, 1, -1 do
        local bullet = attack.bullets[i]
        if target.isAlive() and target.isHit(bullet) then
            target.hit()
            if target.health <= 0 then
                player.xp = player.xp + target.xpValue
            end
            table.remove(attack.bullets, i)
        end
    end
end

function target.draw()
    if target.health > 0 then
        love.graphics.setColor(1, 0, 0) -- Rouge
        love.graphics.rectangle("fill", target.x, target.y, target.width, target.height)

        -- Affiche la vie
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("HP: " .. target.health, target.x, target.y - 20)
    end
end

function target.hit()
    target.health = target.health - 1
end

function target.isHit(bullet)
    return bullet.x - bullet.size < target.x + target.width and
           bullet.x + bullet.size > target.x and
           bullet.y - bullet.size < target.y + target.height and
           bullet.y + bullet.size > target.y
end

function target.isAlive()
    return target.health > 0
end

return target
