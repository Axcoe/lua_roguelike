local player = require("player/player")
local attack = require("player/attack")
local target = require("target/target")
local start_menu = require("menus/start_menu")

function love.load()
    love.window.setMode
    (
        love.graphics.getWidth(),
        love.graphics.getHeight(),
        {
            fullscreen = true,
            display = 2,
            resizable = false
        }
    )

    love.window.setTitle("on choisira plus tard.")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    -- Player --
    player.load()
    ------------
    start_menu.loadStartMenu()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    target.keypressed(key)
end

function love.update(dt)
    -- Player --
    player.update(dt)
    attack.update(dt)
    ------------

    target.update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    --------- Player ----------
    if player.hp <= 0 then
        player.gameOver()
    else
        start_menu.drawStartMenu()
        player.draw()
        attack.draw()
    ----------------------------

    ---------- Target ----------
        target.draw()
    ----------------------------
    end

end
