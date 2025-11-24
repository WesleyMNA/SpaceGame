require('src.gui.button')

local game = require('src.utils.game')
local window = require('src.utils.window')

Menu = {}
Menu.__index = Menu

function Menu:new(manager)
    local this = {
        manager = manager,
        icon = love.graphics.newImage('sprites/gui/menu/icon.png'),
    }
    this.buttons = {
        start = Button:new(
            window.get_center_x() - 50,
            230,
            'sprites/gui/menu/start.png',
            function()
                manager:switch_gui('selection')
            end
        ),
        exit = Button:new(
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
    game.mousepressed(self.buttons, x, y)
end

function Menu:draw()
    game.draw(self.buttons)

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    love.graphics.draw(self.icon, iconX, 20)
end
