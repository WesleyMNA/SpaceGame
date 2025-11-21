require('src.gui.button')

local window = require('src.utils.window')

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(manager)
    local this = {
        class = 'GameOver',
        manager = manager,
        icon = love.graphics.newImage('sprites/gui/headers/record.png'),
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

function GameOver:update(dt)
    if RECORD < TIMER then
        RECORD = TIMER
    end

    save()
end

function GameOver:mousepressed(x, y)
    if self.menu_button:is_clicked(x, y) then CURRENT_GUI = 'menu' end

    if self.play_button:is_clicked(x, y) then CURRENT_GUI = 'selection' end
end

function GameOver:draw()
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = 25
    love.graphics.draw(self.icon, iconX, iconY)

    local printX = window.get_center_x() - 50
    local printY = iconY + self.icon:getHeight()
    love.graphics.print(math.floor(RECORD) .. ' seconds', printX, printY, 0, 2, 2)

    self.menu_button:draw()
    self.play_button:draw()

    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.print('Current points: ' .. POINTS, 0, 0)
end
