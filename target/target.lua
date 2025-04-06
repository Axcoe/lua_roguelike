local target = {
    x = 600,
    y = 300,
    width = 40,
    height = 40,
    health = 5
}

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
    return bullet.x < target.x + target.width and
           bullet.x + bullet.size > target.x and
           bullet.y < target.y + target.height and
           bullet.y + bullet.size > target.y
end

function target.isAlive()
    return target.health > 0
end

return target
