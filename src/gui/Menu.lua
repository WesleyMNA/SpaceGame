require('src.gui.button')
require('src.gui.drawable')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

local function create_icon()
    local image = love.graphics.newImage('sprites/gui/menu/icon.png')
    return Drawable:new(
        screen.centralize_image_in_x(image),
        20,
        image
    )
end

Menu = {}
Menu.__index = Menu

function Menu:new(manager)
    local this = {
        _manager = manager,
        _icon = create_icon(),
    }
    this._buttons = {
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
    game.mousepressed(self._buttons, x, y)
end

function Menu:draw()
    self._icon:draw()
    game.draw(self._buttons)
end
