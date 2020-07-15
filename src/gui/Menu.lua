require('src.gui.StartGame')

Menu = {}
Menu.__index = Menu

function Menu:new()
    local this = {
        class = 'Menu',

        icon = love.graphics.newImage('sprites/gui/icon.png'),
        startGame = StartGame:new()
    }

    setmetatable(this, self)
    return this
end

function Menu:update(dt)
    self.startGame:update(dt)
end

function Menu:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(
        self.icon,
        (WINDOW_WIDTH / 2) - 32,
        100
    )
    self.startGame:render()
end

