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
            'sprites/gui/menu/start.png'
        ),
        exit_button = Button:new(
            window.get_center_x() - 50,
            280,
            'sprites/gui/menu/exit.png'
        )
    }

    setmetatable(this, self)
    return this
end

function Menu:mousepressed(x, y)
    if self.start_button:is_clicked(x, y) then CURRENT_GUI = 'selection' end

    if self.exit_button:is_clicked(x, y) then love.event.quit('exit') end
end

function Menu:draw()
    self.start_button:draw()
    self.exit_button:draw()

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    love.graphics.draw(self.icon, iconX, 20)
end
