local player = require("player/player")
local attack = require("player/attack")
local target = require("target/target")

function love.load()
    love.window.setMode(love.graphics.getWidth(),
                        love.graphics.getHeight(), 
                        {
                            fullscreen = true,
                            display = 2,
                            resizable = false
                        })

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

    -- Is hit target ? --
    for i = #attack.bullets, 1, -1 do
        local bullet = attack.bullets[i]
        if target.isAlive() and target.isHit(bullet) then
            target.hit()
            table.remove(attack.bullets, i)
        end
    end

end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    if player.hp <= 0 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.setFont(love.graphics.newFont(64))
        love.graphics.printf("Game Over", 0, love.graphics.getHeight() / 2 - 64, love.graphics.getWidth(), "center")
    else        
        -- Player --
        player.draw()
        attack.draw()
        target.draw()
        ------------
    end
end
