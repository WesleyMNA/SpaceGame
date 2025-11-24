require('src.gui.button')

local game = require('src.utils.game')
local window = require('src.utils.window')

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(manager)
    local this = {
        _manager = manager,
        _icon = love.graphics.newImage('sprites/gui/headers/record.png'),
    }
    this._buttons = {
        menu = Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/menu.png',
            function()
                this._manager:switch_gui('menu')
            end
        ),
        play = Button:new(
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
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = window.get_center_x() - self._icon:getWidth() / 2
    local iconY = 25
    love.graphics.draw(self._icon, iconX, iconY)

    local printX = window.get_center_x() - 50
    local printY = iconY + self._icon:getHeight()
    love.graphics.print(math.floor(RECORD) .. ' seconds', printX, printY, 0, 2, 2)

    game.draw(self._buttons)

    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.print('Current points: ' .. POINTS, 0, 0)
end
