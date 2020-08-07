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

    local buttonIcon = love.graphics.newImage('sprites/gui/menu/exit.png')
    local buttonX = (WINDOW_WIDTH / 2) - buttonIcon:getWidth()/2
    local buttonY = 280
    this.exitButton = Button:new(buttonX, buttonY, buttonIcon)

    setmetatable(this, self)
    return this
end

function Menu:update(dt)
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'menu' then return end

        if self.startButton:isClicked() then CURRENT_GUI = 'selection' end

        if self.exitButton:isClicked() then love.event.quit('exit') end
    end
end

function Menu:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    self.startButton:render()
    self.exitButton:render()

    local iconX = (WINDOW_WIDTH / 2) - self.icon:getWidth()/2
    love.graphics.draw(self.icon, iconX, 20)
end

