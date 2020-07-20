require('src.gui.Button')

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(manager)
    local this = {
        class = 'GameOver',

        manager = manager
    }

    this.menuButton = Button:new(
        (WINDOW_WIDTH / 2) - 100,
        (WINDOW_HEIGHT / 2),
        50, 20, 'Menu'
    )
    this.menuButton.update = function(dt)
        if love.mouse.isDown(1) and isClikingOnButton(this.menuButton) then
            CURRENT_GUI = 'menu'
        end
    end

    this.playButton = Button:new(
        (WINDOW_WIDTH / 2),
        (WINDOW_HEIGHT / 2) ,
        70, 20, 'Play again'
    )
    this.playButton.update = function(dt)
        if love.mouse.isDown(1) and isClikingOnButton(this.playButton) then
            CURRENT_GUI = 'selection'
        end
    end

    setmetatable(this, self)
    return this
end

function GameOver:update(dt)
    self.menuButton.update(dt)
    self.playButton.update(dt)
end

function GameOver:render()
    self.menuButton:render()
    self.playButton:render()
end
