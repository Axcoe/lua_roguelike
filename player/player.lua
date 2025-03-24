local w, h = love.window.getDesktopDimensions()

player = {
    x = (w / 2) - 15,
    y = (h / 2) - 15,
    speed = 200,
    size = 30
}

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
end

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
end

return player