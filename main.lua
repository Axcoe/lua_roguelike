local player = require("player/player")
local attack = require("player/attack")

function love.load()
    love.window.setFullscreen(true)
    love.window.setTitle("on choisira plus tard.")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    -- Player --
    player.load()
    ------------
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    -- Player --
    player.update(dt)
    attack.update(dt)
    ------------
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    -- Player --
    player.draw()
    attack.draw()
    ------------
end
