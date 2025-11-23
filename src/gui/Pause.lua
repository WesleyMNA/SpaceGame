local game = require('src.utils.game')
local window = require('src.utils.window')

Pause = {}
Pause.__index = Pause

function Pause:new()
    local this = {
        class = 'Pause',
        icon = love.graphics.newImage('sprites/gui/headers/pause.png'),
        buttons = {
            menu = Button:new(
                window.get_center_x() - 100,
                window.get_center_y(),
                'sprites/gui/buttons/menu.png',
                function()
                    CURRENT_GUI = 'menu'
                end
            ),
            play = Button:new(
                window.get_center_x() + 50,
                window.get_center_y(),
                'sprites/gui/buttons/play.png',
                function()
                    CURRENT_GUI = 'map'
                end
            )
        }
    }

    setmetatable(this, self)
    return this
end

function Pause:mousepressed(x, y)
    game.mousepressed(self.buttons, x, y)
end

function Pause:draw()
    game.draw(self.buttons)

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = window.get_center_y() - self.icon:getHeight() * 1.5
    love.graphics.draw(self.icon, iconX, iconY)
end
