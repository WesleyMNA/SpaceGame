require('src.gui.drawable')

local game = require('src.utils.game')
local window = require('src.utils.window')

local function create_icon()
    local image = love.graphics.newImage('sprites/gui/headers/pause.png')
    return Drawable:new(
        image,
        window.get_center_x() - image:getWidth() / 2,
        window.get_center_y() - image:getHeight() * 1.5
    )
end


Pause = {}
Pause.__index = Pause

function Pause:new(manager)
    local this = {
        _manager = manager,
        _icon = create_icon(),
    }
    this._buttons = {
        menu = Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/menu.png',
            function()
                manager:switch_gui('menu')
            end
        ),
        play = Button:new(
            window.get_center_x() + 50,
            window.get_center_y(),
            'sprites/gui/buttons/play.png',
            function()
                manager:switch_gui('map')
            end
        )
    }

    setmetatable(this, self)
    return this
end

function Pause:mousepressed(x, y)
    game.mousepressed(self._buttons, x, y)
end

function Pause:draw()
    self._icon:draw()
    game.draw(self._buttons)
end
