local buttons = {}
local font = nil
BUTTON_HEIGHT = 80

start_menu = {
    isMenu = true
}

function newButton(text, fn)
    return {
        text = text,
        fn = fn,

        now = false,
        last =false
    }
end

function start_menu.launch_game()
    start_menu.isMenu = false
end

function start_menu.loadStartMenu()
    font = love.graphics.newFont(32)

    table.insert(buttons, newButton(
            "Start Game",
            function()
                start_menu.launch_game()
            end
    ))

    table.insert(buttons, newButton(
            "Load Game",
            function()
                print("Loading Game")
            end
    ))

    table.insert(buttons, newButton(
            "Options",
            function()
                print("Options")
            end
    ))

    table.insert(buttons, newButton(
            "Quit",
            function()
                love.event.quit()
            end
    ))
end

function start_menu.drawStartMenu()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    local button_width = ww * (1 / 3)
    local margin = 16

    local total_height = (BUTTON_HEIGHT + margin) * #buttons
    local cursor_y = 0

    for i, button in ipairs(buttons) do
        button.last = button.now

        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

        local color = {0.4, 0.4, 0.5, 1.0}
        local mx, my = love.mouse.getPosition()
        local hot = mx > bx and mx < bx + button_width and
                    my > by and my < by + BUTTON_HEIGHT


        if hot then
            color = {0.8, 0.8, 0.9, 1.0}
        end

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
        end

        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button_width,
            BUTTON_HEIGHT
        )
        love.graphics.setColor(0, 0, 0, 1)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)

        love.graphics.print(
            button.text,
            font,
            (ww * 0.5) - textW * 0.5,
            by + textH * 0.5
        )

        cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
    end

end

return start_menu