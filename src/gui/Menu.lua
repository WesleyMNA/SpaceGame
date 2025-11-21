require('src.gui.button')

local window = require('src.utils.window')

Menu = {}
Menu.__index = Menu

function Menu:new()
    local this = {
        class = 'Menu',
        icon = love.graphics.newImage('sprites/gui/menu/icon.png'),
        start_button = Button:new(
            window.get_center_x() - 50,
            230,
            'sprites/gui/menu/start.png',
            function()
                CURRENT_GUI = 'selection'
            end
        ),
        exit_button = Button:new(
            window.get_center_x() - 50,
            280,
            'sprites/gui/menu/exit.png',
            function()
                love.event.quit('exit')
            end
        )
    }

    setmetatable(this, self)
    return this
end

function Menu:mousepressed(x, y)
    self.start_button:mousepressed(x, y)
    self.exit_button:mousepressed(x, y)
end

function Menu:draw()
    self.start_button:draw()
    self.exit_button:draw()

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    love.graphics.draw(self.icon, iconX, 20)
end
