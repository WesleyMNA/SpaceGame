local window = require('src.utils.window')

Pause = {}
Pause.__index = Pause

function Pause:new(background)
    local this = {
        class = 'Pause',
        background = background,
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

function Pause:update(dt)
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'pause' then return end

        if self.play_button:is_clicked() then CURRENT_GUI = 'map' end

        if self.menu_button:is_clicked() then CURRENT_GUI = 'menu' end
    end
end

function Pause:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    self.menu_button:render()
    self.play_button:render()

    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = window.get_center_y() - self.icon:getHeight() * 1.5
    love.graphics.draw(self.icon, iconX, iconY)
end
