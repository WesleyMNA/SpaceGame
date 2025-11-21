local window = require('src.utils.window')

Pause = {}
Pause.__index = Pause

function Pause:new()
    local this = {
        class = 'Pause',
        icon = love.graphics.newImage('sprites/gui/headers/pause.png'),
        menu_button = Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/menu.png'
        ),
        play_button = Button:new(
            window.get_center_x() + 50,
            window.get_center_y(),
            'sprites/gui/buttons/play.png'
        )
    }

    setmetatable(this, self)
    return this
end

function Pause:mousepressed(x, y)
    if self.play_button:is_clicked(x, y) then CURRENT_GUI = 'map' end

    if self.menu_button:is_clicked(x, y) then CURRENT_GUI = 'menu' end
end

function Pause:render()
    self.menu_button:render()
    self.play_button:render()

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = window.get_center_y() - self.icon:getHeight() * 1.5
    love.graphics.draw(self.icon, iconX, iconY)
end
