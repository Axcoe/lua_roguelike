local player = require("player/player")
local attack = require("player/attack")
local target = require("target/target")
local start_menu = require("menus/start_menu")
local pause_menu = require("menus/pause_menu")
local sti = require("lib/sti")


function love.load()
    love.window.setMode(
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
    pause_menu.loadPauseMenu()
    map = sti("assets/map_roguelike.lua")
end

function love.keypressed(key)
    if key == "escape" then
        pause_menu.toggle()
        return  -- on sort pour ne pas passer la touche à target
    end

    if not pause_menu.isPaused then
        target.keypressed(key)
    end
end

function love.update(dt)
    if pause_menu.isPaused then
        return
    end

    -- Player --
    player.update(dt)
    attack.update(dt)
    ------------

    target.update(dt)

    -- map --
    map:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    --------- Player ----------
    if player.hp <= 0 then
        player.gameOver()
    else
        if start_menu.isMenu == true then
            start_menu.drawStartMenu()
        else
            player.draw()
            attack.draw()
    ----------------------------

    ---------- Target ----------
            target.draw()
    ----------------------------

    ---------- Map -------------
            map:draw()
    ----------------------------
        end
    end

    pause_menu.drawPauseMenu()

end
