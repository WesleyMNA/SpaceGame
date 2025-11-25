require('src.gui.button')
require('src.gui.drawable')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

local function create_icon()
    local image = love.graphics.newImage('sprites/gui/headers/record.png')
    return Drawable:new(
        screen.centralize_image_in_x(image),
        20,
        image
    )
end

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(manager)
    local this = {
        _manager = manager,
        _icon = create_icon(),
    }
    this._buttons = {
        Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/menu.png',
            function()
                this._manager:switch_gui('menu')
            end
        ),
        Button:new(
            window.get_center_x() + 50,
            window.get_center_y(),
            'sprites/gui/buttons/play.png',
            function()
                this._manager:switch_gui('selection')
            end
        )
    }

    setmetatable(this, self)
    return this
end

function GameOver:update(dt)
    if RECORD < TIMER then
        RECORD = TIMER
    end

    save()
end

function GameOver:mousepressed(x, y)
    game.mousepressed(self._buttons, x, y)
end

function GameOver:draw()
    self._icon:draw()
    local printX = window.get_center_x() - 50
    local printY = window.get_center_y() - 50
    love.graphics.print(math.floor(RECORD) .. ' seconds', printX, printY, 0, 2, 2)

    game.draw(self._buttons)

    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.print('Current points: ' .. POINTS, 0, 0)
end
