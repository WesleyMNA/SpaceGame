require('src.gui.button')

local game = require('src.utils.game')
local window = require('src.utils.window')

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(manager)
    local this = {
        class = 'GameOver',
        manager = manager,
        icon = love.graphics.newImage('sprites/gui/headers/record.png'),
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
                    CURRENT_GUI = 'selection'
                end
            )
        }
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
    game.mousepressed(self.buttons, x, y)
end

function GameOver:draw()
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = 25
    love.graphics.draw(self.icon, iconX, iconY)

    local printX = window.get_center_x() - 50
    local printY = iconY + self.icon:getHeight()
    love.graphics.print(math.floor(RECORD) .. ' seconds', printX, printY, 0, 2, 2)

    game.draw(self.buttons)

    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.print('Current points: ' .. POINTS, 0, 0)
end
