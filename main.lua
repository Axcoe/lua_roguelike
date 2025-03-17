function love.load()
    love.window.setFullscreen(true)
    love.window.setTitle("on choisira plus tard.")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
end

function love.update(dt)
    -- Mise à jour de la logique du jeu
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Coucou :D", 300, 250)
end