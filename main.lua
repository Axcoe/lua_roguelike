local start_menu = require("menus/start_menu")

function love.load()
    love.window.setFullscreen(true)
    love.window.setTitle("on choisira plus tard.")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    start_menu.loadStartMenu()
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Coucou :D", 300, 250)

    start_menu.drawStartMenu()
end