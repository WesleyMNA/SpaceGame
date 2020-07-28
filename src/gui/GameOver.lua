require('src.gui.Button')

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(background, manager)
    local this = {
        class = 'GameOver',

        icon = love.graphics.newImage('sprites/gui/game_over/record.png'),
        background = background,
        manager = manager
    }

    local menuIcon = love.graphics.newImage('sprites/gui/buttons/menu.png')
    local menuX = (WINDOW_WIDTH / 2) - 100
    local menuY = WINDOW_HEIGHT / 2
    this.menuButton = Button:new(menuX, menuY, menuIcon)
    this.menuButton.update = function(dt)
        if love.mouse.isDown(1) and isClikingOnButton(this.menuButton) then
            CURRENT_GUI = 'menu'
        end
    end

    local playIcon = love.graphics.newImage('sprites/gui/buttons/play.png')
    local playX = WINDOW_WIDTH / 2 + 50
    local playY = WINDOW_HEIGHT / 2
    this.playButton = Button:new(playX, playY, playIcon)
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
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    love.graphics.setColor(255, 255, 255, 1)
    local iconX = WINDOW_WIDTH/2 - self.icon:getWidth()/2
    local iconY = 50
    love.graphics.draw(self.icon, iconX, iconY)

    local printX = WINDOW_WIDTH/2
    local printY = iconY +  self.icon:getHeight()
    love.graphics.print(POINTS, printX, printY, 0, 3, 3)

    self.menuButton:render()
    self.playButton:render()
end
