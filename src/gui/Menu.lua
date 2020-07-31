require('src.gui.Button')

Menu = {}
Menu.__index = Menu

function Menu:new(background)
    local this = {
        class = 'Menu',

        icon = love.graphics.newImage('sprites/gui/menu/icon.png'),
        background = background
    }

    local buttonIcon = love.graphics.newImage('sprites/gui/menu/start.png')
    local buttonX = (WINDOW_WIDTH / 2) - buttonIcon:getWidth()/2
    local buttonY = 230
    this.startButton = Button:new(buttonX, buttonY, buttonIcon)
    this.startButton.update = function(dt)
        if love.mouse.isDown(1) and isClikingOnButton(this.startButton) then
            CURRENT_GUI = 'selection'
        end
    end

    local buttonIcon = love.graphics.newImage('sprites/gui/menu/exit.png')
    local buttonX = (WINDOW_WIDTH / 2) - buttonIcon:getWidth()/2
    local buttonY = 280
    this.exitButton = Button:new(buttonX, buttonY, buttonIcon)
    this.exitButton.update = function(dt)
        if love.mouse.isDown(1) and isClikingOnButton(this.exitButton) then
            print('exit')
        end
    end

    setmetatable(this, self)
    return this
end

function Menu:update(dt)
    self.startButton.update(dt)
    self.exitButton.update(dt)
end

function Menu:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    self.startButton:render()
    self.exitButton:render()

    local iconX = (WINDOW_WIDTH / 2) - self.icon:getWidth()/2
    love.graphics.draw(self.icon, iconX, 20)
end

