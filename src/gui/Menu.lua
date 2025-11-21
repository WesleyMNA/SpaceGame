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

function Menu:update(dt)
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'menu' then return end

        if self.start_button:is_clicked() then CURRENT_GUI = 'selection' end

        if self.exit_button:is_clicked() then love.event.quit('exit') end
    end
end

function Menu:render()
    self.start_button:render()
    self.exit_button:render()

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    love.graphics.draw(self.icon, iconX, 20)
end
