local attack = require("player/attack")
local player = require("player/player")
local target = {
    x = 600,
    y = 300,
    width = 64,
    height = 64,
    health = 5,
    xpValue = 12,
    sprite = nil,
    quads = {},
    currentFrame = 1,
    frameTime = 0.1,
    timer = 0
}

function target.keypressed(key)
    if key == "r" then
        target.health = 5
    end
end

function target.loadSprite()
    target.sprite = love.graphics.newImage("assets/basic_fly.png") -- adapte le chemin
    local frameWidth = 32
    local frameHeight = 32
    local imageWidth = target.sprite:getWidth()
    local imageHeight = target.sprite:getHeight()

    for i = 0, imageHeight / frameHeight - 1 do
        table.insert(target.quads, love.graphics.newQuad(0, i * frameHeight, frameWidth, frameHeight, imageWidth, imageHeight))
    end
end


function target.load()
    target.loadSprite()
end

function target.update(dt)
    -- Animation
    target.timer = (target.timer or 0) + dt
    if target.timer >= target.frameTime then
        target.timer = target.timer - target.frameTime
        target.currentFrame = target.currentFrame % #target.quads + 1
    end

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
        if target.sprite and #target.quads > 0 then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw
            (
                target.sprite,                      -- Image
                target.quads[target.currentFrame],  -- Quads
                target.x,                           -- Position x
                target.y,                           -- Position y
                0,                                  -- Rotation
                2,                                  -- Scale x
                2                                   -- Scale y
            )
        end

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
