require('src.gui.button')

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(background, manager)
    local this = {
        class = 'GameOver',

        icon = love.graphics.newImage('sprites/gui/headers/record.png'),
        background = background,
        manager = manager
    }

    local menuIcon = love.graphics.newImage('sprites/gui/buttons/menu.png')
    local menuX = (WINDOW_WIDTH / 2) - 100
    local menuY = WINDOW_HEIGHT / 2
    this.menuButton = Button:new(menuX, menuY, menuIcon)

    local playIcon = love.graphics.newImage('sprites/gui/buttons/play.png')
    local playX = WINDOW_WIDTH / 2 + 50
    local playY = WINDOW_HEIGHT / 2
    this.playButton = Button:new(playX, playY, playIcon)

    setmetatable(this, self)
    return this
end

function GameOver:update(dt)
    if RECORD < TIMER then
        RECORD = TIMER
    end
    
    save()
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'gameOver' then return end
                
        if self.menuButton:is_clicked() then CURRENT_GUI = 'menu' end

        if self.playButton:is_clicked() then CURRENT_GUI = 'selection' end
    end
end

function GameOver:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    love.graphics.setColor(255, 255, 255, 1)
    local iconX = WINDOW_WIDTH/2 - self.icon:getWidth()/2
    local iconY = 25
    love.graphics.draw(self.icon, iconX, iconY)

    local printX = WINDOW_WIDTH/2 - 50
    local printY = iconY +  self.icon:getHeight()
    love.graphics.print(math.floor(RECORD) ..' seconds', printX, printY, 0, 2, 2)

    self.menuButton:render()
    self.playButton:render()

    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.print('Current points: '.. POINTS, 0, 0)
end
